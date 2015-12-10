// redirecting to http incase of https (Personaly doesn't work on http).
var protocol = document.location.protocol;
if (protocol == 'http:') {
	var httpUrl = document.location.href.replace('http:', 'https:');
	window.location.href = httpUrl;
}