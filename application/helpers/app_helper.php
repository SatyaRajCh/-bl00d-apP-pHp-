<?php
function setOutputJson($output = "") {
    $CI = & get_instance();
    $CI->output->set_header('Content-Type: application/json', TRUE);
    if (!empty($output)) {
        $output = (is_array($output)) ? json_encode($output) : (string) $output;
    }
    $CI->output->set_output($output);
}

// validations makes easy, presntly works only for required.
function requiredValidation($inputs = array()) {
    $instance = & get_instance();
    foreach ($inputs as $name) {
        $instance->form_validation->set_rules($name, humanize($name), 'required');
    }
}

// function humanize($str) 
// {
// 	$str = trim(strtolower($str));
// 	$str = preg_replace('/[^a-z0-9\s+]/', ' ', $str);
// 	$str = preg_replace('/\s+/', ' ', $str);
// 	$str = explode(' ', $str);
// 	$str = array_map('ucwords', $str);
// 	return implode(' ', $str);
// }


function renderWithLayout($contentArray, $layout = 'app') {
    if (!$layout) {
        die('$layout argument missing!');
    }
    $instance = & get_instance();
    $instance->load->view('layouts/' . $layout, $contentArray);
}

/**
 * gets multiple partials
 * @param  array $files
 * @return array
 */
function getPartials($files) {
    $instance = &get_instance();
    $partials = array();
    foreach ($files as $file => $path) {
        if (is_array($path)) {
            $info = $path;
            $partials[$file] = $instance->load->view($info['path'], $info['data'], true);
        } else {
            $partials[$file] = $instance->load->view($path, array(), true);
        }
    }
    return $partials;
}

function renderPartial($file, $data = array()) {
    $fParts = explode('/', $file);
    $lastPart = $fParts[count($fParts) - 1];
    $instance = &get_instance();
    $realFile = str_replace($lastPart, '_' . $lastPart, $file);
    $instance->load->view($realFile, $data);
}

function getVersion() {
    $allowedVersions = array('1', '2', '3', '2a', '2b');
    $instance = &get_instance();
    // setting the version of the app
    $version = $instance->input->get('v');
    $sessionVersion = $instance->session->userdata('version');

    // setting version as v1 if both are empty
    if (empty($version) && empty($sessionVersion)) {
        $instance->session->set_userdata('version', '2b');
    } else if (!empty($version)) {
        // setting version requested by user
        if (in_array($version, $allowedVersions)) {
            $v = $version;
        } else {
            $v = '1';
        }
        $instance->session->set_userdata('version', $version);
    }
    return $instance->session->userdata('version');
}

function versionedView($view, $mobile = false) {
    $v = getVersion();
    if ($mobile && isMobile()) {
        $parts = explode('/', $view);
        $view = str_replace($parts[count($parts) - 1], 'mobile/' . $parts[count($parts) - 1], $view);
    }
    if ($v == '1') {
        return $view;
    }
    return $view . '_v' . $v;
}

function mobileCompatibleView($view) {
    if (isMobile()) {
        $parts = explode('/', $view);
        $view = str_replace($parts[count($parts) - 1], 'mobile/' . $parts[count($parts) - 1], $view);
    }
    return $view;
}

function sendEmail($to, $from, $subject, $message) {
    // Always set content-type when sending HTML email
    /*$headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

    // More headers
    $headers .= "From: <{$from}>" . "\r\n";
    // $headers .= 'Cc: myboss@example.com' . "\r\n";
    mail($to, $subject, $message, $headers);*/
    $ci =& get_instance();
        $ci->load->library('email');
        $ci->email->set_newline("\r\n");
        $ci->email->from($from);
        $to_emails = array("" , $to);
        $ci->email->to($to_emails);
        $ci->email->set_mailtype('html');
        $ci->email->subject($subject);
        $userDetails = array(
            'email' => $email,
        );
        $data["userDetails"] = $userDetails;
        //echo $msg;exit;
        $ci->email->message($message);
        $ci->email->send();
        $ci->email->clear(true);
}

function isMobile() {
    $userAgent = $_SERVER['HTTP_USER_AGENT'];
    if (stripos($userAgent, 'mobile') !== false) {
        return true;
    }
    return false;
}

