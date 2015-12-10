<?php
require (APPPATH . '/libraries/REST_Controller.php');
require (APPPATH . 'controllers/api/DevicesFactory.php');
class Sync extends REST_Controller{	
	protected $user_steps = 'user_steps';
	function sync_post($device_name) {
		$input_data = trim ( $this->input->post ( 'data' ) );
		$dev_factory = new DevicesFactory();
		$device = $dev_factory->getDevice($device_name);
		$parsed_data = $device->getData($input_data);
		//$this->response($parsed_data);
		
		
	}
}

?>
