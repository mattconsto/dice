var should = require('chai').should(), dice = require('../dice');

describe('#dice', function() {
	it('Roll d6', () => dice.parse('d6').should.be.within(1, 6));
	it('Roll 6d6', () => dice.parse('6d6').should.be.within(6, 36));
	it('Roll d6+10', () => dice.parse('d6+10').should.be.within(11, 16));
	it('Roll 100d6h5', () => dice.parse('100d6h5').should.be.not.empty);
});