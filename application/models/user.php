<?php

/**
 * User Model
 *
 * PHP version 5
 *
 * LICENSE: This source file is subject to version 3.01 of the PHP license
 * that is available through the world-wide-web at the following URI:
 * http://www.php.net/license/3_01.txt.  If you did not receive a copy of
 * the PHP License and are unable to obtain it through the web, please
 * send a note to license@php.net so we can mail you a copy immediately.
 *
 * @category    User.php
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
 * @category User.php
 * @package Models
 * @author Vijay.ch <vijay.ch@vendus.com>
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 * @link http://local.sureify.com/user
 */
class User extends Base_model {
	protected $table = 'quote_users';
	protected $app_users = 'users';
	protected $users = 'users';
	protected $user_info = 'user_info';
	protected $user_steps = 'user_steps';
	protected $user_calories = 'user_calories';
	protected $user_sessions = 'user_sessions';
	protected $user_challenges = 'user_challenges';
	protected $challenges_master = 'challenges_master';
	protected $user_weights = 'user_weights';
	protected $devices = "devices_master";
	protected $policies = "policies";
	protected $premiums = "premiums";
	protected $premium_discounts = "premium_discounts";
	protected $plans = "plans";
	protected $policy_benificiaries = "policy_benificiaries";
	protected $user_savings = 'user_savings';
	protected $user_devices = "user_devices";
	protected $user_cards = "user_cards";
	/**
	 * Construct
	 *
	 * @return void
	 * @throws NotFoundException When the view file could not be found
	 *         or MissingViewException in debug mode.
	 */
	public function __construct() {
		parent::__construct ();
		$this->load->database ();
		$this->load->dbutil ();
		$this->load->helper ( 'file' );
		$this->load->helper ( 'download' );
	}
	
	/**
	 * Returns user session in case if user is logged in
	 *
	 * @return int
	 */
	public function loggedIn() {
		return $this->session->userdata ( 'uid' );
	}
	
	/**
	 * Gets current user object
	 *
	 * @return object
	 */
	public function getCurrentUser() {
		$uid = $this->session->userdata ( 'uid' );
		if ($uid) {
			return $this->getById ( $uid );
		}
		return false;
	}
	
	/**
	 * Logs user out
	 *
	 * @return boolean
	 */
	public function logOut() {
		return $this->session->unset_userdata ( 'uid' );
	}
	
	/**
	 * Logs user out
	 *
	 * @return boolean
	 */
	public function adminLogOut() {
		return $this->session->unset_userdata ( 'admin' );
	}
	
	/**
	 * Detects admin session
	 *
	 * @return boolean
	 */
	public function isAdmin() {
		$admin = $this->session->userdata ( 'admin' );
		if ($admin) {
			return true;
		}
		return false;
	}
	
	/**
	 * Export the user details into the excel sheet or csv
	 *
	 * @return void
	 */
	public function exportusers() {
		$this->db->select ( "name as 'Name', email as 'Email', age as Age, case gender WHEN 1 then 'Male' else 'Female' end as Gender, area_code as Zip, case smoker WHEN 0 then 'No' else 'Yes' end as Smoke, case health WHEN 1 then 'Excellent' WHEN 2 then 'Good' when 3 then 'Average' else 'Poor' end as Health, duration as Duration, created_at as 'Registered Date', origin as Origin", false );
		// $this->db->where('rec_status', '1');
		$this->db->from ( 'users' );
		$this->db->order_by ( "id asc" );
		$query = $this->db->get ();
		$delimiter = ",";
		$newline = "\r\n";
		$data = $this->dbutil->csv_from_result ( $query, $delimiter, $newline );
		force_download ( 'Sureify Users.csv', $data );
		exit ();
	}
	
	/**
	 * Authentication
	 *
	 * @param $where_array, $group_by,
	 *        	$order_by
	 * @return array
	 */
	public function authentication($where_array = array(), $group_by = array(), $order_by = array()) {
		$this->db->select ( 'id, email, password' );
		$this->db->from ( 'users' );
		
		if (count ( $where_array ) > 0) {
			$this->db->where ( $where_array );
			// return $where_array;
		}
		
		if (count ( $group_by ) > 0) {
			foreach ( $group_by as $gb ) {
				$this->db->group_by ( $gb );
			}
		}
		
		if (count ( $order_by ) > 0) {
		}
		$query = $this->db->get ();
		
		if (! $query) {
			throw new Exception (); // throws exception if query not retrived
		}
		
		$result = array ();
		// $result = $query->result_array(); //retrive result in array format
		
		$result = $query->row ();
		
		return $result;
	}
	
