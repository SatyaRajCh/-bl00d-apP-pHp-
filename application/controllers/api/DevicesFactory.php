<?php
require (APPPATH . 'controllers/api/HealthApp.php');
class DevicesFactory {
	public function getDevice($device_name){
		if($device_name == null){
			return null;
		}
		if($device_name == "healthapp"){
			return new HealthApp();

		} else if($device_name == "fitbit"){
			return new HealthApp();

		}
		return null;
	}
} 
?>