function getPlanData($plan) {
    if ($plan == '$250,000') {
        return array('plan_type' => 'Basic', 'plan_amount' => '250k', 'plan_amount_full' => '250,000', 'image' => 'bronze_image', 'image_name' => 'Fitbit Flex + Aria Scale', 'box_bg' => 'bronze_box_bg', 'color' => '#d34b5c', 'devices' => array('Fitbit Flex', 'Aria Scale'), 'device_images' => array('plan_fitbit_flex_m.png'));
    } elseif ($plan == '$500,000') {
        return array('plan_type' => 'Pro', 'plan_amount' => '500k', 'plan_amount_full' => '500,000', 'image' => 'silver_image', 'image_name' => 'Fitbit Flex + Aria Scale', 'box_bg' => 'silver_box_bg', 'color' => '#e1a246', 'devices' => array('Fitbit Flex', 'Aria Scale'), 'device_images' => array('plan_fitbit_flex_m.png'));
    } elseif ($plan == '$750,000') {
        return array('plan_type' => 'Premium', 'plan_amount' => '750k', 'plan_amount_full' => '750,000', 'image' => 'gold_image', 'image_name' => 'Fitbit ChargeHR + Aria Scale', 'box_bg' => 'gold_box_bg', 'color' => '#557ac1', 'devices' => array('Fitbit ChargeHR', 'Aria Scale'), 'device_images' => array('plan_fitbit_charge_m.png'));
    } elseif ($plan == '$1,000,000') {
        return array('plan_type' => 'Ultimate', 'plan_amount' => '1m', 'plan_amount_full' => '1,000,000', 'image' => 'platinum_image', 'image_name' => 'Fitbit Surge + Aria Scale', 'box_bg' => 'platinum_box_bg', 'color' => '#bdd467', 'devices' => array('Fitbit Surge', 'Aria Scale'), 'device_images' => array('plan_fitbit_surge_m.png'));
    }
    return array('plan_type' => 'Basic', 'plan_amount' => '250k', 'plan_amount_full' => '250,000', 'image' => 'bronze_image', 'image_name' => 'Fitbit Flex + Aria Scale', 'box_bg' => 'bronze_box_bg', 'color' => '#d34b5c', 'devices' => array('Fitbit Flex', 'Aria Scale'), 'device_images' => array('plan_fitbit_flex_m.png'));
}

function objectToArray($d) {
    if (is_object($d)) {
        // Gets the properties of the given object
        // with get_object_vars function
        $d = get_object_vars($d);
    }

    if (is_array($d)) {
        /*
         * Return array converted to object
         * Using __FUNCTION__ (Magic constant)
         * for recursive call
         */
        return array_map(__FUNCTION__, $d);
    } else {
        // Return array
        return $d;
    }
}

/**
 * add user data
 * @param $array array
 * @param $keySearch string 
 * @return boolean key found or not  
 */
function findKey($array, $keySearch) {
    foreach ($array as $key => $item) {
        if ($key == $keySearch) {
            //echo 'yes, it exists';
            return true;
        } else {
            if (is_array($item) && findKey($item, $keySearch)) {
                return true;
            }
        }
    }

    return false;
}

/**
 * returns min and max date from array
 * @param $date1_timestamp string mindate timestamp
 * @param $date2_timestamp string maxdate timestamp
 * @return $months array list of all months between dates
 */
function get_months($date1_timestamp, $date2_timestamp) {
    $time1 = $date1_timestamp;
    $time2 = $date2_timestamp;

    $time1 = strtotime(date('Y-m', $time1) . '-01');
    $time2 = strtotime(date('Y-m', $time2) . '-01');

    $my = date('mY', $time2);

    $months[] = array('month_name_year' => date('M Y', $time1), 'timestamp' => $time1, 'month_num_year' => date('mY', $time1));

    while ($time1 < $time2) {
        $time1 = strtotime(date('Y-m-d', $time1) . ' +1 month');
        if (date('mY', $time1) != $my && ($time1 < $time2))
            $months[] = array('month_name_year' => date('M Y', $time1), 'timestamp' => $time1, 'month_num_year' => date('mY', $time1));
    }

    //$months[] = array(date('M Y', $time2),$time2,date('mY', $time2));
    $months[] = array('month_name_year' => date('M Y', $time2), 'timestamp' => $time2, 'month_num_year' => date('mY', $time2));
    $months = array_unique($months, SORT_REGULAR);
    //echo "<pre>";print_r($months);exit;
    return $months;
}

/**
 * returns users savings in terms of months
 * @param $user_profile_data array
 * @param $user_savings array 
 * @return $result array which consists of all months premiums  
 */
function getUserMonthlyPremium($user_profile_data, $user_savings) {
    $result = array();
    $all_months = array();
    $current_date_timestamp = strtotime(date("Y-m-d"));
    $user_created_date_timestamp = strtotime($user_profile_data->created_date);
    //echo $current_date_timestamp;exit;
    if ($user_created_date_timestamp < $current_date_timestamp) {
        $all_months = get_months($user_created_date_timestamp, $current_date_timestamp);
    }

    if (count($all_months) > 0) {
        foreach ($all_months as $m) {
            $found = array();
            if (count($user_savings) > 0) {
                foreach ($user_savings as $us) {
                    $user_savings_timestamp = mktime(0, 0, 0, $us['month'], 1, $us['year']);
                    if ($m['timestamp'] == $user_savings_timestamp) {
                        $found = $us;
                    }
                }
            }

            //echo "<pre>";print_r($found);

            if (count($found) > 0) {
                $m['premium'] = $found['premium_rate'];
                $m['weight_goal_discount'] = $found['weight_goal_discount'];
                $m['weight_goal_date'] = $found['weight_goal_date'];
                $m['weight_maintenance_discount'] = $found['weight_maintenance_discount'];
                $m['steps_goal_discount'] = $found['steps_goal_discount'];
            } else {
                $m['premium'] = $user_profile_data->initial_premium_rate;
                $m['weight_goal_discount'] = 0;
                $m['weight_goal_date'] = "";
                $m['weight_maintenance_discount'] = 0;
                $m['steps_goal_discount'] = 0;
            }
            $result[] = $m;
        }
    }
    return $result;
}

