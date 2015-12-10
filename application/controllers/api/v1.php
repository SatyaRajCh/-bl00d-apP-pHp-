<?php
require (APPPATH . '/libraries/REST_Controller.php');
class v1 extends REST_Controller {
	function __construct() {
		parent::__construct ();
		$this->load->model ( 'user' );
		$this->load->model ( 'sync' );
		$this->load->model ( 'api_model' );
		$this->load->helper ( 'url' );
		$this->load->library ( 'fitbitapi' );
		$this->load->library ( 'stripeapi' );
	}
	
	/**
	 * Screens in Android and iOS : Login Screen
	 * Method : POST
	 *
	 * @param $email, $password        	
	 * @return user_id, user_session_id, user_details
	 */
	function auth_post() {
		$email = trim ( $this->input->post ( 'email' ) );
		$password = trim ( $this->input->post ( 'password' ) );
		
		$validate_array = array (
				'email' => $email,
				'password' => $password 
		);
		
		if (check_empty_values ( $validate_array )) {
			$this->generateErrorMessage ( BAD_REQUEST, "Some fields are missing" );
		}
		
		$where_array = array (
				'email' => $email,
				'password' => $password,
				'row_status' => 1 
		);
		$user = $this->user->authentication ( $where_array );
		
		if ($user || is_array ( $user )) {
			if (count ( $user ) > 0) {
				$user_session_data = array (
						'user_id' => $user->id,
						'login_ip' => $_SERVER ["REMOTE_ADDR"],
						'browser' => getBrowser (),
						'OS' => getOS () 
				);
				
				$usr_data = $this->user->AddUserSession ( $user_session_data );
				
				if ($usr_data) {
					
					//$response_data = objectToArray ( $user );
					$response_data ['access-token'] = $usr_data ['access-token'];
					$this->response (  array (
							'type' => 'auth',
							'id' => 'id',
							'data' => $response_data 
					), SUCCESS_OK  );
				} else {
					$this->generateErrorMessage ( CONTENT_NOT_FOUND, "Invalid Email or Password" );
				}
			} else {
				$this->generateErrorMessage ( CONTENT_NOT_FOUND, "Invalid Email or Password" );
			}
		} else {
			$this->generateErrorMessage ( CONTENT_NOT_FOUND, "Invalid Email or Password" );
		}
	}
	
	/**
	 * sends email for resetting password
	 *
	 * @param $email, $password,
	 *        	$device_id, $device_token
	 * @return $user_id, $first_name, $last_name, $email, $photo
	 */
	function sendEmail($email) {
		$this->load->library ( 'email' );
		$this->email->from ( SERVICE_EMAIL, 'Sureify Dashboard' );
		$this->email->to ( $email );
		$this->email->subject ( 'Sureify Password Reset' );
		
		$message = 'We have reset your password as per your request!.<br>';
		$message .= '<b>Please find the credentials below to log in:</b><br>';
		$message .= '<div style="width:40%;"><b><hr></b><br/>';
		$message .= '<b>Email: </b><br/>';
		$message .= '<b>Password: </b><br/><br/>';
		$message .= '<b><hr></b><br/></div>';
		$message .= 'Thanks,<br/><br/>';
		$message .= '<i>Sureify Website</i><br/>';
		
		$this->email->message ( $message );
		$this->email->set_newline ( "\r\n" );
		$this->email->send ();
		
		$this->response (array (
				'type' => 'recovery',
				'id' => 'id',
				'data' => array (
								'status' => SUCCESS_OK,
								'detail' => "Email successfully sent" 
						)
		), SUCCESS_OK );
		
	}
	
	/**
	 * Screens in Android and iOS : Can't Login Screen
	 * Method : POST
	 *
	 * @param
	 *        	$email
	 * @return void
	 */
	function recovery_post() {
		$email = trim ( $this->input->post ( 'email' ) );
		$where_array ['email'] = $email;
		
		if (! $this->user->checkEmailExist ( $email )) {
			$this->sendEmail ( $email );
		} else {
			$this->generateErrorMessage ( BAD_REQUEST, "Enter valid Email" );
		}
	}
	
