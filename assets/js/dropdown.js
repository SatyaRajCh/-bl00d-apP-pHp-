/**
 * Dropdown Class
 */

var Dropdown = function (clas) {
	
	var _this = this;
	var CLASS = clas;
	// element classes used for UI
	var DROPDOWN_BTN = 'dropdown';
	var DROPDOWN_OPTS = 'dropdown_options';
	var DROPDOWN_LINK = 'dropdown_link';


	/**
	 * Iterates each select element of given class
	 */
	
	this.customDropdowns = function () {
		$('.' + CLASS).each(function () {
			_this.renderDropdown($(this));
		});
	};


	/**
	 * Renders custom dropdown for given class
	 */
	
	this.renderDropdown = function (instance) {
		var HTML = new Html();
		var DROPDOWN_WIDTH = instance.attr('data-dropdown-width');
		if (typeof DROPDOWN_WIDTH == 'undefined' || DROPDOWN_WIDTH == '') {
			DROPDOWN_WIDTH = 'auto';
		}
		var label = instance.find('option[selected="selected"]').eq(0).text();
		if (label == '') {
			label = instance.find('option').eq(0).text();
		}
		var options = '';
		instance.find('option').each(function () {
			options += HTML.tag(
				'li',
				$(this).text(),
				{ 'data-option': $(this).attr('value') }
			);
		});
		
		// wrapping the select Element
		var dropdown = HTML.tag('span', '', { class: DROPDOWN_BTN });
		instance.wrap(dropdown);

		var ul = HTML.tag('ul', options, { class: DROPDOWN_OPTS });
		var link = HTML.tag('a', label, {
			href: '#',
			class: DROPDOWN_LINK,
			style: 'width: ' + DROPDOWN_WIDTH
		});
		instance.after(link + ul);
		instance.hide();
	};


	/**
	 * Dropdown functionality
	 */
	
	this.dropdownhandler = function () {
		$('.' + DROPDOWN_BTN).on('click', 'a', function (e) {
			e.preventDefault();
			// closing other dropdowns
			$('.' + DROPDOWN_OPTS).fadeOut();
			var opts = $(this).closest('.' + DROPDOWN_BTN)
				.find('.' + DROPDOWN_OPTS);
			opts.fadeIn();
		});

		$('.' + DROPDOWN_OPTS).on('click', 'li', function (e) {
			e.preventDefault();
			var label = $(this).text();
			var value = $(this).attr('data-option');
			var opts = $(this).closest('.' + DROPDOWN_OPTS);
			var select = $(this).closest('.' + DROPDOWN_BTN).find('select');
			select.val(value);
			select.trigger('change');
			opts.fadeOut();
		});

		$('.' + DROPDOWN_BTN).on('change', 'select', function () {
			var value = $(this).val();
			var label = $(this).find('option[value="' + value + '"]').text();
			var link = $(this).closest('.' + DROPDOWN_BTN).find('a');
			link.text(label);
		});

		// closing the dropdown after clicking on other elements
		$(document).click(function (e) {
			// console.log($(e.target));
			var targetClass = $(e.target).attr('class');
			if (targetClass != DROPDOWN_LINK) {
				$('.' + DROPDOWN_OPTS).fadeOut();
			};
		});
	};


	/**
	 * Constructor
	 */
	
	this.init = function () {
		this.customDropdowns();
		this.dropdownhandler();
	};

	this.init();

};