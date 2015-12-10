/**
 * Validation Class
 */

var Validation = function () {
	

	_this = this;


	/**
	 * Detects if given data is integer
	 * @param  {string/int} data
	 * @return {boolen}
	 */
	
	this.isInteger = function (data) {
		return !isNaN(data) 
			&& parseInt(Number(data)) == data 
			&& !isNaN(parseInt(data, 10));
	};


	/**
	 * Checks if the data is empty
	 * @param  {string} data
	 * @return {boolean}
	 */
	
	this.empty = function (data) {
		if (data == '') {
			return true;
		} else {
			return false;
		}
	};


	/**
	 * Constructor
	 */
	
	this.init = function () {
	};


	this.init();

};