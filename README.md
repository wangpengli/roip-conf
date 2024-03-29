roip-conf
=========

Configuration library for roip-enabled services

Priority of configuration sources:

1.  Command-line arguments
2.  Environment variables
3.  Overrides config file 
4.  Defaults config file

Command-line arguments (all optional):

* -d (or --defaults): path to the defaults config file.
* -o (or --overrides): path to the overrides config file.

Config files are parsed through JSON-minify, so you can use standard JavaScript comments in the JSON files.

Usage:
```
  var conf = require("roip-conf");
  conf.init();
  console.log(conf.get('MY-ENV-VAR'));
```

API:
* loadFile(method, configFile) - loads the specified config file.
    * method - either 'defaults' or 'overrides'.   
    * configFile - path to the config file.
* init() - initialize config with command-line, environment, overrides, and defaults.
* get(key) - get a config value
* set(key, value) - set a config value