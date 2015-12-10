<?php
require (APPPATH . 'controllers/api/Devices.php');
class HealthApp extends Devices{
	public function getData($input_data){
		//$input_data = {"type":"weights","id":"id","data":{"range":[{"range":"December 1-3","start date":1,"end date":3,"step_count":0}],"weights":[{"weight":null,"weight_date":"December 3","weight_day":"Thu"},{"weight":null,"weight_date":"December 2","weight_day":"Wed"},{"weight":null,"weight_date":"December 1","weight_day":"Tue"}],"most_recent_weight":127}};
		return $input_data;
	}
} 
?>