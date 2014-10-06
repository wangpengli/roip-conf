fs = require("fs")
path = require("path")
nconf = require("nconf")
require("jsonminify")

loadConfig = (method, configFile)->
  if configFile
    if fs.existsSync(configFile)
      config = null
      try
        console.log "#{method} - loading config file: #{configFile}"
        config = JSON.parse(JSON.minify(fs.readFileSync(configFile, encoding: 'utf8')))
      catch err
        console.error "#{method} - error parsing config file:", configFile, err
        process.exit(1)
      nconf[method](config)
    else
      console.error "#{method} - config file does not exist:", configFile
      process.exit(1)

dumpConfig = ->
  process.argv.forEach (val, index)->
    console.log("ARGV", index + ': ' + val)
  config = nconf.get()
  for key in _.keys(config)
    if key.indexOf('_') isnt 0
      console.log key, "=", config[key]

dumpConfig()

init = ->
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
  loadConfig('overrides', nconf.get("overrides"))
  loadConfig('defaults', nconf.get("defaults"))

get = (key)->
  return nconf.get(key)

module.exports =
  init: init
  get: get