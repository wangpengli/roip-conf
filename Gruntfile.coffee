"use strict"
module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig

  # Metadata.
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %>"

  # Task configuration.
    mochaTest:
      options:
        reporter: 'spec'
        timeout: 60000
        require: 'coffee-script'
        bail: yes
      test:
        src: ['test/**/*-spec.coffee']

  grunt.loadNpmTasks "grunt-mocha-test"

  grunt.registerTask "test", ["mochaTest"]