/**
 * returns users life time savings 
 * @param $user_profile_data array
 * @param $user_savings array 
 * @return $result array which consists of lifetime savings  
 */
function getUserLifetimeSavings($user_profile_data, $user_savings) {
    $return_array = array();
    //echo "<pre>";print_r($user_savings);exit;
    $each_month_saving = array();
    $current_month_array = array();
    $initial_premium_rate = 0;
    $projected_savings = 0;
    $current_month_premium = 0;
    $current_month_saving = 0;
    $original_savings = 0;
    $term_length = 0;
    $no_of_months = 0;
    $projected_months_count = 0;
    $lifetime_savings = 0;

    if (is_object($user_profile_data)) {
        $initial_premium_rate = $user_profile_data->initial_premium_rate;
        $term_length = $user_profile_data->term_length;
    }

    if (count($user_savings) > 0) {
        $current_month_array = $user_savings[0];
        $current_month_saving = ($initial_premium_rate > $current_month_array['premium_rate']) ? ($initial_premium_rate - $current_month_array['premium_rate']) : 0;
        foreach ($user_savings as $us) {
            if ($initial_premium_rate > $us['premium_rate']) {
                $each_month_saving[] = $initial_premium_rate - $us['premium_rate'];
            } else {
                $each_month_saving[] = 0;
            }
        }

        $original_savings = array_sum($each_month_saving);
        $no_of_months = count($each_month_saving);
        $projected_months_count = ($term_length * 12) - $no_of_months;

        $projected_savings = $projected_months_count * $current_month_saving;

        $lifetime_savings = $projected_savings + $original_savings;
    }

    $return_array['lifetime_savings'] = $lifetime_savings;
    $return_array = array_merge($return_array, $current_month_array);
    //echo "<pre>";print_r($return_array);exit;

    return $return_array;
}

function check_empty_values($assoc_array) {
    if (count($assoc_array) > 0) {
        foreach ($assoc_array as $key => $value) {
            if ($value == "")
                return true;
        }
        return false;
    }
}

function changeFitbitDateFormat($date) {
    $return_date_array = array();
    if ($date != "") {
        $date_array = explode("T", $date);
        $date = $date_array[0];
        $time = substr($date_array[1], 0, strlen($date_array[1]) - 4);
        $return_date_array = array('date' => $date, 'time' => $time);
    }
    return $return_date_array;
}
/**
 * getOS
 * @global type $user_agent
 * @return string
 */
function getOS() {
    $user_agent     =   $_SERVER['HTTP_USER_AGENT'];

    
    $os_platform = "Unknown OS Platform";

    $os_array = array(
        '/windows nt 10/i' => 'Windows 10',
        '/windows nt 6.3/i' => 'Windows 8.1',
        '/windows nt 6.2/i' => 'Windows 8',
        '/windows nt 6.1/i' => 'Windows 7',
        '/windows nt 6.0/i' => 'Windows Vista',
        '/windows nt 5.2/i' => 'Windows Server 2003/XP x64',
        '/windows nt 5.1/i' => 'Windows XP',
        '/windows xp/i' => 'Windows XP',
        '/windows nt 5.0/i' => 'Windows 2000',
        '/windows me/i' => 'Windows ME',
        '/win98/i' => 'Windows 98',
        '/win95/i' => 'Windows 95',
        '/win16/i' => 'Windows 3.11',
        '/macintosh|mac os x/i' => 'Mac OS X',
        '/mac_powerpc/i' => 'Mac OS 9',
        '/linux/i' => 'Linux',
        '/ubuntu/i' => 'Ubuntu',
        '/iphone/i' => 'iPhone',
        '/ipod/i' => 'iPod',
        '/ipad/i' => 'iPad',
        '/android/i' => 'Android',
        '/blackberry/i' => 'BlackBerry',
        '/webos/i' => 'Mobile'
    );

    foreach ($os_array as $regex => $value) {

        if (preg_match($regex, $user_agent)) {
            $os_platform = $value;
        }
    }

    return $os_platform;
}
/**
 * getBrowser
 * @global type $user_agent
 * @return string
 */
function getBrowser() {
    $user_agent     =   $_SERVER['HTTP_USER_AGENT'];
    $browser = "Unknown Browser";

    $browser_array = array(
        '/msie/i' => 'Internet Explorer',
        '/firefox/i' => 'Firefox',
        '/safari/i' => 'Safari',
        '/chrome/i' => 'Chrome',
        '/opera/i' => 'Opera',
        '/netscape/i' => 'Netscape',
        '/maxthon/i' => 'Maxthon',
        '/konqueror/i' => 'Konqueror',
        '/mobile/i' => 'Handheld Browser'
    );

    foreach ($browser_array as $regex => $value) {

        if (preg_match($regex, $user_agent)) {
            $browser = $value;
        }
    }

    return $browser;
}
