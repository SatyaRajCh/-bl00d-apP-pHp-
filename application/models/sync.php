<?php

/**
 * Sync Model
 *
 * PHP version 5
 *
 * LICENSE: This source file is subject to version 3.01 of the PHP license
 * that is available through the world-wide-web at the following URI:
 * http://www.php.net/license/3_01.txt.  If you did not receive a copy of
 * the PHP License and are unable to obtain it through the web, please
 * send a note to license@php.net so we can mail you a copy immediately.
 *
 * @category    Sync.php
 * @package     Models
 * @author      Vijay.Ch <vijay.ch@vendus.com>
 * @license     http://www.opensource.org/licenses/mit-license.php MIT License
 * @link        http://localhost/medicare/index.php/
 * @dateCreated 10/28/2015  MM/DD/YYYY
 * @dateUpdated 10/28/2015  MM/DD/YYYY 
 * @functions   01
 */

/**
 * User.php
 *
 * @category Sync.php
 * @package  Models
 * @author   Vijay.ch <vijay.ch@vendus.com>
 * @license  http://www.opensource.org/licenses/mit-license.php MIT License
 * @link     http://local.sureify.com/user
 */
class Sync extends Base_model
{

    protected $table = 'users';
    protected $app_users = 'app_users';
    protected $user_steps = 'user_steps';
    protected $user_calories = 'user_calories';
    protected $user_sessions = 'user_sessions';
    protected $user_weights = 'user_weights';
    protected $devices = "devices_master";
    protected $policies = "policy_kit_master";
    protected $user_savings = 'user_savings';
    protected $user_devices = "user_devices";

    /**
     * Construct
     * @return void
     * @throws NotFoundException When the view file could not be found
     *    or MissingViewException in debug mode.
     */
    public function __construct() 
    {

        parent::__construct();
        $this->load->database();
        $this->load->dbutil();
        $this->load->helper('file');
        $this->load->helper('download');
    }

    /**
     * Add user fitbit data (steps, weight and calories)
     * @param array $insert_data_array          insert data array
     * @param array $fitbit_devices_insert_data devices data array
     * @param int   $user_id                    user id
     * @return 1 or 0 based on transaction 
     */
    public function AddSyncedUserFitbitData($insert_data_array, $fitbit_devices_insert_data = array(), $user_id = "") 
    {
        try {
            $this->db->trans_begin();

            if (count($fitbit_devices_insert_data) > 0) {
                //update previous records for that date with rec status 0
                $this->db->where('user_id', $user_id);
                $update_devices = $this->db->update($this->user_devices, array('row_status' => 0));

                //insert new devices data for user
                $insert_devices = $this->db->insert_batch($this->user_devices, $fitbit_devices_insert_data);
            }


            if (count($insert_data_array) > 0) {
                foreach ($insert_data_array as $ia) {
                    //update previous records for that date with rec status 0
                    $this->db->where('DATE_FORMAT(' . $ia['date_field'] . ',"%Y-%m-%d") >= ', $ia['date_value']);
                    $this->db->where('user_id', $ia['user_id']);
                    $result = $this->db->update($ia['table_name'], array('row_status' => 0));

                    //insert new steps data for user
                    $result = $this->db->insert_batch($ia['table_name'], $ia['insert_data']);
                }
            } else {
                return 1;
            }


            //echo $this->db->_error_message();
            if ($this->db->trans_status() === false) {
                $this->db->trans_rollback();
                return 0;
            } else {
                $this->db->trans_commit();
                return 1;
            }
        } catch (Exception $e) {
            echo $this->db->_error_message();
            exit;
            log_message('error', $this->db->_error_message());
            $this->db->trans_rollback();
            return 0;
        }
    }

    