	/**
	 * Returns user data array
	 *
	 * @param array $where_array
	 *        	where array
	 * @return $result array
	 */
	function getUser($where_array = array()) {
		// try method starts
		try {
			/*
			 * $this->db->select('u.id,u.first_name,u.last_name,u.email,u.mobile,u.location,u.beneficiary,u.photo,u.date_of_birth,u.policy_number,u.fitbit_access_token,u.age,u.sex,u.height,u.weight,u.term_length,u.initial_premium_rate,u.photo,u.stripe_customer_id,u.created_date,u.created_by,d.device_title,d.device_image,p.policy_title,p.policy_amount,p.created_date as issue_date', false); //selects all columns
			 * $this->db->from($this->app_users . ' u');
			 * $this->db->join($this->devices . ' d', 'u.device_id=d.id', 'left');
			 * $this->db->join($this->policies . ' p', 'u.policy_id=p.id', 'left');
			 * $this->db->where('u.rec_status', 1);
			 */
			$this->db->select ( 'u.id,u.email,u.agent_id,u.user_type,u.phone_number,u.status,u.login_attempts,u.last_login,ui.first_name,ui.last_name,ui.height,ui.weight,ui.location,ui.profile_pic,ui.gender,ui.salary,
                ui.death_date,ui.date_of_birth,p.policy_number,p.policy_number,p.term,p.issue_date,p.initial_premium,p.policy_status,
                u.fitbit_access_token,ui.age,u.stripe_customer_id', false ); // selects all columns
			$this->db->from ( $this->app_users . ' u' );
			// $this->db->join($this->devices . ' d', 'u.device_id=d.id', 'left');
			$this->db->join ( $this->user_info . ' ui', 'ui.user_id = u.id', 'left' );
			$this->db->join ( $this->policies . ' p', 'p.user_id=u.id', 'left' );
			$this->db->where ( 'u.row_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			// $result = $query->result_array(); //retrive result in array format
			
			$result = $query->row ();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Updates user session
	 *
	 * @param array $user_session_data
	 *        	session array-
	 * @return $user_session_id
	 */
	public function AddUserSession($user_session_data) {
		try {
			$this->db->trans_begin ();
			$user_session_data ['login_time'] = date ( "Y-m-d H:i:s" );
			$user_session_data ['access_token'] = strtotime ( date ( 'Y-m-d H:i:s' ) );
			$insert_user_session = $this->db->insert ( $this->user_sessions, $user_session_data );
			$user_session_id = $this->db->insert_id ();
			$this->db->where ( 'id', $user_session_data ['user_id'] );
			$this->db->update ( $this->app_users, array (
					'last_login' => $user_session_data ['login_time'] 
			) );
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return array (
						'user_session_id' => $user_session_id,
						'access-token' => $user_session_data ['access_token']
				);
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Update user data
	 *
	 * @param array $update_data        	
	 * @param array $update_where        	
	 * @return 1 or 0 based on transaction
	 */
	public function updateUserData($update_data, $update_where) {
		try {
			$this->db->trans_begin ();
			
			$this->db->where ( $update_where );
			$result = $this->db->update ( $this->app_users, $update_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Update Quote user data
	 *
	 * @param array $update_data        	
	 * @param array $update_where        	
	 * @return 1 or 0 based on transaction
	 */
	public function updateQuoteUserData($update_data, $update_where = array(), $update_where_in_array = array()) {
		try {
			$this->db->trans_begin ();
			
			if (count ( $update_where ) > 0) {
				$this->db->where ( $update_where );
			}
			
			if (count ( $update_where_in_array ) > 0) {
				foreach ( $update_where_in_array as $column => $in_array_elements )
					$this->db->where_in ( $column, $in_array_elements );
			}
			$result = $this->db->update ( $this->table . ' as u', $update_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Update user_session_data
	 *
	 * @param int $user_session_id
	 *        	session id
	 * @return 1 or 0 based on transaction
	 */
	public function updateUserSessionLogoutTime($user_session_id) {
		try {
			$this->db->trans_begin ();
			$this->db->where ( 'id', $user_session_id );
			$update_data ['logout_time'] = date ( "Y-m-d H:i:s" );
			$update_user_session = $this->db->update ( $this->user_sessions, $update_data );
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Checking authentication-token exists or not
	 *
	 * @param
	 *        	string auth-token
	 * @return true / false
	 */
	public function checkAccessTokenExist($user_access_token) {
		$this->db->select ( 'us.logout_time', FALSE );
		$this->db->from ( $this->user_sessions . ' us' );
		$this->db->where ( 'us.access_token', $user_access_token );
		
		$query = $this->db->get ();
		// $result = array();
		$result = $query->row ();
		// print_r(count($result->logout_time));exit;
		if (count($result->logout_time) == 1 /*|| $result->logout_time != '' || $result->logout_time != null*/) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * Returning user_session_id using access-token if exists else null
	 *
	 * @param
	 *        	string auth-token
	 * @return user_session_id / null
	 */
	public function getUserSessionFromAccessToken($user_access_token) {
		$this->db->select ( 'us.id', FALSE );
		$this->db->from ( $this->user_sessions . ' us' );
		$this->db->where ( 'us.access_token', $user_access_token );
		
		$query = $this->db->get ();
		// $result = array();
		$result = $query->row ();
		
		// print_r($email1);exit;
		if ($query->num_rows () > 0) {
			return $result->id;
		} else {
			return null;
		}
	}
	
	/**
	 * Returning user_id using access-token if exists else null
	 *
	 * @param
	 *        	string auth-token
	 * @return user_id / null
	 */
	public function getUserIDFromAccessToken($user_access_token) {
		$this->db->select ( 'us.user_id', FALSE );
		$this->db->from ( $this->user_sessions . ' us' );
		$this->db->where ( 'us.access_token', ( string ) $user_access_token );
		// $query = $this->db->query("SELECT user_id FROM user_sessions where access_token = '".trim($user_access_token)."'", FALSE);
		$query = $this->db->get ();
		
		if ($query->num_rows () > 0) {
			$result = $query->row ();
			return $result->user_id;
		} else {
			return null;
		}
	}
	
	/**
	 * Returning session id using access-token if exists else null
	 *
	 * @param
	 *        	string auth-token
	 * @return session_id / null
	 */
	public function getSessionIDFromAccessToken($user_access_token) {
		$this->db->select ( 'us.id, us.logout_time', FALSE );
		$this->db->from ( $this->user_sessions . ' us' );
		
		$this->db->where ( 'us.access_token', ( string ) $user_access_token );
		
		$query = $this->db->get ();
	
		
		if ($query->num_rows () > 0) {
			$result = $query->row ();
			if($result->logout_time == null)
				return $result->id;
		}
		return null;
		
	}
	
	/**
	 * Update PIN
	 *
	 * @param
	 *        	$user_id
	 * @return true / false based on transaction
	 */
	public function updateUserPIN($where_array, $pin) {
		try {
			$this->db->trans_begin ();
			// echo $where_array['id'];exit;
			
			$this->db->where ( 'id', $where_array ['id'] );
			$update_data ['pin'] = $pin;
			// echo $this->db->last_query();exit;
			
			$update_users = $this->db->update ( $this->user_info, $update_data );
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return false;
			} else {
				$this->db->trans_commit ();
				return true;
			}
		} catch ( Exception $e ) {
			$this->db->trans_rollback ();
			return false;
		}
	}
	
	/**
	 * Update User Info
	 *
	 * @param
	 *        	$where_array
	 * @param
	 *        	$user_edit_data
	 * @return true / false based on transaction
	 */
	public function updateUserInfo($where_array, $user_edit_data) {
		try {
			$this->db->trans_begin ();
			// echo $where_array['id'];exit;
			
			$this->db->where ( 'id', $where_array ['id'] );
			// echo $this->db->last_query();exit;
			
			$update_users = $this->db->update ( $this->user_info, $user_edit_data );
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return false;
			} else {
				$this->db->trans_commit ();
				return true;
			}
		} catch ( Exception $e ) {
			$this->db->trans_rollback ();
			return false;
		}
	}
	
	/**
	 * Return PIN
	 *
	 * @param
	 *        	$user_id
	 * @return true / false based on transaction
	 */
	public function returnUserPIN($where_array) {
		$this->db->select ( 'pin', FALSE );
		$this->db->from ( $this->user_info );
		$this->db->where ( $where_array );
		
		$query = $this->db->get ();
		// $result = array();
		$result = $query->row ();
		
		if ($result->pin != null)
			return $result->pin;
		
		if ($query->num_rows () > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Check for User Session Id
	 *
	 * @param
	 *        	string user_session_id
	 * @return true / false
	 */
	public function checkUserSession($where_array) {
		$this->db->select ( 'id, logout_time', FALSE );
		$this->db->from ( $this->user_sessions );
		$this->db->where ( $where_array );
		
		$query = $this->db->get ();
		// $result = array();
		$result = $query->row ();
		// echo $result->logout_time;exit;
		if ($result->logout_time != '' || $result->logout_time != null)
			return false;
		
		if ($query->num_rows () > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Returns users array
	 *
	 * @param array $where_array        	
	 * @return $result array
	 */
	function getUsers($where_array = array()) {
		// try method starts
		try {
			/*
			 * $this->db->select('u.id,u.first_name,u.last_name,u.email,u.mobile,u.policy_number,u.fitbit_access_token,u.created_date,u.created_by', false); //selects all columns
			 * $this->db->from($this->app_users . ' u');
			 * $this->db->where('u.rec_status', 1);
			 */
			$this->db->select ( 'u.id,u.email,u.agent_id,u.user_type,u.phone_number,u.status,u.login_attempts,u.last_login,ui.first_name,ui.last_name,ui.height,ui.weight,ui.location,ui.profile_pic,ui.gender,ui.salary,
                ui.death_date,ui.date_of_birth,p.policy_number,p.policy_number,p.term,p.issue_date,p.initial_premium,p.policy_status,
                u.fitbit_access_token,ui.age', false ); // selects all columns
			$this->db->from ( $this->app_users . ' u' );
			// $this->db->join($this->devices . ' d', 'u.device_id=d.id', 'left');
			$this->db->join ( $this->user_info . ' ui', 'ui.user_id = u.id', 'left' );
			$this->db->join ( $this->policies . ' p', 'p.user_id=u.id', 'left' );
			$this->db->where ( 'u.row_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			$result = $query->result_array (); // retrive result in array format
			                                   // $result = $query->row();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Add user data
	 *
	 * @param array $insert_data
	 *        	array
	 * @return 1 or 0 based on transaction
	 */
	public function addUserSteps($insert_data) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'DATE_FORMAT(steps_date,"%Y-%m-%d")', $insert_data [0] ['steps_date'] );
			$result = $this->db->update ( $this->user_steps, array (
					'rec_status' => 0 
			) );
			
			// insert new steps data for user
			$result = $this->db->insert_batch ( $this->user_steps, $insert_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Add user data
	 *
	 * @param array $insert_data        	
	 * @return 1 or 0 based on transaction
	 */
	public function addUserCalories($insert_data) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'DATE_FORMAT(calories_date,"%Y-%m-%d")', $insert_data [0] ['calories_date'] );
			$result = $this->db->update ( $this->user_calories, array (
					'rec_status' => 0 
			) );
			
			// insert new steps data for user
			$result = $this->db->insert_batch ( $this->user_calories, $insert_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Add user data
	 *
	 * @param array $insert_data        	
	 * @return 1 or 0 based on transaction
	 */
	public function addUserWeights($insert_data) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'DATE_FORMAT(weight_date,"%Y-%m-%d")', $insert_data [0] ['weight_date'] );
			$result = $this->db->update ( $this->user_weights, array (
					'rec_status' => 0 
			) );
			
			// insert new steps data for user
			$result = $this->db->insert_batch ( $this->user_weights, $insert_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Check user by email
	 *
	 * @param string $email
	 *        	email
	 *        	
	 * @return int
	 */
	public function checkUserByEmail($email) {
		$this->db->select ( 'b.*' );
		$this->db->from ( $this->app_users . ' as b' );
		$this->db->where ( 'email', $email );
		$query = $this->db->get ();
		$ret = $query->row ();
		if (count ( $ret ) > 0) {
			return 1;
		} else {
			return 0;
		}
	}
	
	/**
	 * Updates participant password
	 *
	 * @param string $email
	 *        	email
	 * @param string $password
	 *        	password
	 *        	
	 * @return int
	 */
	public function updatePassword($email, $password) {
		$data = array (
				'password' => md5 ( $password ),
				'modified_time' => date ( 'Y-m-d H:i:s' ),
				'user_session_id' => $this->session->userdata ( 'app_user_data' )->user_session_id 
		);
		try {
			$this->db->trans_begin ();
			$update = $this->db->update ( $this->app_users, $data, array (
					'email' => $email 
			) );
			// echo $this->db->last_query();exit;
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Get user steps based on month and year
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getMonthSteps($data) {
		$this->db->select ( 'steps,steps_date', false );
		$this->db->from ( $this->user_steps );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(steps_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(steps_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(steps_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		// echo $this->db->last_query();exit;
		return $result;
	}
	
	/**
	 * Get user steps data as json used for dashboard chart
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getStepsJson($data) {
		// echo "<pre>";print_r($data);exit;
		$wk_arr = array (
				'S',
				'M',
				'T',
				'W',
				'T',
				'F',
				'S' 
		);
		$m_arr = array (
				null,
				'Jan',
				'Feb',
				'Mar',
				'Apr',
				'May',
				'Jun',
				'Jul',
				'Aug',
				'Sep',
				'Oct',
				'Nov',
				'Dec' 
		);
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		$steps = array ();
		$st = array ();
		$n = date ( 'w', strtotime ( $data ['year'] . '-' . $data ['month'] . '-01' ) );
		// echo $n_days;exit;
		for($i = 1; $i <= $n_days; $i ++) {
			$steps [$i] = 0;
		}
		
		foreach ( $data ['steps'] as $key => $value ) {
			// echo $value['steps'];
			$i = date ( "d", strtotime ( $value ['steps_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$steps [$i] = $value ['steps']; // insert hours worked into respective date index
		}
		for($i = 1; $i < $n + 1; $i ++) {
			$st [$i] = 0;
		}
		for($i = $n + 1, $j = 1; $i <= ($n_days + $n); $i ++, $j ++) {
			$st [$i] = $steps [$j];
		}
		
		$arr_cnt = count ( $st );
		// echo "<pre>";print_r($st);exit;
		$rem_cnt = $arr_cnt % 7;
		if ($rem_cnt != 0) {
			$t = $arr_cnt + (7 - $rem_cnt);
			for($i = $arr_cnt; $i <= $t; $i ++) {
				$st [$i] = 0;
			}
		} else if ($rem_cnt == 0) {
			$st [$arr_cnt] = 0;
		}
		// echo $n_days+$n;
		// echo "<pre>";print_r($st);exit;
		
		$cols = '{"id":"","label":"","pattern":"","type":"string"},{"id":"","label":"S","pattern":"","type":"number"},{"id":"","label":"M","pattern":"","type":"number"},{"id":"","label":"T","pattern":"","type":"number"},{"id":"","label":"W","pattern":"","type":"number"},{"id":"","label":"T","pattern":"","type":"number"},{"id":"","label":"F","pattern":"","type":"number"},{"id":"","label":"S","pattern":"","type":"number"}';
		$rows = '';
		// echo "<pre>";print_r($st);exit;
		$month_wise_array = array ();
		$b = count ( $st ) / 7;
		for($i = 0; $i < $b; $i ++) {
			
			$month_wise_array [$i] = array_splice ( $st, 0, 7 );
		}
		// echo "<pre>";print_r($month_wise_array);exit;
		$i = 1;
		$p = 7 - $n;
		if ($p == 0) {
			$p = 7;
		}
		$rows = '';
		foreach ( $month_wise_array as $key => $value ) {
			
			if ($i == $p) {
				$wk_date = $m_arr [$data ['month']] . ' ' . $i;
			} else {
				$wk_date = $m_arr [$data ['month']] . ' ' . $i . ' - ' . $m_arr [$data ['month']] . ' ' . $p;
			}
			$rows .= '{"c":[{"v":"' . $wk_date . '","f":null},{"v":' . $value [0] . ',"f":null},{"v":' . $value [1] . ',"f":null},{"v":' . $value [2] . ',"f":null},{"v":' . $value [3] . ',"f":null},{"v":' . $value [4] . ',"f":null},{"v":' . $value [5] . ',"f":null},{"v":' . $value [6] . ',"f":null}]},';
			$i = $p + 1;
			$p = $p + 7;
			if ($p > $n_days) {
				$p = $n_days;
			}
		}
		
		// echo "<pre>";print_r($month_wise_array);exit;
		// Arranging data in a format which have to pass it to columnchart as json data
		$u_steps = '{        
		  "cols": [
		        ' . $cols . '
		      ],
		  "rows": [
		       ' . $rows . '
		      
		      ]
		}';
		// echo "<pre>";print_r($u_steps);
		return $u_steps;
	}
	
	/**
	 * Get user weight based on month and year
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getMonthWeights($data) {
		$this->db->select ( 'weight_date,weight', false );
		$this->db->from ( $this->user_weights );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(weight_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(weight_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(weight_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		// echo $this->db->last_query();
		return $result;
	}
	
	/**
	 * Get user weight based on month and year Api
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getMonthWeightsApi($data) {
		$this->db->select ( 'weight_date,weight', false );
		$this->db->from ( $this->user_weights );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(weight_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(weight_date,"%Y")' => $data ['year'],
				'rec_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(weight_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		
		$this->db->select ( 'weight_date,weight' );
		$this->db->from ( $this->user_weights );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(weight_date,"%c")' => ltrim ( $data ['month'], 0 ) - 1,
				'DATE_FORMAT(weight_date,"%Y")' => $data ['year'],
				'rec_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(weight_date)', 'desc' );
		$this->db->limit ( 1 );
		$query = $this->db->get ();
		$result_prev = $query->result_array ();
		$res ['previous_weight'] = ( int ) $result_prev [0] ['weight'];
		$weights = array ();
		// echo $this->db->last_query();
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		for($i = 1; $i <= $n_days; $i ++) {
			$weights [$i] ['weight'] = null;
			
			$weights [$i] ['weight_date'] = date ( 'F j', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$weights [$i] ['weight_day'] = date ( 'D', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
		}
		
		foreach ( $result as $key => $value ) {
			$i = date ( "d", strtotime ( $value ['weight_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$weights [$i] ['weight'] = ( int ) $value ['weight']; // insert hours worked into respective date index
		}
		
		$res ['month_weights'] = $weights;
		$range1 = $current_date = date ( 'd' );
		$current_month = date ( 'F' );
		$range = array ();
		$second = ( int ) $current_date;
		$j = 0;
		
		for($i = $current_date; $i != 0; $i --) {
			$week_day = date ( 'N', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			
			if ($week_day == 1 || $i == 1) {
				
				$range [$j] ['range'] = $current_month . ' ' . $i . '-' . $second;
				$range [$j] ['start date'] = $i;
				$range [$j] ['end date'] = $second;
				$j ++;
				$second = $i - 1;
			}
		}
		
		$res ['range'] = $range;
		return $res;
	}
	
	/**
	 * Get user steps based on month and year Api
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getMonthStepsApi($data) {
		$this->db->select ( 'steps,steps_date', false );
		$this->db->from ( $this->user_steps );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(steps_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(steps_date,"%Y")' => $data ['year'],
				'rec_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(steps_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		// echo $this->db->last_query();exit;
		$steps = array ();
		// echo $this->db->last_query();
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		for($i = 1; $i <= $n_days; $i ++) {
			$steps [$i] ['steps'] = 0;
			
			$steps [$i] ['steps_date'] = date ( 'F j', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$steps [$i] ['steps_day'] = date ( 'D', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
		}
		
		foreach ( $result as $key => $value ) {
			$i = date ( "d", strtotime ( $value ['steps_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$steps [$i] ['steps'] = ( int ) $value ['steps']; // insert hours worked into respective date index
		}
		$res ['month_steps'] = $steps;
		$range1 = $current_date = date ( 'd' );
		$current_month = date ( 'F' );
		$range = array ();
		$second = ( int ) $current_date;
		$j = 0;
		$step_count = 0;
		
		for($i = $current_date; $i != 0; $i --) {
			$week_day = date ( 'N', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$step_count = $step_count + $steps [$i] ['steps'];
			
			if ($week_day == 1 || $i == 1) {
				
				$range [$j] ['range'] = $current_month . ' ' . $i . '-' . $second;
				$range [$j] ['start date'] = $i;
				$range [$j] ['end date'] = $second;
				$range [$j] ['step_count'] = $step_count;
				$j ++;
				$second = $i - 1;
				$step_count = 0;
			}
		}
		
		$res ['range'] = $range;
		return $res;
	}
	/**
	 * Get user weights based on month and year json
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function getWeightsJson($data) {
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		$current_date = date ( 'd' );
		// echo $data['month'];print_r($data['weights']);echo "hii";echo count($data['weights']);exit;
		
		for($i = 1; $i <= $current_date; $i ++) {
			$weights [$i] = null;
		}
		
		foreach ( $data ['weights'] as $key => $value ) {
			$i = date ( "d", strtotime ( $value ['weight_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$weights [$i] = ( float ) $value ['weight']; // insert hours worked into respective date index
		}
		if ($data ['month'] == date ( 'm' ) && $data ['year'] == date ( 'Y' )) {
			for($i = $current_date + 1; $i <= $n_days; $i ++) {
				$weights [$i] = null;
			}
		} else if ($data ['month'] > date ( 'm' ) && $data ['year'] <= date ( 'Y' )) {
			
			return 0;
		}
		$stp = array ();
		$stp [0] = array (
				'day',
				'Lbs' 
		);
		for($i = 1; $i <= (count ( $weights )); $i ++) {
			$stp [$i] = array (
					( string ) $i,
					$weights [$i] 
			);
		}
		// echo "<pre>";print_r($stp);exit;
		return $stp;
	}
	
	/**
	 * Get cheats (steps count less than 10000)
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return int
	 */
	public function getCheats($data) {
		$this->db->select ( 'count(id) as cheats', false );
		$this->db->from ( $this->user_steps );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'steps <' => 10000,
				'DATE_FORMAT(steps_date,"%c")' => $data ['month'],
				'DATE_FORMAT(steps_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$query = $this->db->get ();
		
		$result = $query->result_array ();
		// return $result[0]['cheats'];
		$cheats_cnt = $result [0] ['cheats'];
		if ($data ['month'] == date ( 'm' ) && $data ['year'] == date ( 'Y' )) {
			if ($cheats_cnt < 3) {
				return 3 - $cheats_cnt;
			} else {
				return 0;
			}
		} else {
			return 0;
		}
	}
	
	/**
	 * Get email by policy number
	 *
	 * @param string $policy
	 *        	policy number
	 *        	
	 * @return string
	 */
	public function getEmailByPolicy($policy) {
		$this->db->select ( 'u.id,u.email' );
		$this->db->from ( $this->app_users . ' u' );
		$this->db->join ( $this->policies . ' p', 'p.user_id = u.id', 'left' );
		$this->db->where ( 'u.row_status', 1 );
		$this->db->where ( 'p.policy_number', $policy );
		$query = $this->db->get ();
		$res = $query->result_array ();
		// print_r($res);exit;
		if (count ( $res ) > 0) {
			return $res [0] ['email'];
		} else {
			
			return 0;
		}
	}
	
	/**
	 * Returns user data array
	 *
	 * @param array $where_array
	 *        	where array
	 * @param array $group_by
	 *        	group by array
	 * @param array $order_by
	 *        	order by array
	 * @return array $result
	 */
	function getUserSavings($where_array = array(), $group_by = array(), $order_by = array()) {
		// try method starts
		try {
			$this->db->select ( 'us.id,us.user_id,us.year,us.month,us.premium_rate,us.weight_goal_discount,us.weight_goal_date,us.weight_maintenance_discount,us.steps_goal_discount,us.created_date', false ); // selects all columns
			$this->db->from ( $this->user_savings . ' us' );
			$this->db->where ( 'us.rec_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			if (count ( $group_by ) > 0) {
				foreach ( $group_by as $gb ) {
					$this->db->group_by ( $gb );
				}
			}
			
			if (count ( $order_by ) > 0) {
				foreach ( $order_by as $ob ) {
					$this->db->order_by ( $ob ['field'], $ob ['sorting_order'] );
				}
			}
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			$result = $query->result_array (); // retrive result in array format
			                                   // $result = $query->row();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/* to save email */
	/**
	 * Insert new user with email
	 *
	 * @param string $email
	 *        	email
	 * @return void
	 */
	public function saveEmail($email) {
		// print_r($_POST);exit;
		$data = array (
				'email' => $this->input->post ( 'email_top' ),
				'origin' => $this->data ['signup_type'],
				'name' => $this->data['name'],
				'created_time' => date ( 'Y-m-d H:i:s' ) 
		);
		// print_r($data);exit;
		$this->db->insert ( 'quote_users', $data );
	}
	
	/* to save email */
	/**
	 * Insert new user with email
	 *
	 * @param string $email1
	 *        	email
	 * @return void
	 */
	public function saveEmailBottom($email1) {
		$data = array (
				'email' => $this->input->post ( 'email_bottom' ),
				'origin' => $this->input->post ( 'signup_page' ),
				'created_time' => date ( 'Y-m-d H:i:s' ) 
		);
		// print_r($data);exit;
		$this->db->insert ( 'quote_users', $data );
	}
	
	/**
	 * Chekcing Email exists or not
	 *
	 * @param string $email
	 *        	User Email
	 * @return array User Result array
	 */
	public function checkEmailExist($email) {
		// echo 'hiiiiiii';exit;
		$query = $this->db->get_where ( 'users', array (
				"email" => $email,
				"row_status" => 1 
		) );
		// print_r($email1);exit;
		if ($query->num_rows () > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * Check user current password is currect or not
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return int
	 */
	public function checkPassword($data) {
		$user_id = $this->session->userdata ( 'app_user_data' )->id;
		$this->db->select ( 'id,email' );
		$this->db->from ( $this->app_users );
		$this->db->where ( 'id', $user_id );
		$this->db->where ( 'password', md5 ( $data ['old_password'] ) );
		$query = $this->db->get ();
		// echo $this->db->last_query();exit;
		$res = $query->result_array ();
		// print_r($res);
		if (count ( $res ) > 0) {
			return $res [0] ['email'];
		} else {
			return 0;
		}
	}
	
	/**
	 * Edit profile details for mobile
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return 1 or 0 based on transaction
	 */
	public function updateProfileApi($data) {
		$update_arr = array (
				'location' => $data ['location'],
				'mobile' => $data ['mobile'],
				'modified_date' => date ( 'Y-m-d H:i:s' ) 
		);
		$res = $this->db->update ( $this->app_users, $update_arr, array (
				'id' => $data ['user_id'] 
		) );
		return $res;
	}
	
	/**
	 * Edit profile details
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return 1 or 0 based on transaction
	 */
	public function updateProfile($data) {
		$update_arr = array (
				$data ['field'] => $data ['value'],
				'user_session_id' => $this->session->userdata ( 'app_user_data' )->user_session_id 
		);
		$res = $this->db->update ( $this->user_info, $update_arr, array (
				'user_id' => $data ['id'] 
		) );
		if ($data ['field'] == 'phone_number')
			$this->db->update ( $this->app_users, $update_arr, array (
					'id' => $data ['id'] 
			) );
		return $res;
	}
	
	/**
	 * Edit profile picture
	 *
	 * @param string $pic_name
	 *        	picture name
	 * @param int $id
	 *        	user id
	 *        	
	 * @return 1 or 0 based on transaction
	 */
	public function updatePhoto($pic_name, $id) {
		$update_arr = array (
				'profile_pic' => $pic_name,
				'modified_time' => date ( 'Y-m-d H:i:s' ),
				'user_session_id' => $this->session->userdata ( 'app_user_data' )->user_session_id 
		);
		
		$res = $this->db->update ( $this->user_info, $update_arr, array (
				'user_id' => $id 
		) );
		return $res;
	}
	
	/**
	 * Edit profile picture
	 *
	 * @param string $pic_name
	 *        	picture name
	 * @param int $id
	 *        	user id
	 *
	 * @return 1 or 0 based on transaction
	 */
	public function updatePhotoMobile($pic_name, $user_session_id, $id) {
		//$this->db->trans_start();
		$update_arr = array (
				'profile_pic' => $pic_name,
				'modified_time' => date ( 'Y-m-d H:i:s' ),
				'user_session_id' => $user_session_id
		);
		//echo " model";exit();
		
		$res = $this->db->update ( $this->user_info, $update_arr, array (
				'user_id' => $id
		) );
		//$this->db->trans_complete();
		
		return $res;
	}
	
	/**
	 * Add user data
	 *
	 * @param array $insert_data
	 *        	data array
	 * @return 1 or 0 based on transaction
	 */
	public function addUserDevices($insert_data) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'user_id', $user_id );
			$result = $this->db->update ( $this->user_devices, array (
					'rec_status' => 0 
			) );
			
			// insert new steps data for user
			$result = $this->db->insert_batch ( $this->user_devices, $insert_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Returns user data array
	 *
	 * @param array $where_array
	 *        	where array
	 * @return $result array
	 */
	function getDevicesMaster($where_array = array()) {
		// try method starts
		try {
			$this->db->select ( 'd.id,d.device_name,d.device_image', false ); // selects all columns
			$this->db->from ( $this->devices . ' d' );
			$this->db->where ( 'd.row_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			$result = $query->result_array (); // retrive result in array format
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Store fitbit devices data
	 *
	 * @param array $insert_data
	 *        	insert data array
	 * @return 1 or 0 based on transaction
	 */
	public function storeFitbitUserDevices($insert_data) {
		try {
			$loggedin_user = $this->session->userdata ( 'app_user_data' );
		} catch ( Exception $e ) {
			return 0;
		}
	}
	
	/**
	 * Retrieve the steps of each user
	 *
	 * @param int $user_id
	 *        	int users id
	 * @param int $month
	 *        	int month number
	 * @param int $year
	 *        	int year number array result_array
	 *        	
	 * @return array result_array
	 */
	public function setpsGoalDiscount($user_id, $month, $year) {
		try {
			$this->db->where ( "user_id", $user_id );
			$this->db->where ( "rec_status", 1 );
			$this->db->like ( "steps_date", $year . "-" . $month );
			$this->db->select ( "*" );
			$this->db->from ( "user_steps" );
			$query = $this->db->get ();
			$result = $query->result_array ();
			// echo $this->db->last_query();exit;
			return $result;
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			return false;
		}
	}
	
	/**
	 * Getting details of user weights
	 *
	 * @param int $user_id
	 *        	int users id
	 * @param int $month
	 *        	int month number
	 * @param int $year
	 *        	int year number array result_array
	 *        	
	 * @return array $result
	 */
	public function weightMaintenanceGoalDiscount($user_id, $month, $year) {
		try {
			$this->db->where ( "uw.user_id", $user_id );
			$this->db->where ( "uw.rec_status", 1 );
			$this->db->like ( "uw.weight_date", $year . "-" . $month );
			$this->db->select ( "uw.user_id,uw.weight,max(uw.weight_time), uw.weight_date, au.height, hwc.*" );
			$this->db->from ( "user_weights uw" );
			$this->db->join ( "app_users au", "au.id = uw.user_id" );
			$this->db->join ( "height_weight_chart hwc", "hwc.height = au.height" );
			$this->db->group_by ( "uw.weight_date" );
			$query = $this->db->get ();
			$result = $query->result_array ();
			// echo $this->db->last_query();exit;
			return $result;
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			return false;
		}
	}
	/**
	 * Gets user previous month weights based on month and year
	 *
	 * @param int $user_id
	 *        	int users id
	 * @param int $month
	 *        	int month number
	 * @param int $year
	 *        	int year number
	 * @return array
	 */
	public function getUserPreviousMonthWeights($user_id, $month, $year) {
		try {
			
			$this->db->where ( array (
					"user_id" => $user_id,
					"rec_status" => 1 
			) );
			$this->db->select ( "sum(weight_goal_discount) avg_weight_discount" );
			$this->db->from ( "user_savings" );
			$query = $this->db->get ();
			$result = array_shift ( $query->result_array () );
			if ($result ["avg_weight_discount"] == 0) {
				$this->db->where ( array (
						"uw.user_id" => $user_id,
						"uw.rec_status" => 1 
				) );
				$this->db->like ( "weight_date", $year . "-" . $month );
				$this->db->select ( "uw.*,au.height" );
				$this->db->from ( "user_weights uw" );
				$this->db->join ( "app_users au", "uw.user_id = au.id" );
				$query = $this->db->get ();
				$result = $query->result_array ();
				return $result;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			return false;
		}
	}
	/**
	 * Get height weight information
	 *
	 * @return array
	 */
	public function getHeightWeightChart() {
		try {
			$this->db->where ( "row_status", 1 );
			$this->db->select ( "*" );
			$this->db->from ( "height_weight_chart" );
			$query = $this->db->get ();
			$result = $query->result_array ();
			return $result;
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			return false;
		}
	}
	/**
	 * Insert user savings data
	 *
	 * @param array $insert_data_array
	 *        	data array
	 * @return string
	 */
	public function insertUserSavings($insert_data_array) {
		try {
			if (count ( $insert_data_array ) > 0) {
				$result = $this->db->insert_batch ( "user_savings", $insert_data_array );
				if ($result) {
					$msg = "Success";
					return $msg;
				} else {
					$msg = "Fail";
					return $msg;
				}
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			return false;
		}
	}
	
	/**
	 * Returns intial premium rate of user
	 *
	 * @param int $user_id
	 *        	id of the user
	 * @return $result array
	 */
	public function getInitialPremium($user_id) {
		try {
			$this->db->where ( "id", $user_id );
			$this->db->select ( "initial_premium_rate" );
			$this->db->from ( "app_users" );
			$query = $this->db->get ();
			$result = array_shift ( $query->result_array () );
			return $result;
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Returns user devices array
	 *
	 * @param array $where_array
	 *        	where array
	 * @return $result array
	 */
	function getUserDevices($where_array = array()) {
		// try method starts
		try {
			$this->db->select ( 'ud.id,ud.user_id,ud.device_id,ud.battery,ud.device_version,ud.features,ud.fitbit_device_id,ud.last_sync_time,ud.mac,ud.type', false ); // selects all columns
			$this->db->from ( $this->user_devices . ' ud' );
			$this->db->where ( 'ud.row_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			$result = $query->result_array (); // retrive result in array format
			                                   // $result = $query->row();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Add user data
	 *
	 * @param array $insert_data
	 *        	data array
	 * @param integer $user_id
	 *        	user id
	 * @return 1 or 0 based on transaction
	 */
	public function addUserCard($insert_data, $user_id) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'user_id', $user_id );
			$result = $this->db->update ( $this->user_cards, array (
					'rec_status' => 0 
			) );
			
			// insert new steps data for user
			$result = $this->db->insert ( $this->user_cards, $insert_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Add user data
	 *
	 * @param array $update_data
	 *        	update data array
	 * @param integer $user_id        	
	 * @return 1 or 0 based on transaction
	 */
	public function updateUserCard($update_data, $user_id) {
		try {
			$this->db->trans_begin ();
			
			// update previous records for that date with rec status 0
			$this->db->where ( 'user_id', $user_id );
			$result = $this->db->update ( $this->user_cards, $update_data );
			
			// echo $this->db->_error_message();
			if ($this->db->trans_status () === false) {
				$this->db->trans_rollback ();
				return 0;
			} else {
				$this->db->trans_commit ();
				return 1;
			}
		} catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () );
			$this->db->trans_rollback ();
			return 0;
		}
	}
	
	/**
	 * Returns user data array
	 *
	 * @param array $where_array
	 *        	order
	 * @param array $group_by
	 *        	array
	 * @param array $order_by
	 *        	array
	 * @return $result array
	 */
	function getUserCards($where_array = array(), $group_by = array(), $order_by = array()) {
		// try method starts
		try {
			$this->db->select ( 'uc.id,uc.user_id,uc.zip_code,uc.make_auto_payment,uc.stripe_card_response', false ); // selects all columns
			$this->db->from ( $this->user_cards . ' uc' );
			$this->db->where ( 'uc.rec_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			if (count ( $group_by ) > 0) {
				foreach ( $group_by as $gb ) {
					$this->db->group_by ( $gb );
				}
			}
			
			if (count ( $order_by ) > 0) {
				foreach ( $order_by as $ob ) {
					$this->db->order_by ( $ob ['field'], $ob ['sorting_order'] );
				}
			}
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			$result = $query->result_array (); // retrive result in array format
			                                   // $result = $query->row();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	
	/**
	 * Returns array
	 *
	 * @param array $card_data        	
	 * @param integer $user_id        	
	 * @return array
	 */
	function saveCard($card_data, $user_id) {
		$return_status = 0;
		$return_msg = "Invalid Card Details";
		
		$user_data = $this->user->getUser ( array (
				'u.id' => $user_id 
		) );
		if (count ( $user_data ) == 0) {
			$return_status = 0;
			$return_msg = "Specified User doesnot exist ";
		} elseif (count ( $card_data ) > 0 && ! check_empty_values ( $card_data )) {
			$user_email = $user_data->email;
			$user_stripe_customer_id = $user_data->stripe_customer_id;
			$card_number = preg_replace ( "/[^0-9]/", "", $card_data ['card_number'] );
			// echo strlen($card_number);exit;
			// && strlen($card_data['security_code'])==3 && is_numeric($card_data['security_code'])
			
			if (strlen ( $card_number ) == 4) {
				$return_status = 1;
				$return_msg = "";
			} else {
				
				$insert_card_data ['user_id'] = $user_id;
				$insert_card_data ['zip_code'] = $card_data ['zip_code'];
				$insert_card_data ['make_auto_payment'] = $card_data ['make_auto_payment'];
				// echo "<pre>";print_r($card_data);exit;
				$update_stripe_customer_id = "";
				if ($user_stripe_customer_id == "" || strlen ( $user_stripe_customer_id ) < 3) {
					$stripeapi_response = $this->stripeapi->createCardAndCustomer ( $card_data, $user_email );
					// echo "<pre>";print_r($stripeapi_response);exit;
					$update_stripe_customer_id = $stripeapi_response ['customer_id'];
				} else {
					$stripeapi_response = $this->stripeapi->addCustomerCard ( $card_data, $user_stripe_customer_id );
				}
				
				if ($stripeapi_response ['status'] == 0) {
					$return_status = 0;
					$return_msg = $stripeapi_response ['response'];
				} else {
					
					$stripe_card_response = $stripeapi_response ['response'];
					if ($update_stripe_customer_id != "") {
						$update_data = array (
								"stripe_customer_id" => $update_stripe_customer_id 
						);
						$update_where = array (
								"id" => $user_id,
								"rec_status" => 1 
						);
						$update_user_data = $this->user->updateUserData ( $update_data, $update_where );
					}
					
					$insert_card_data ['stripe_card_response'] = json_encode ( $stripe_card_response );
					// echo "<pre>";print_r(json_decode($card_data['stripe_card_response'],true));
					
					$insert_status = $this->user->addUserCard ( $insert_card_data, $user_id );
					
					if ($insert_status == 1) {
						$return_status = 1;
						$return_msg = "Card Updated Successfully";
					} else {
						$return_status = 0;
						$return_msg = "Card Update Failed";
					}
				}
			}
		}
		
		return array (
				"status" => $return_status,
				"msg" => $return_msg 
		);
	}
	
	/**
	 * Retrieving the list of users quoted
	 */
	public function getQuoteUsersList($request, $user_data) {
		$sql_details = array (
				'user' => $this->db->username,
				'pass' => $this->db->password,
				'db' => $this->db->database,
				'host' => $this->db->hostname 
		);
		$request ['searchcolumns'] = array ();
		
		$columns = array (
				array (
						'db' => 'u.id',
						'dt' => 'DT_RowId',
						'formatter' => function ($d, $row) {
							// Technically a DOM id cannot start with an integer, so we prefix
							// a string. This can also be useful if you have multiple tables
							// to ensure that the id is unique with a different prefix
							return 'row_' . $d;
						} 
				),
				array (
						'db' => 'u.id',
						'dt' => 0 
				),
				array (
						'db' => 'u.name',
						'dt' => 1 
				),
				array (
						'db' => 'u.email',
						'dt' => 2 
				),
				array (
						'db' => 'u.age',
						'dt' => 3 
				),
				array (
						'db' => 'u.gender',
						'dt' => 4,
						'formatter' => function ($d, $row) {
							if ($d == 1) {
								$gender = "Male";
							} elseif ($d == 2) {
								$gender = "Female";
							} else {
								$gender = "Not Mentioned";
							}
							return $gender;
						} 
				),
				array (
						'db' => 'u.area_code',
						'dt' => 5 
				),
				array (
						'db' => 'u.smoker',
						'dt' => 6,
						'formatter' => function ($d, $row) {
							if ($d == 1) {
								$smoke = "Yes";
							} elseif ($d == 0) {
								$smoke = "No";
							} else {
								$smoke = "Not Mentioned";
							}
							return $smoke;
						} 
				),
				array (
						'db' => 'u.health',
						'dt' => 7,
						'formatter' => function ($d, $row) {
							if ($d == 1) {
								$health = "Excellent";
							} elseif ($d == 2) {
								$health = "Good";
							} elseif ($d == 3) {
								$health = "Average";
							} elseif ($d == 4) {
								$health = "Poor";
							} else {
								$health = "Not Mentioned";
							}
							return $health;
						} 
				),
				array (
						'db' => 'u.duration',
						'dt' => 8,
						'formatter' => function ($d, $row) {
							return $d . " Years";
						} 
				),
				array (
						'db' => 'u.created_at',
						'dt' => 9,
						'formatter' => function ($d, $row) {
							return date ( "m/d/Y H:i a T", strtotime ( $d ) );
						} 
				),
				array (
						'db' => 'u.origin',
						'dt' => 10 
				) 
		);
		
		$join = "";
		$query_columns_array = array (
				'u.id',
				'u.name',
				'u.email',
				'u.age',
				'u.gender',
				'u.area_code',
				'u.smoker',
				'u.health',
				'u.protection',
				'u.duration',
				'u.origin',
				'u.created_at',
				'u.rec_status' 
		);
		
		$custom_where = array (
				"u.rec_status=1" 
		);
		// $join.=" JOIN employees emp ON emp.empid = usr.employee_id ";
		$join .= "  ";
		
		$request ['custom_where'] = (count ( $custom_where ) > 0) ? implode ( " AND ", array_unique ( $custom_where ) ) : '';
		$query_columns = implode ( ",", array_unique ( $query_columns_array ) );
		$sql_query = 'SELECT $query_columns from users as u ' . $join;
		return datatable::simple ( $request, $sql_details, $sql_query, $query_columns, $columns, false );
	}
	
	/**
	 * Returns user data array
	 *
	 * @param array $where_array
	 *        	where array
	 * @return $result array
	 */
	function getUserDetails($where_array = array()) {
		// try method starts
		try {
			
			$this->db->select ( 'u.id, u.first_name, u.last_name, u.height, u.weight, u.profile_pic, u.location, u.phone_number, u.email, u.age,
    				u.gender, u.date_of_birth', false ); // selects all columns
			$this->db->from ( $this->user_info . ' u' );
			$this->db->where ( 'u.row_status', 1 );
			// if condition starts
			if (count ( $where_array ) > 0) {
				$this->db->where ( $where_array ); // codeigniter where condition
			}
			// if condition ends
			
			$query = $this->db->get (); // retrive the result from database
			                            // echo $this->db->last_query();exit;
			                            // if condition starts
			if (! $query) {
				throw new Exception (); // throws exception if query not retrived
			}
			// if condition ends
			
			$result = array ();
			// $result = $query->result_array(); //retrive result in array format
			
			$result = $query->row ();
			return $result;
		} // try method ends
		  // catch method starts
		catch ( Exception $e ) {
			log_message ( 'error', $this->db->_error_message () ); // error message when query is wrong
			return false;
		}
	}
	public function getPolicyDetails($data){
    	$user_id = $data['user_id'];
    	$this->db->select('p.id as policy_id, p.policy_number, p.term, p.issue_date, p.initial_premium,
    			 pl.plan_name, pb.first_name, pb.last_name', false); //selects all columns
    	$this->db->from($this->policies . ' p');
    	$this->db->join($this->plans . ' pl', 'pl.id = p.plan_id', 'left');
    	$this->db->join($this->policy_benificiaries . ' pb', 'pb.policy_id = p.id', 'left');
    	$where_array = array('p.user_id' => $user_id, 'p.row_status' => 1);
    	$this->db->where($where_array);
    
    	$query = $this->db->get();
    	$result = $query->result_array();
    
    	return $result;
    }
	
	/**
	 * Get user weight based on month and year Api
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function userWeights($data) {
		$this->db->select ( 'weight_date,weight', false );
		$this->db->from ( $this->user_weights );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(weight_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(weight_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(weight_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		$weights = array ();
		// echo $this->db->last_query();
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		for($i = 1; $i <= $n_days; $i ++) {
			$weights [$i] ['weight'] = null;
			$weights [$i] ['weight_date'] = date ( 'F j', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$weights [$i] ['weight_day'] = date ( 'D', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
		}
		
		foreach ( $result as $key => $value ) {
			$i = date ( "d", strtotime ( $value ['weight_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$weights [$i] ['weight'] = ( int ) $value ['weight']; // insert hours worked into respective date index
		}
		
		$res ['month_weights'] = $weights;
		return $res;
	}
	public function previousWeight($data) {
		$this->db->select ( 'weight_date,weight' );
		$this->db->from ( $this->user_weights );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(weight_date,"%c")' => ltrim ( $data ['month'], 0 ) - 1,
				'DATE_FORMAT(weight_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(weight_date)', 'desc' );
		$this->db->limit ( 1 );
		$query = $this->db->get ();
		$result_prev = $query->result_array ();
		$previous_weight = ( int ) $result_prev [0] ['weight'];
		return $previous_weight;
	}
	
	/**
	 * Get user steps based on month and year Api
	 *
	 * @param array $data
	 *        	data array
	 *        	
	 * @return array
	 */
	public function userSteps($data) {
		$this->db->select ( 'steps,steps_date', false );
		$this->db->from ( $this->user_steps );
		$where_array = array (
				'user_id' => $data ['user_id'],
				'DATE_FORMAT(steps_date,"%c")' => ltrim ( $data ['month'], 0 ),
				'DATE_FORMAT(steps_date,"%Y")' => $data ['year'],
				'row_status' => 1 
		);
		$this->db->where ( $where_array );
		$this->db->order_by ( 'DATE(steps_date)' );
		
		$query = $this->db->get ();
		$result = $query->result_array ();
		// echo $this->db->last_query();exit;
		$steps = array ();
		// echo $this->db->last_query();
		$n_days = cal_days_in_month ( CAL_GREGORIAN, $data ['month'], $data ['year'] );
		for($i = 1; $i <= $n_days; $i ++) {
			$steps [$i] ['steps'] = 0;
			
			$steps [$i] ['steps_date'] = date ( 'F j', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$steps [$i] ['steps_day'] = date ( 'D', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
		}
		
		foreach ( $result as $key => $value ) {
			$i = date ( "d", strtotime ( $value ['steps_date'] ) ); // extracting date from start_date
			$i = ltrim ( $i, '0' ); // trimming if first digit=0
			$steps [$i] ['steps'] = ( int ) $value ['steps']; // insert hours worked into respective date index
		}
		$res ['month_steps'] = $steps;
		$ran = $this->datesRanges($data, $steps);
		$res ['range'] = $ran ['range'];
		$current_date = date ( 'd' );
		$res ['days_to_go'] = $n_days - $current_date;
		return $res;
	}
	public function datesRanges($data, $steps) {
		$range1 = $current_date = date ( 'd' );
		$current_month = date ( 'F' );
		$range = array ();
		$second = ( int ) $current_date;
		$j = 0;
		$step_count = 0;
		
		for($i = $current_date; $i != 0; $i --) {
			$week_day = date ( 'N', strtotime ( $data ['year'] . '-' . $data ['month'] . '-' . $i ) );
			$step_count = $step_count + $steps[$i]['steps'];
			
			if ($week_day == 1 || $i == 1) {
				
				$range [$j] ['range'] = $current_month . ' ' . $i . '-' . $second;
				$range [$j] ['start date'] = $i;
				$range [$j] ['end date'] = $second;
				$range[$j]['step_count'] = $step_count;
				//print_r($step_count);exit();
				$j++;
				$second = $i - 1;
				$step_count = 0;
			}
		}
		
		$res ['range'] = $range;
		return $res;
	}
	
	/**
	 * Get Challeges Data of a User
	 *
	 * @param
	 *        	$where_array
	 * @return challenges
	 */
	public function challengesData($where_array) {
		$this->db->select ( 'uc.challenge_id, cm.name as challenge_name, cm.discount,
				cm.start_date, cm.end_date, cm.frequency,
				cm.cheat_days', false );
		$this->db->from ( $this->user_challenges . ' uc' );
		$this->db->join ( $this->challenges_master . ' cm', 'cm.id = uc.challenge_id', 'left' );
		
		$this->db->where ( $where_array );
		$query = $this->db->get ();
		$result = $query->result_array ();
		return $result;
		// echo "<pre>";print_r($result);exit();
	}
	
	public function getMonthDiscounts($data){
		
		$this->db->select('pred.discount_id, pred.discount_type, pred.discount_percentage', false); //selects all columns
		$this->db->from($this->premium_discounts . ' pred');
		$where_array = array('pred.user_id' => $data['user_id'],
				'pred.policy_id' => $data['policy_id'],
				'pred.month' => $data['month'],
				'pred.year' => $data['year'],
				 'pred.row_status' => 1);
		$this->db->where($where_array);
		$query = $this->db->get();
		$result = $query->result_array();
		
		return $result;
	}
	
	/**
     * Returns payment history array
     * @param  array $where_array where array
     * @return $result array
     */
    public function getPaymentHistory($data){
    	 
    	$user_id = $data['user_id'];
    	$type_id = $data['type_id'];
    	$this->db->select('pre.policy_id, pre.premium, pre.payment_date,
    			  p.issue_date as premium_period', false); //selects all columns
    	$this->db->from($this->premiums . ' pre');
    	$this->db->join($this->policies . ' p', 'p.id = pre.policy_id', 'left');
    	//$this->db->join($this->premium_discounts . ' pd', 'p.id = pd.policy_id', 'left');
    	if($type_id == -1){
    		$where_array = array('pre.user_id' => $user_id, 'pre.row_status' => 1);
    		$this->db->where($where_array);
    		$query = $this->db->get();
    		$result = $query->result_array();
    		$res_count = count($result);
    		foreach ( $result as $k=>$v )
    		{
    			$result[$k] ['issue_date'] = $result[$k] ['premium_period'];
    			unset($result[$k]['premium_period']);
    		}
    		
    	}
    	else{
    		$where_array = array('pre.user_id' => $user_id, 'pre.policy_id' => $type_id, 'pre.row_status' => 1);
    	$this->db->where($where_array);
    
    	$query = $this->db->get();
    	$result = $query->result_array();
    	 
    	$res_count = count($result);
    	$res_date = $result[$i]['premium_period'];
    	for($i = 0; $i<$res_count; $i++){
    		
    		 
    		$year = date('Y', strtotime($res_date));
    		//$this->response($year);
    		$month = date('m', strtotime($res_date));
    		//$this->response($month);
    		$d=cal_days_in_month(CAL_GREGORIAN,$month, $year);
    		//$this->response($d);
    		$date = date('Y-m-d',strtotime($res_date) + (24*3600*$d));
    
    		$prev_year = date('Y', strtotime($res_date));
    		$prev_month = date('M', strtotime($res_date));
    		$prev_day = date('d', strtotime($res_date));
    		
    
    		$curr_year = date('Y', strtotime($date));
    		$curr_month = date('M', strtotime($date));
    		$curr_day = date('d', strtotime($date));
    		
    		$res_date = $date;
    		
    		$input_array = array (
    				'user_id' => $user_id,
    				'policy_id' => $result[$i]['policy_id'],
    				'row_status' => 1,
    				'month' => date('m', strtotime($result[$i]['payment_date'])),
    				'year' => date('Y', strtotime($result[$i]['payment_date']))
    		);
    		$result[$i]['discounts'] = $this->getMonthDiscounts($input_array);
    		for($j = 0 ; $j < count($result[$i]['discounts']) ; $j++){
                $result[$i]['discounts'][$j]['discount_type'] = ucwords($result[$i]['discounts'][$j]['discount_type']);
            }
    		$result[$i]['payment_month'] = date('F', strtotime($result[$i]['payment_date']));
    		$result[$i]['premium_period'] = $prev_month." ".$prev_day." - ".$curr_month." ".$curr_day.", ".$curr_year;
    
    	}
    		 
    	}
    	 
    	//$this->response($added_dates);
    
    	return $result;
    	 
    }
}
