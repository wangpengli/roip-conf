fs = require("fs")
path = require("path")
nconf = require("nconf")
require("jsonminify")

class RoipConf
  dumpConfig = ->
    process.argv.forEach (val, index)->
      console.log("ARGV", index + ': ' + val)
    config = nconf.get()
    for key of config
      if key.indexOf('_') isnt 0
        console.log key, "=", config[key]

  loadFile: (method, configFile)->
    unless method in ["defaults", "overrides"]
      throw new Error("Method must be either 'defaults' or 'overrides'")
    if configFile
      if fs.existsSync(configFile)
        config = null
        try
          console.log "#{method} - loading config file: #{configFile}"
          config = JSON.parse(JSON.minify(fs.readFileSync(configFile, encoding: 'utf8')))
        catch err
          console.error "#{method} - error parsing config file:", configFile, err
          throw new Error("Error parsing config file: " + configFile)
        nconf[method](config)
      else
        console.error "#{method} - config file does not exist:", configFile
        throw new Error("Config file does not exist: " + configFile)
    return @

  init: ->
    # The priority between different sources
    # ARGV > ENV > OVERRIDES > DEFAULTS
    nconf.argv
      "o":
        alias: 'overrides'
        describe: 'Overrides config file path.'
        demand: false
      "d":
        alias: 'defaults'
        describe: 'Defaults config file path.'
        demand: false

    nconf.env()
    @loadFile('overrides', nconf.get("overrides"))
    @loadFile('defaults', nconf.get("defaults"))
    dumpConfig()
    return @

  get: (key)->
    return nconf.get(key)

  set: (key, val)->
    nconf.set(key, val)
    return @

module.exports = new RoipConf()
