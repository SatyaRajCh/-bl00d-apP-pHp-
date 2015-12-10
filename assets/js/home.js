 /**
 * Home Class
 */
var base_url = '';
var Home = function () {
	
	
	var _this = this;
	currentHash = document.location.hash ;

	this.getProtection = function () {
		$('#protection_links').on('click', 'a', function (e) {
			e.preventDefault();
			var id = $(this).attr('id');
			var protection = $(this).text();
			$('#protection_links a').removeClass('active');
			$('#' + id).addClass('active');
			$('#protection').val(protection);
			$('#protection').trigger('change');
			_this._slideFadeIn($('#user_details'));
		});
		// dropping down the details if hash is show_details
		if (currentHash == '#show') {
			$('#user_details').show();
		}
		// changing protection should alter the tab too
		$('#user_details').on('change', '#protection', function () {
			var value = $(this).val();
			$('#protection_links a').removeClass('active');
			if (value == '$250,000') {
				$('#p250').addClass('active');
			} else {
				$('#p500').addClass('active');
			}
		});
	};

	
	this.getEstimate = function (origin) {
		$(document).on('click', '#get_estimate', function (e) {
			e.preventDefault();

			var v = new Validation();

			var age = $('#age').val();
			var gender = $('#gender').val();
			var smoker = $('#smoker').val();
			var areaCode = $('#area').val();
			var health = $('#health').val();
			var duration = $('#duration').val();
			var protection = $('#protection').val();
			var name = $('#name').val();
			var email = $('#email').val();
			var arealength = areaCode.length;
			var pattern = /^[a-zA-Z0-9._-]+@[a-zA-Z]+\.[a-zA-Z]{2,4}$/; 
			//alert('hi');
			//alert(arealength);
			if (v.isInteger(age) && v.isInteger(areaCode) 
				&& v.isInteger(duration) && v.empty(protection) == false 
				&& duration <= 30 && age >= 18 && age <= 100 && email!="" && pattern.test(email) == true && arealength == 5) {
				//alert(1);return false;
				// validation succeeded
				var user = new User();
				 
				user.saveInfo({
					age: age,
					gender: gender,
					smoker: smoker,
					area_code: areaCode,
					health: health,
					duration: duration,
					protection: protection,
					name: name,
					email: email,
					origin: origin,
					send_email: 'yes'
				}, function (success, error, response) {
					if (success == true && response.status == 'success') {
						//window.location = '/users/estimate';
						window.location =  base_url +'/result_quote';
					} else if (error == true) {
						console.log(error);
					}
				});
			} else { //alert(2);return false;
				if (v.isInteger(age) == false || age < 18 || age > 100)
					$('#age_error').fadeIn();
				else
					$('#age_error').fadeOut();
				if (v.isInteger(areaCode) == false) 
					$('#area_error').fadeIn();
				else
					$('#area_error').fadeOut();
				if (arealength != 5)
					$('#area_error').fadeIn();
				else
					$('#area_error').fadeOut();

				if (v.isInteger(duration) == false || duration > 30)
					$('#duration_error').fadeIn();
				else
					$('#duration_error').fadeOut();
				if (v.empty(email) == true || email=="")
					$('#email_error').fadeIn();
				else
					$('#email_error').fadeOut();
				if ( email != "" && pattern.test(email) == false )
					$("#valid_email_error").fadeIn();
				else
					$("#valid_email_error").fadeOut();
			}
		});
	};


	this.finalUserInfo = function () {
		$(document).on('click', '.save_details', function (e) {
			e.preventDefault();
			
			var v = new Validation();

			var name = $('#name').val();
			var email = $('#email').val();
			var origin = $(this).attr('data-origin');

			if (typeof origin == 'undefined' || origin == '') {
				origin = 'unknown';
			}
			
			if (v.empty(email) == false) {
				var user = new User();
				user.saveInfo({
					name: name,
					email: email,
					origin: origin,
					send_email: 'yes'
				}, function (success, error, response) {
					if (success == true && response.status == 'success') {
						window.location = base_url + '/home/thanks';
					} else if (error == true) {
						console.log(error);
					}
				});
			}
		});
	};


	this.getMillenialEstimate = function (origin) {
		$(document).on('click', '#get_millenial_estimate', function (e) {
			e.preventDefault();

			var v = new Validation();

			var age = $('#age').val();
			var name = $('#name').val();
			var email = $('#email').val();
			var gender = $('#gender').val();
			var smoker = $('#smoker').val();
			var areaCode = $('#area').val();
			var health = $('#health').val();
			var duration = $('#duration').val();
			var protection = $('#protection').val();
			if (v.isInteger(age) && v.isInteger(areaCode) 
				&& v.isInteger(duration) && v.empty(protection) == false 
				&& v.empty(name) == false && v.empty(email) == false 
				&& duration <= 30 && age >= 18 && age <= 65) {
				// validation succeeded
				var user = new User();
				user.saveInfo({
					age: age,
					name: name,
					email: email,
					gender: gender,
					smoker: smoker,
					area_code: areaCode,
					health: health,
					duration: duration,
					protection: protection,
					origin: origin,
					send_email: 'yes',
					'version': 'm'
				}, function (success, error, response) {
					if (success == true && response.status == 'success') {
						window.location = base_url + '/millenial/thanks';
					} else if (error == true) {
						console.log(error);
					}
				});
			} else {
				if (v.isInteger(age) == false || age < 18 || age > 100)
					$('#age_error').fadeIn();
				else
					$('#age_error').fadeOut();
				if (v.isInteger(areaCode) == false)
					$('#area_error').fadeIn();
				else
					$('#area_error').fadeOut();
				if (v.isInteger(duration) == false || duration > 30)
					$('#duration_error').fadeIn();
				else
					$('#duration_error').fadeOut();
				if (v.empty(email) == true)
					$('#email_error').fadeIn();
				else
					$('#email_error').fadeOut();
				if (v.empty(name) == true)
					$('#name_error').fadeIn();
				else
					$('#name_error').fadeOut();
			}
		});
	};


	this.viewProducts = function () {
		$(document).on('click', '#view_products', function (e) {
			e.preventDefault();
			_this._slideFadeIn($('#products'));
		});
	};


	this.getInTouch = function () {
		$(document).on('click', '#get_in_touch', function (e) {
			e.preventDefault();
			$('.overlay_section, .overlay').fadeIn();
		});
	};

	this.closeOverlay = function () {
		$(document).on('click', '.overlay_close, .close', function (e) {
			e.preventDefault();
			e.stopPropagation();
			$('.overlay_section, .overlay, .overlay2').fadeOut();
		});
	};

	this._slideFadeIn = function (instance) {
		instance.css('opacity', 0)
			.slideDown('slow')
			.animate(
				{ opacity: 1 },
				{ queue: false, duration: 1000 }
			);
			setTimeout(function () {
				$('body').animate({
					scrollTop: $("#premium_form").offset().top
				}, 1000);
			}, 1000);
	};

	this.goToProtection = function () {
		var elements = '#get_quote_v1, #get_quote_v2, #get_quote1_v2, ' + 
			'#get_quote2_v2, #get_quote3_v2, #get_quote_v2a, #get_quote1_v2b,' +
			'.goto_protection';
		$(document).on('click', elements, function (e) {
			e.preventDefault();
			$('body').animate({
				scrollTop: $("#protection_selection").offset().top
			}, 2000);
		});
	};

	this.scroll = function () {
		$(document).on('click', '.scroll', function (e) {
			e.preventDefault();
			var scrollTo = $(this).attr('data-scroll');
			$('body').animate({
				scrollTop: $('#' + scrollTo).offset().top
			}, 1000);
		});
	};


	this.init = function () {
		this.scroll();
	};


	this.init();

};