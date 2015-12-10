(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-64890304-1', 'auto');
ga('send', 'pageview');

// tracks all click events
$(document).ready(function () {
	$(document).on('click', 'a, .ga', function () {
		var version = $('#version').attr('data-version');
		var id = $(this).attr('id');
		var category = id + '_' + version;
		ga('send', 'event', category, 'click');
	});
});