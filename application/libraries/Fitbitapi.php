<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Fitbitapi {
	
	public function __construct()
    {
        //parent::__construct();
        require APPPATH .'third_party/oauth_lib/http.php';
        require APPPATH .'third_party/oauth_lib/oauth_client.php';
        
       	$this->client = new oauth_client_class;
		$this->client->debug = 1;
		$this->client->debug_http = 1;
		$this->client->server = 'Fitbit';
		$this->client->redirect_uri = FITBIT_REDIRECT_URI;
			
		$this->client->client_id = CLIENT_KEY; $application_line = __LINE__;
		$this->client->client_secret = CLIENT_SECRET;
    }
    
    /**
       * returns fitbit user data
       * @return array returns array with data and status of api call
    */ 
	public function getFitbitUserData()
    {	
		    if(($success = $this->client->Initialize()))
			{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/profile.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
					
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
			}
    }


    /**
       * returns user fitbit devices
       * @return array returns array with data and status of api call
    */ 
	public function getFitbitDevicesData()
    {	
		    if(($success = $this->client->Initialize()))
			{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/devices.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
					
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
			}
    }

    /**
       * returns sorted array based on specfic key
       * @param $date string date to get steps from and format should be yyyy-MM-dd 
       * @param $period string no of days from that date
       * @return array returns array with data(steps count for that user) and status of api call
    */
    public function getStepsData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/activities/steps/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}  			
       
    }
    
    
    /**
       * returns sorted array based on specfic key
       * @param $date string date to get heart rate from and format should be yyyy-MM-dd 
       * @param $period string no of days from that date
       * @return array returns array with data(steps count for that user) and status of api call
    */
    public function getHeartRateData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/activities/heart/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}  			
       
    }


     /**
       * returns sorted array based on specfic key
       * @param $date string date to get heart rate from and format should be yyyy-MM-dd 
       * @param $period string no of days from that date
       * @return array returns array with data(calories count for that user) and status of api call
    */
    public function getCaloriesData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/activities/calories/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}  			
       
    }


    /**
       * returns user data
       * @param $date string date to get heart rate from and format should be yyyy-MM-dd 
       * @param $period string no of days from that date
       * @return array returns array with data(weight for that user) and status of api call
    */
    public function getWeightData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/body/log/weight/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}      
    }


    /**
       * returns user data
       * @param $date string date to get heart rate from and format should be yyyy-MM-dd 
       * @param $period string no of days from that date
       * @return array returns array with data(Heart rate for that user) and status of api call
    */
    public function getHeartData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/activities/heart/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}      
    }

    public function getTestData($date,$period)
    {
    	if(($success = $this->client->Initialize()))
		{
				if(($success = $this->client->Process()))
				{
					if(strlen($this->client->access_token))
					{
						$success = $this->client->CallAPI(
							'https://api.fitbit.com/1/user/-/body/log/weight/date/'.$date.'/'.$period.'.json', 
							'GET', array(), array('FailOnAccessError'=>true), $data);
		
					}
				}
				$success = $this->client->Finalize($success);
				
				if ($success)
				{
					return array('data'=>$data,'status'=>1,'err'=>'');
				}
				else {
					return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
				}   
		}

    	
		if ($success)
		{
			return array('data'=>$data,'status'=>1,'err'=>'');
		}
		else {
			return array('data'=>'','status'=>0,'err'=>HtmlSpecialChars($this->client->error));
		}      
    }


    public function resetAccessToken()
    {
    	unset($this->client->access_token);
    	unset($this->client->access_token_secret);
    }
}

/* End of file Fitbit.php */