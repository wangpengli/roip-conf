chai = require("chai")
assert = chai.assert
expect = chai.expect
should = chai.should()

conf = require('../../roip-conf')

describe 'RoIP Logger', ->
  beforeEach ->

  it 'should set env var', ->
    conf.set("LOG_LEVEL", "debug")
    conf.get("LOG_LEVEL").should.equal("debug")