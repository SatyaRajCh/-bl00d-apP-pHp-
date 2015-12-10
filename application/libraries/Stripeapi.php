<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Stripeapi {
	
	public function __construct()
    {
        require APPPATH .'third_party/stripe_lib/vendor/autoload.php';
       	\Stripe\Stripe::setApiKey(STRIPE_SECRET_KEY);
    }


    /**
       * create stripe token using card 
       * @return boolean or error message
    */
    public function createCardAndCustomer($card_data,$user_email)
    {
    	try {
    		    $response = \Stripe\Token::create(array(
				  "card" => array(
				    "number" => $card_data['card_number'],
				    "exp_month" => $card_data['expiry_month'],
				    "exp_year" => $card_data['expiry_year'],
				    "cvc" => $card_data['security_code']
				  )
				));

		    	$response = $response->__toArray(true);
		    	$stripe_token = $response['id'];

				$customer = \Stripe\Customer::create(array(
			      'email' => $user_email,
			      'card'  => $stripe_token
			    ));
				
				$response = $customer->__toArray(true);
				//echo "<pre>";print_r($response);exit;
				$cards_data="";
				
                if(count($response) > 0)
                {
                	$response['card']=$response['sources']['data'][0]; 
                	$cards_data = array(
                		        'card_id' => $response['card']['id'],
                				'brand' => $response['card']['brand'],
                				'country' => $response['card']['country'],
                				'card_type' => $response['card']['funding'],
                				'exp_month' => $response['card']['exp_month'],
                				'exp_year' => $response['card']['exp_year'],
                				'last4digits' => $response['card']['last4'],
                				'address_zip' => $response['card']['address_zip']
                			); 
                }	

    			return array("status"=>1,"response"=>$cards_data,"customer_id"=>$response['id']);
		  }
		  catch (Exception $e) {
		  	  $error = $e->getMessage();
		  	  return array("status"=>0,"response"=>$error);
		  }	
    }


    /**
       * add card to customer 
       * @return boolean or error message
    */
    public function addCustomerCard( $card_data , $stripe_customer_id )
    {
    	try {
    		    $response = \Stripe\Token::create(array(
				  "card" => array(
				    "number" => $card_data['card_number'],
				    "exp_month" => $card_data['expiry_month'],
				    "exp_year" => $card_data['expiry_year'],
				    "cvc" => $card_data['security_code']
				  )
				));

		    	$response = $response->__toArray(true);
		    	$card_id=$response['card']['id'];
		    	$stripe_token = $response['id'];

			    $customer = \Stripe\Customer::retrieve($stripe_customer_id);
			    $customer->sources->create(array("card" => $stripe_token));
				$customer->default_source=$card_id;
				$customer->save(); 
				
				$customer_response = $customer->__toArray(true);

				$cards_data="";
                if(count($response['card']) > 0)
                {
                	$cards_data = array(
                		        'card_id' => $response['card']['id'],
                				'brand' => $response['card']['brand'],
                				'country' => $response['card']['country'],
                				'card_type' => $response['card']['funding'],
                				'exp_month' => $response['card']['exp_month'],
                				'exp_year' => $response['card']['exp_year'],
                				'last4digits' => $response['card']['last4'],
                				'address_zip' => $response['card']['address_zip']
                			); 
                }	
				
				
    			return array("status"=>1,"response"=>$cards_data,"msg"=>"");
		  }
		  catch (Exception $e) {
		  	  $error = $e->getMessage();
		  	  return array("status"=>0,"response"=>"","msg"=>$error);
		  }	
    }

    /**
       * update card in customer account 
       * @return boolean or error message
    */
    public function updateCustomerCard( $card_data , $stripe_customer_id )
    {
    	try {
    		    $response = \Stripe\Token::create(array(
				  "card" => array(
				    "number" => $card_data['card_number'],
				    "exp_month" => $card_data['expiry_month'],
				    "exp_year" => $card_data['expiry_year'],
				    "cvc" => $card_data['security_code']
				  )
				));

		    	$response = $response->__toArray(true);
		    	$stripe_token = $response['id'];

			    $customer = \Stripe\Customer::retrieve($stripe_customer_id);
			    $customer->card = $stripe_token;
				$customer->save();
				
				$customer_response = $customer->__toArray(true);
				
    			return array("status"=>1,"response"=>$response['card'],"customer_id"=>$customer_response['id']);
		  }
		  catch (Exception $e) {
		  	  $error = $e->getMessage();
		  	  return array("status"=>0,"response"=>$error);
		  }	
    }
    
    /**
       * makes payment with stripe token
       * @return boolean
    */ 
	public function makePayment( $customer_id , $amount )
    {	
  		  try {
		   	  $charge = \Stripe\Charge::create(array(
			      'customer' => $customer_id,
			      'amount'   => $amount,
			      'currency' => 'usd'
			  ));
		    return array("status"=>1,"response"=>$charge,"msg"=>"");
		  }
		  catch (Exception $e) {
		  	$error = $e->getMessage();
		  	return array("status"=>0,"response"=>$error,"msg"=>$error);
		  }    
    }


    /**
       * get cards in customer account 
       * @return boolean or error message
    */
    public function getCustomerCards( $stripe_customer_id )
    {
    	try {
			    $customer_cards = \Stripe\Customer::retrieve($stripe_customer_id)->sources->all(array(
				  "object" => "card"
				));
			    
				$response = $customer_cards->__toArray(true);
				//echo "<pre>";print_r($response);exit;

				$cards_data=array();
                if(count($response['data'])>0)
                {
                	foreach( $response['data']  as $cd )
                	{
                		$cards_data[] = array(
                				'card_id' => $cd['id'],
                				'brand' => $cd['brand'],
                				'country' => $cd['country'],
                				'card_type' => $cd['funding'],
                				'exp_month' => $cd['exp_month'],
                				'exp_year' => $cd['exp_year'],
                				'last4digits' => $cd['last4'],
                				'address_zip' => $cd['address_zip']
                			); 
                	}	
                }  
                 
    			return array("status"=>1,"response"=>$cards_data,"msg"=>"");
		  }
		  catch (Exception $e) {
		  	  $error = $e->getMessage();
		  	  return array("status"=>0,"response"=>"","msg"=>$error);
		  }	
    }
}

/* End of file Stripeapi.php */