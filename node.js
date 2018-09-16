module.exports = function(input) {
	if(arguments.length < 1) {
		console.error("Usage: roller INPUT");
	} else {
		// Horrible hack
		eval(require('fs').readFileSync('dice.min.js')+'');
		dice.parse(input);
	}
}