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