    /**
     * Sync user fitbit
     * @param array $user_data data array
     * @return 1 or 0 based on transaction 
     */
    public function syncUserFitbit($user_data) 
    {
        $loggedin_user = $user_data;

        $user_session_data = $this->session->userdata('app_user_data');
        //echo "<pre>";print_r($user_session_data);exit;
        
        if(array_key_exists('user_session_id',$loggedin_user) && $loggedin_user['user_session_id']!="")
        {
            $user_session_id =  $loggedin_user['user_session_id'];            
        }
        elseif(count($user_session_data)>0 && $user_session_data->user_session_id!="")
        {
            $user_session_id = $user_session_data->user_session_id ;             
        }    

        if ($loggedin_user['fitbit_access_token'] != "") {
            $GLOBALS['fitbit_access_token'] = $loggedin_user['fitbit_access_token'];
            //echo  $GLOBALS['fitbit_access_token']."<br/>";

            $date_to_start = date("Y-m-d", strtotime("-10 day"));
            $date_to_fetch = $date_to_start;
            $weight_date_to_fetch = $date_to_start;
            $current_date = date("Y-m-d");

            //get user fitbit devices START
            $fitbit_devices_data = $this->fitbitapi->getFitbitDevicesData();
            //echo "<pre>";print_r($fitbit_devices_data);exit;   
            $this->fitbitapi->resetAccessToken();
            //get user fitbit devices END 
            //get user fitbit devices data from database START
            $user_fitbit_devices = $this->user->getUserDevices(array('user_id' => $loggedin_user['id']));
            //echo "<pre>";print_r($user_fitbit_devices);exit;
            //get user fitbit devices data from database END

            if (count($user_fitbit_devices) > 0) {
                foreach ($user_fitbit_devices as $uf) {
                    if ($uf['type'] == "TRACKER") {
                        $date_array = changeFitbitDateFormat($uf['last_sync_time']);
                        //echo "<pre>"; print_r($date_array); EXIT;
                        $date_to_fetch = $date_array['date'];
                    }
                    if ($uf['type'] == "SCALE") {
                        $date_array = changeFitbitDateFormat($uf['last_sync_time']);
                        $weight_date_to_fetch = $date_array['date'];
                    }
                }
            } elseif (count($fitbit_devices_data['data']) > 0) {
                foreach ($fitbit_devices_data['data'] as $uf) {
                    if ($uf->type == "TRACKER") {
                        $date_array = changeFitbitDateFormat($uf->lastSyncTime);
                        //echo "<pre>"; print_r($date_array); EXIT;
                        $date_to_fetch = $date_array['date'];
                    }
                    if ($uf->type == "SCALE") {
                        $date_array = changeFitbitDateFormat($uf->lastSyncTime);
                        $weight_date_to_fetch = $date_array['date'];
                    }
                }
            }


            //get steps data to insert data START
            $fitbit_user_steps_data = $this->fitbitapi->getStepsData($current_date, $date_to_fetch);
            //echo "<pre>";print_r($fitbit_user_steps_data);exit;
            $this->fitbitapi->resetAccessToken();
            $user_steps_insert_data = array();
            if (is_object($fitbit_user_steps_data['data']) && property_exists($fitbit_user_steps_data['data'], "activities-steps")) {
                $steps_data = $fitbit_user_steps_data['data']->{'activities-steps'};
                //echo "<pre>";print_r($steps_data);exit;

                $data_count = count($steps_data);
                if ($data_count > 0) {
                    for ($a = 0; $a < $data_count; $a++) {
                        $user_steps_insert_data[] = array('user_id' => $loggedin_user['id'], 'steps' => $steps_data[$a]->value, 'steps_date' => $steps_data[$a]->dateTime,'user_session_id'  => $user_session_id,'created_time' => date('Y-m-d H:i:s')); 
                    }
                }
            }
            //get steps data to insert data END
            //get weight data to insert data START
            $fitbit_user_weight_data = $this->fitbitapi->getWeightData($weight_date_to_fetch, $current_date);
            //echo "<pre>";print_r($fitbit_user_weight_data);exit;
            $this->fitbitapi->resetAccessToken();
            $user_weight_insert_data = array();
            if (is_object($fitbit_user_weight_data['data']) && property_exists($fitbit_user_weight_data['data'], "weight")) {
                $weights_data = $fitbit_user_weight_data['data']->{'weight'};
                //echo "<pre>";print_r($weights_data);exit;
                if (count($weights_data) > 0) {
                    foreach ($weights_data as $w) {
                        $user_weight_insert_data[] = array(
                            'user_id' => $loggedin_user['id'],
                            'bmi' => $w->bmi,
                            'weight_date' => $w->date,
                            'log_id' => $w->logId,
                            'weight_time' => $w->time,
                            'weight' => $w->weight,
                            'created_time' => date('Y-m-d H:i:s'),
                            'user_session_id' => $user_session_id
                        );
                    }
                }
            }
            //get weight data to insert data END
            //get calories data to insert START
            $fitbit_user_calories_data = $this->fitbitapi->getCaloriesData($current_date, $date_to_fetch);
            //echo "<pre>";print_r($fitbit_user_data);exit;
            $this->fitbitapi->resetAccessToken();

            if (is_object($fitbit_user_calories_data['data']) && property_exists($fitbit_user_calories_data['data'], "activities-calories")) {
                $calories_data = $fitbit_user_calories_data['data']->{'activities-calories'};
                //echo "<pre>";print_r($calories_data);

                $data_count = count($calories_data);
                if ($data_count > 0) {
                    for ($a = 0; $a < $data_count; $a++) {
                        $user_calories_insert_data[] = array('user_id' => $loggedin_user['id'], 'calories' => $calories_data[$a]->value, 'calories_date' => $calories_data[$a]->dateTime,'user_session_id'  => $user_session_id,'created_time' => date('Y-m-d H:i:s')); 
                    }
                }
            }
            //get calories data to insert END
        }

        $all_insert_data = array();

        if (count($user_steps_insert_data) > 0) {
            $all_insert_data[] = array(
                'table_name' => USER_STEPS,
                'user_id' => $loggedin_user['id'],
                'date_field' => 'steps_date',
                'date_value' => $date_to_fetch,
                'insert_data' => $user_steps_insert_data
            );
        }

        if (count($user_weight_insert_data) > 0) {
            $all_insert_data[] = array(
                'table_name' => USER_WEIGHTS,
                'user_id' => $loggedin_user['id'],
                'date_field' => 'weight_date',
                'date_value' => $weight_date_to_fetch,
                'insert_data' => $user_weight_insert_data
            );
        }


        if (count($user_calories_insert_data) > 0) {
            $all_insert_data[] = array(
                'table_name' => USER_CALORIES,
                'user_id' => $loggedin_user['id'],
                'date_field' => 'calories_date',
                'date_value' => $date_to_fetch,
                'insert_data' => $user_calories_insert_data
            );
        }
        //echo "<pre>";print_r($all_insert_data);exit;
        //store user devices in database START
        //echo "Hi<pre>";print_r($fitbit_devices_data);exit;   
        $fitbit_devices_insert_data = array();
        if (count($fitbit_devices_data['data']) > 0) {
            foreach ($fitbit_devices_data['data'] as $d) {
                $fitbit_devices_insert_data[] = array(
                    'user_id' => $loggedin_user['id'],
                    'battery' => $d->battery,
                    'device_version' => $d->deviceVersion,
                    'features' => serialize($d->features),
                    'fitbit_device_id' => $d->id,
                    'last_sync_time' => $d->lastSyncTime,
                    'mac' => $d->mac,
                    'type' => $d->type,
                    'created_time' => date('Y-m-d H:i:s'),
                    'user_session_id' => $user_session_id
                );
            }
        }
        //echo "<pre>";print_r($fitbit_devices_insert_data);exit;   
        //store user devices in database END

        $result = $this->AddSyncedUserFitbitData($all_insert_data, $fitbit_devices_insert_data, $loggedin_user['id']);
        return $result;
    }

}
