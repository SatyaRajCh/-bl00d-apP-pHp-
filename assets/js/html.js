/**
 * Html Class
 */

var Html = function () {
	
	var _this = this;

	/**
	 * returns a HTML tag
	 * @param  {string} tag  - HTML tag
	 * @param  {string} data - data inside a tag
	 * @param  {object} opts - HTML attributes
	 * @return {string}      - completed HTML tag with attributes
	 */

	this.tag = function (tag, data, opts) {
		var params = '';

		if (typeof opts == 'object') {
			for (key in opts) {
				params += key + '="' + opts[key] + '" ';
			}
		}
		return '<' + tag + ' ' + params + '>' + data + '</' + tag + '>';
	};

	/**
	 * Constructor
	 */
	
	this.init = function () {
	};

	this.init();

};