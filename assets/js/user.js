/**
 * User Class
 */

var User = function () {
	

	var _this = this;


	/**
	 * Saves user information
	 * @param  {object}   params
	 * @param  {Function} callback
	 */
	
	this.saveInfo = function (params, callback) {
		var url = '/users/save_info';
		$.ajax({
			type: 'POST',
			url: url,
			data: params,
			cache: false
		}).done(function (r) {
			callback(true, null, r);
		}).fail(function (e) {
			callback(null, true, e);
		});
	};


	/**
	 * Logs user out
	 * @param  {object}   params
	 * @param  {Function} callback
	 */
	
	this.logOut = function (params, callback) {
		var url = '/users/logout';
		$.ajax({
			type: 'POST',
			url: url,
			data: params,
			cache: false
		}).done(function (r) {
			callback(true, null, r);
		}).fail(function (e) {
			callback(null, true, e);
		});
	};


	/**
	 * Constructor
	 */
	
	this.init = function () {
	};


	this.init();

};