	/**
	 * Screens in Android and iOS : Dashboard Slide Menu Screen
	 * Method : POST
	 *
	 * @param
	 *        	$user_session_id
	 * @return
	 *
	 */
	function logout_post() {
		// $user_id = trim($this->input->post('user_id'));
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();
		$user_session_id = $this->user->getSessionIDFromAccessToken ( $user_access_token );
		if($user_session_id == null)
			$this->generateErrorMessage ( BAD_REQUEST, "Operation Failed" );
		// echo $user_session_id;exit();
		$where_array ['id'] = $user_session_id;
		
		if ($this->user->checkUserSession ( $where_array )) {
			// echo 1;exit();
			if ($this->user->updateUserSessionLogoutTime ( $user_session_id )) {
				$this->response ( array (
						'type' => 'auth',
						'id' => 'id',
						'data' => array (
								'message' => 'Logged out Successfully' 
						) 
				), SUCCESS_OK  );
			} else {
				$this->generateErrorMessage ( BAD_REQUEST, "Operation Failed" );
			}
		} else {
			// echo 1;exit();
			$this->generateErrorMessage ( BAD_REQUEST, "No Session Exists" );
		}
	}
	
	/**
	 * Screens in Android and iOS : Update PIN Screen
	 * Method : PUT
	 *
	 * @param
	 *        	$user_access_token
	 * @return
	 *
	 */
	function config_put() {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();
		$result = $this->user->getUserIDFromAccessToken ( $user_access_token );
		$pin = trim ( $this->put ( 'pin' ) );
		
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			
			$where_array ['id'] = $result;
			if ($this->user->updateUserPIN ( $where_array, $pin ))
				$this->response (array (
						'type' => 'config',
						'id' => 'id',
						'data' => array (
								'message' => 'PIN Configured Successfully' 
						) 
				), SUCCESS_OK  );
			else
				$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		}
	}
	
	/**
	 * Screens in Android and iOS : My Account Edit
	 * Method : PUT
	 *
	 * @param $location, $phone,
	 *        	$email
	 * @return
	 *
	 */
	function editUsers_put() {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();
		$result = $this->user->getUserIDFromAccessToken ( $user_access_token );
		$location = trim ( $this->put ( 'location' ) );
		$phone = trim ( $this->put ( 'phone' ) );
		$email = trim ( $this->put ( 'email' ) );
		
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			
			$where_array ['id'] = $result;
			
			$user_edit_data = array (
					'location' => $location,
					'phone_number' => $phone,
					'email' => $email 
			);
			// print_r($user_edit_data);exit();
			if ($this->user->updateUserInfo ( $where_array, $user_edit_data ))
				$this->response ( array (
						'type' => 'config',
						'id' => 'id',
						'data' => array (
								'message' => 'Updated Successfully' 
						) 
				), SUCCESS_OK );
			else
				$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		}
	}
	
	/**
	 * Screens in Android and iOS : Ask For Pin
	 * Method : POST
	 *
	 * @param
	 *        	$pin
	 * @return Success / Failure
	 */
	function config_post() {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();
		$result = $this->user->getUserIDFromAccessToken ( $user_access_token );
		$pin = trim ( $this->input->post ( 'pin' ) );
		
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			
			$where_array ['user_id'] = $result;
			// echo $this->user->returnUserPIN($where_array);exit();
			if ($this->user->returnUserPIN ( $where_array ) == $pin)
				$this->response ( array (
						'type' => 'config',
						'id' => 'id',
						'data' => array (
								'message' => 'PIN Authenticated' 
						) 
				), SUCCESS_OK  );
			else
				$this->generateErrorMessage ( BAD_REQUEST, "Invalid PIN" );
		}
	}
	
	/**
	 * Screens in Android and iOS : Challenges
	 * Method : GET
	 *
	 * @param
	 *        	$challenge_id
	 * @return Success / Failure
	 */
	function challenges($challenge_id = null) {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();
		$result = $this->user->getUserIDFromAccessToken ( $user_access_token );
		// $pin = trim ( $this->input->post ( 'pin' ) );
		
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			
			$where_array ['uc.user_id'] = $result;
			if($challenge_id != null && $challenge_id > 0)
				$where_array ['uc.id'] = $challenge_id;
			$where_array ['uc.row_status'] = 1;
			
			$result = $this->user->challengesData ( $where_array );
			echo "<pre>";
			print_r ( $result );
			exit ();
			// echo $this->user->returnUserPIN($where_array);exit();
		}
	}
	function users_put($type = null, $type_id = -1) {
		$headers = getallheaders ();
		if (array_key_exists('access-token',$headers)){
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();//$user_access_token;exit();
		$result = $this->user->checkAccessTokenExist ( $user_access_token );
		// echo $result;exit();
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			
			switch ($type) {
				case 'weights' :
					// code...
					// $this->weights_get ( $user_id );
					break;
				case 'steps' :
					// code...
					break;
				case 'payments' :
					// code...
					break;
				case 'challenges' :
					// code...
					break;
				case 'goals' :
					// code...
					break;
				case 'config' :
					// code...
					$this->config_put (); // $user_access_token, $pin);
					break;
				case 'edit' :
					// code...
					break;
				default :
					// code...
					$this->editUsers_put ();
					break;
			}
			$this->response ( array (
					$user_id . " " . $type . " " . $type_id 
			), BAD_REQUEST );
			
			if (! $this->get ( 'id' )) {
				$this->response ( NULL, BAD_REQUEST );
			}
			
			$user = array (
					'returned: ' . $this->get ( 'id' ) 
			);
			
			if ($user) {
				$this->response ( $user, SUCCESS_OK );
			} else {
				$this->response ( NULL, PAGE_NOT_FOUND );
			}
		}
	}
	else
		$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
	}
	function users_post($type = null, $type_id = -1) {
		$headers = getallheaders ();
		if (array_key_exists('access-token',$headers)){
		$user_access_token = $headers ['access-token'];
		// echo trim ( $this->put ( 'pin' ) );exit();//$user_access_token;exit();
		$result = $this->user->checkAccessTokenExist ( $user_access_token );
		// echo $result;exit();
		if ($result == null) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			// $this->response ( "gfhgvhm", SUCCESS_OK );
			
			switch ($type) {
				case 'weights' :
					// code...
					//$this->weights_get ( $user_id );
					break;
				case 'steps' :
					// code...
					break;
				case 'payments' :
					// code...
					break;
				case 'challenges' :
					// code...
					break;
				case 'goals' :
					// code...
					break;
				case 'config' :
					// code...
					$this->config_post (); // $user_access_token, $pin);
					break;
				case 'edit' :
					// code...
					break;
				case 'usercards' :
					$this->savecard();
					break;
				case 'syncfitbit' :
					$this->syncfitbit();
					break;
				case 'payment' :
					$this->payment();
					break;
				case 'logout' :
					// code...
					$this->logout_post ();
					break;
				case 'photo' :
					$this->photo_post();
					break;
				default :
					// code...
					break;
			}
			$this->response ( array (
					$user_id . " " . $type . " " . $type_id 
			), BAD_REQUEST );
			
			if (! $this->get ( 'id' )) {
				$this->response ( NULL, BAD_REQUEST );
			}
			
			$user = array (
					'returned: ' . $this->get ( 'id' ) 
			);
			
			if ($user) {
				$this->response ( $user, SUCCESS_OK );
			} else {
				$this->response ( NULL, PAGE_NOT_FOUND );
			}
		}
	}
	else
		$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
	}
	function users_get($type = null, $type_id = -1, $subtype = null) {
		$headers = getallheaders ();
		if (array_key_exists('access-token',$headers)){
			$user_access_token = $headers ['access-token'];
		//echo $user_access_token;exit();
		$result = $this->user->checkAccessTokenExist ( $user_access_token );
		
		if ($result == false) {
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
		} else {
			// $this->response ( $result->logout_time, SUCCESS_OK );
			
			switch ($type) {
				case null :
					$this->accountDetails (true);
					// code...
					break;
				case 'policies' :
					if($subtype == null){
						$this->accountDetails (false);
					}
					else if($subtype == 'payments'){
						$this->paymentHistory ( $type_id );
					}
					// code...
					break;
				case 'weights' :
					// code...
					$this->weights ( $type_id );
					break;
				case 'steps' :
					// code...
					$this->steps ( $type_id );
					break;
				case 'payments' :
					// code...
					$this->paymentHistory ( $type_id );
					break;
				case 'challenges' :
					// code...
					$this->challenges ( $type_id );
					break;
				case 'goals' :
					// code...
					break;
				case 'config' :
					// code...
					// $this->config_get($user_access_token);
					break;
				case 'edit' :
					// code...
					break;
				case 'usercards' :
					// code...
					$this->usercards();
					break;
				default :
					// code...
					break;
			}
			$this->response ( array (
					$user_id . " " . $type . " " . $type_id 
			), BAD_REQUEST );
			
			if (! $this->get ( 'id' )) {
				$this->response ( NULL, BAD_REQUEST );
			}
			
			$user = array (
					'returned: ' . $this->get ( 'id' ) 
			);
			
			if ($user) {
				$this->response ( $user, SUCCESS_OK );
			} else {
				$this->response ( NULL, PAGE_NOT_FOUND );
			}
		}

		}
		else
			$this->generateErrorMessage ( BAD_REQUEST, "Invalid Access Token" );
	}
	
	/**
	 * Retrives user details of $user_id
	 * 
	 * @param array $user_id        	
	 * @return s user details
	 */
	function accountDetails($getPerson) {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );
		
		if (! $data ['user_id'])
			$this->generateErrorMessage(BAD_REQUEST, "Enter valid user id");
		
		$where_array = $data;
		if($getPerson)
			$person_data = $this->user->getUserDetails ( $where_array );
		$policy_data = $this->user->getPolicyDetails ( $where_array );
		
		for( $i = 0 ; $i < count($policy_data) ; $i++){
			$policy_data[$i]['plan_name'] = ucwords($policy_data[$i]['plan_name']);
			$policy_data[$i]['first_name'] = ucwords($policy_data[$i]['first_name']);
			$policy_data[$i]['last_name'] = ucwords($policy_data[$i]['last_name']);
				
		}
		
		$this->response ( array (
				'type' => 'users',
				'id' => 'id',
				'data' => array (
						'person' => $person_data,
						'policy' => $policy_data 
				) 
		) , SUCCESS_OK );
	}
	
	/**
	 * Retrives the steps of $user_id
	 * 
	 * @param array $user_id        	
	 * @param array $type_id        	
	 * @return steps and ranges
	 */
	function steps($type_id) {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );
		
		$current_date = date ( "d" );
		$current_month = date ( "m" );
		$current_year = date ( "Y" );
		
		$data ['month'] = $current_month;
		$data ['year'] = $current_year;
		
		if (! $data ['user_id'] || ! $data ['month'] || ! $data ['year'])
			$this->generateErrorMessage(BAD_REQUEST, "Enter valid user id");
		
		$where_array = $data;
		//$datesRanges = $this->user->datesRanges ( $where_array );
		//$response_data ['range'] = $datesRanges ['range'];
		$month_data = $this->user->userSteps ( $where_array );
		
		$reverse_steps = array_reverse ( array_splice ( $month_data ['month_steps'], 0, $current_date ) );
		$response_data ['steps'] = $reverse_steps;
		$response_data ['range'] = $month_data ['range'];
		$response_data ['days_to_go'] = $month_data ['days_to_go'];
		
		if ($type_id > 0 && $type_id <= count ( $reverse_steps )) {
			$this->response ( $response_data ['steps'] [$type_id - 1]  );
		}
		
		$this->response (array (
				'type' => 'steps',
				'id' => 'id',
				'data' => $response_data 
		 ), SUCCESS_OK );
	}
	
	/**
	 * Retrives the weights of $user_id
	 * 
	 * @param array $user_id        	
	 * @param array $type_id        	
	 * @return weights and ranges
	 */
	function weights($type_id) {
		$headers = getallheaders ();
		
		$user_access_token = $headers ['access-token'];
		$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );
		
		$current_date = date ( "d" );
		$current_month = date ( "m" );
		$current_year = date ( "Y" );
		
		$data ['month'] = $current_month;
		$data ['year'] = $current_year;
		
		// $this->response($data, SUCCESS_OK);
		
		if (! $data ['user_id'] || ! $data ['month'] || ! $data ['year'])
			$this->generateErrorMessage(BAD_REQUEST, "Enter valid user id");
		
		$where_array = $data;
		$datesRanges = $this->user->datesRanges ( $where_array );
		
		$month_data = $this->user->userWeights ( $where_array );
		// $this->response($month_data);
		// $previous_weight = $this->user->previousWeight($where_array);
		$response_data ['range'] = $datesRanges ['range'];
		// $response_data['previous_weight'] = $previous_weight['previous_weight'];
		
		$most_recent_weight = 0;
		$reverse_weights = array_reverse ( array_splice ( $month_data ['month_weights'], 0, $current_date ) );
		$weights_length = count ( $reverse_weights );
		$response_data ['weights'] = $reverse_weights;
		
		for($k = 0; $k < $weights_length; $k ++) {
			
			if ($reverse_weights [$k] ['weight'] != null) {
				$most_recent_weight = $reverse_weights [$k] ['weight'];
				break;
			}
		}
		
		if ($most_recent_weight == 0) {
			$response_data ['most_recent_weight'] = 127; // $res['previous_weight'];
		} else {
			$response_data ['most_recent_weight'] = $most_recent_weight;
		}
		
		if ($type_id > 0 && $type_id <= count ( $reverse_weights )) {
			$this->response ( $response_data ['weights'] [$type_id - 1]  );
		}
		
		$this->response ( array (
				'type' => 'weights',
				'id' => 'id',
				'data' => $response_data 
		) , SUCCESS_OK );
	}
	
	function user_post() {
		$result = $this->user_model->update ( $this->post ( 'id' ), array (
				'name' => $this->post ( 'name' ),
				'email' => $this->post ( 'email' ) 
		) );
		
		if ($result === FALSE) {
			$this->response ( array (
					'status' => 'failed' 
			) );
		} 

		else {
			$this->response ( array (
					'status' => 'success' 
			) );
		}
	}
	
	function paymentHistory($type_id){
	
		$headers = getallheaders();
	
		$user_access_token = $headers['access-token'];
		$data['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );
		$data['type_id'] = $type_id;
	
		if(!$data['user_id'])
			$this->response(
					array(
							'errors' => array(
									array(  'status' => BAD_REQUEST,
											'detail' => "Enter valid user id"  ))));
			
		$where_array= $data;
		$response_data = array_reverse($this->user->getPaymentHistory($where_array));
	
		$this->response(array('type' => 'payments',
				'id' => 'id',
				'data' => array('payments' => $response_data)), SUCCESS_OK);
			
	}
	
	function generateErrorMessage($status, $message) {
		$this->response (  array (
				'errors' => array (
						array (
								'status' => $status,
								'detail' => $message 
						) 
				) 
		) );
	}
	
	public function queryBuilder_post(){
		
		$table['steps'] = 'user_steps';
		$table['weight'] = 'user_weights';
		$table['cardio'] = 'user_cardio';
		$table['age'] = 'age';
		
		$queryBuilder = array();
		$queryBuilder['noOfRules'] = $this->input->post('noOfRules');
		$queryBuilder['field'] = $this->input->post('field');
		$queryBuilder['relationship'] = $this->input->post('relationship');
		$queryBuilder['goal'] = $this->input->post('goal');
		$queryBuilder['arithmetic'] = $this->input->post('arithmetic');
		
		$queryBuilder['user_id'] = $this->input->post('user_id');
		
		//array_push($queryBuilder, $noOfRules, $arith, $field, $table[$field], $relationship, $goal);
		print_r($queryBuilder);
		//exit();
		switch ( $queryBuilder['noOfRules'] ){
			case "1":
				$singleQuery = "SELECT %%arith%%(%%table_name%%.%%field%%) from %%table_name%% where %%table_name%%.user_id = %%user_id%% GROUP BY %%table_name%%.user_id having %%arith%%(%%table_name%%.%%field%%) %%relationship%% %%goal%%;";
				
				if($queryBuilder['arithmetic'] == 'difference')
					$singleQuery = str_replace("%%arith%%(%%table_name%%.%%field%%)", "max(%%table_name%%.%%field%%) - min(%%table_name%%.%%field%%)", $singleQuery);
				if ($queryBuilder['field'] == 'weight')
					$singleQuery = 
				$singleQuery = str_replace("%%field%%", $queryBuilder['field'], $singleQuery);
				$singleQuery = str_replace("%%table_name%%", $table[$queryBuilder['field']], $singleQuery);
				$singleQuery = str_replace("%%user_id%%", $queryBuilder['user_id'], $singleQuery);
				$singleQuery = str_replace("%%arith%%", $queryBuilder['arithmetic'], $singleQuery);
				$singleQuery = str_replace("%%relationship%%", $queryBuilder['relationship'], $singleQuery);
				$singleQuery = str_replace("%%goal%%", $queryBuilder['goal'], $singleQuery);
				
				echo $singleQuery;exit();
				break;
			default:
				
				break;
		}
	}


	/**
       * Screens in Android and iOS : Sync fitbit 
       * Method : POST
       * Sync user fitbit data
       * @param $user_id
       * @return $status
    */
    function syncfitbit()
        {
            /*
                Sent : user_id
            */

            $headers = getallheaders ();
			//echo "<pre>";print_r($headers);exit;
			$user_access_token = $headers ['access-token'];
			$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );    
            $user_id = $data ['user_id'];
            $data ['user_session_id'] = $this->user->getSessionIDFromAccessToken( $user_access_token );
            $user_session_id = $data ['user_session_id'];

            //checking for empty values START
            if(check_empty_values($data))
            {
                $this->response(array('status'=>0,'error' => 'Some Fields are missing'), 400);
            }
            //checking for empty values END

            $get_user_data = $this->user->getUsers(array('u.id'=>$user_id));
            if(count($get_user_data) > 0)
            {
                $user_data = $get_user_data[0]; 
                $user_data['user_session_id'] = $user_session_id;
                //echo "<pre>";print_r($user_data);exit;
                $result=$this->sync->syncUserFitbit($user_data);
            }  

            if($result==1)
            {
               $status=1;
               $msg="Synced Successfully";
            }
            else
            {
               $status=0;
               $msg="Operation Failed";
            }   
     
          
            $this->response ( array (
            		'type' => 'syncfitbit',
            		'id' => 'id',
            		'data' => array (
								'message' => $msg 
                    )
            ), SUCCESS_OK  );

        }



        /**
           * Screens in Android and iOS : get user added card 
           * Method : POST
           * Get User Credit Card Data
           * @param $access_token
           * @return $cards_data
        */
        function usercards()
        {
        	$headers = getallheaders ();
			//echo "<pre>";print_r($headers);exit;
			$user_access_token = $headers ['access-token'];
			$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );    
            $user_id = $data ['user_id'];

            if(!$data['user_id'])
            {
            	$this->response(array('status'=>0,'error' => 'Some Fields are missing'), 400);
            }

        	$user_data = $this->user->getUser ( array (
				'u.id' => $user_id 
		    ) );
            //echo "<pre>";print_r($user_data);exit; 
		    $user_email = $user_data->email;
			$user_stripe_customer_id = $user_data->stripe_customer_id;
            
            if($user_stripe_customer_id!="")
            { 
  				$stripeapi_response = $this->stripeapi->getCustomerCards ( $user_stripe_customer_id );
				$return_status = $stripeapi_response;
				$card_data=$return_status['response'];
			}
			else
			{
				$card_data=array();
			}	
               
            $this->response ( array (
            		'type' => 'cards',
            		'id' => 'id',
            		'data' => $card_data
            		) , SUCCESS_OK );
			
            exit;

        }



        /**
           * Screens in Android and iOS : get user added card 
           * Method : POST
           * save User Credit Card Data
           * @param $access_token,$card_number,$expiry_month,$expiry_year,$security_code
           * @return $card_data
        */
        function savecard()
        {
            /*
                Sent : user_id
            */

            $headers = getallheaders ();
			//echo "<pre>";print_r($headers);exit;
			$user_access_token = $headers ['access-token'];
			$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );    
            $user_id = $data ['user_id'];


            $card_data['card_number'] = trim($this->input->post('card_number'));
            $card_data['expiry_month'] = trim($this->input->post('expiry_month'));
            $card_data['expiry_year'] = trim($this->input->post('expiry_year'));
            $card_data['security_code'] = trim($this->input->post('security_code'));
            
            //checking for empty values START
            if(!$data['user_id'] && check_empty_values($card_data))
            {
            	$this->response(array('status'=>0,'error' => 'Some Fields are missing'), 400);
            }

        	$user_data = $this->user->getUser ( array (
				'u.id' => $user_id 
		    ) );
            //echo "<pre>";print_r($user_data);exit; 
		    $user_email = $user_data->email;
			$user_stripe_customer_id = $user_data->stripe_customer_id;
    

			$update_stripe_customer_id = "";
			if ($user_stripe_customer_id == "" || strlen ( $user_stripe_customer_id ) < 3) {
					$return_status = $this->stripeapi->createCardAndCustomer ( $card_data, $user_email );
					// echo "<pre>";print_r($stripeapi_response);exit;
					$user_stripe_customer_id = $return_status ['customer_id'];

					$update_data = array (
								"stripe_customer_id" => $user_stripe_customer_id 
					);
					$update_where = array (
								"id" => $user_id,
					);
					$update_user_data = $this->user->updateUserData ( $update_data, $update_where );

					if($update_user_data==0)
					{
						$return_status = array('status'=>0, 'response'=>"", "msg" => "Card Adding Failed"); 
					}	
					

			} else {
					$return_status = $this->stripeapi->addCustomerCard ( $card_data, $user_stripe_customer_id );
			}


            $this->response ( array (
            		'type' => 'cards',
            		'id' => 'id',
            		'data' => $return_status['response']
            		), SUCCESS_OK  );
			
            exit;

        }


        /**
           * Screens in Android and iOS : payment api 
           * Method : POST
           * Pay using credit card
           * @param $access-token,$pay_amount
           * @return $card_data
        */    
        function payment()
        {
            /*
                Sent : user_id
            */

            $headers = getallheaders ();
			//echo "<pre>";print_r($headers);exit;
			$user_access_token = $headers ['access-token'];
			$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );    
            $user_id = $data ['user_id'];
            $data['pay_amount'] = trim($this->input->post('pay_amount'));


            if(!$data['user_id'] && check_empty_values($data))
            {
            	$this->response(array('status'=>0,'error' => 'Some Fields are missing'), 400);
            }

        	$user_data = $this->user->getUser ( array (
				'u.id' => $user_id 
		    ) );
            //echo "<pre>";print_r($user_data);exit; 
		    $user_email = $user_data->email;
			$user_stripe_customer_id = $user_data->stripe_customer_id;

            $return_status = array('status'=>0, 'response'=>"", "msg" => "Payment Failed!"); 
			if( $user_stripe_customer_id != "" && $data['pay_amount'] > 0 )
            {
                        //echo $pay_amount;exit; 
                        $return_status=$this->stripeapi->makePayment( $user_stripe_customer_id , $data['pay_amount'] );
                        //echo "<pre>"; print_r( $return_status );exit;
            }
    
			$this->response ( array (
						'type' => 'payment',
						'id' => 'id',
						'data' => $return_status['response']
			), SUCCESS_OK  );
			exit;       

        }    

        public function photo_post() {
		//echo 1;
		try {
			
			// Get image string posted from Android App
			$base = $_REQUEST ['image'];
			// Get file name posted from Android App
			$filename = $_REQUEST ['filename'];
			
			$headers = getallheaders ();
			//echo "<pre>";print_r($headers);exit;
			$user_access_token = $headers ['access-token'];
			$data ['user_id'] = $this->user->getUserIDFromAccessToken ( $user_access_token );
			
			$user_id = $data ['user_id'];
			$user_session_id = $this->user->getUserSessionFromAccessToken ( $user_access_token );
				
			// Decode Image
			$binary = base64_decode ( $base );
			//echo "hiiiii";exit();
			header ( 'Content-Type: bitmap; charset=utf-8' );
			// Images will be saved under 'www/imgupload/uplodedimages' folder
			$filename = preg_replace('/\s+/', '', $filename);
			$file = fopen ( './assets/uploadedfiles/profile_pictures/' . $filename, 'wb' );
			// Create File
			chmod($file, 0777);
			fwrite ( $file, $binary );
			chmod($file, 0777);
			fclose ( $file );
			$status = $this->user->updatePhotoMobile($filename, $user_session_id, $user_id);
			//echo $status;exit();
			if($status == 0){
				//echo "Unsuccessfull";
				generateErrorMessage(BAD_REQUEST, "Upload Failed");
			} else {
				$this->response ( array (
						'type' => 'photo',
						'id' => 'id',
						'data' => array(
								'message' => 'Profile Photo Updated Successfully'
						)
				) , SUCCESS_OK );
			}
		} catch ( Exception $ex ) {
			echo $ex;
		}
	}
}
?>
