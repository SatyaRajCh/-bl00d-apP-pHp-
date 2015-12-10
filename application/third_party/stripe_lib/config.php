<?php
require_once('vendor/autoload.php');

/*$stripe = array(
  secret_key      => getenv('secret_key'),
  publishable_key => getenv('publishable_key')
);*/

$stripe = array(
  'secret_key'      => 'sk_test_W0ccvrOo9HBx7euXeTFy7asf',
  'publishable_key' => 'pk_test_cSyZslQRUmwOXDl6f8Q1qkTu'
);

\Stripe\Stripe::setApiKey($stripe['secret_key']);
?>