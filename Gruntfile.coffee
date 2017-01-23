module.exports = (grunt) ->
  postcssConfig = require("./bower_components/bootstrap/grunt/postcss")
  require("load-grunt-tasks")(grunt)

  grunt.initConfig
    sass:
      options:
        includePaths: ["_sass"]
        precision: 6
        sourceComments: false
        sourceMap: false
        outputStyle: "expanded"
      build:
        files: [{
          ".build/theme.css": "_sass/theme.scss"
        }]
    postcss:
      options:
        map: false
        processors: [
          require('postcss-flexbugs-fixes')({}),
          require('autoprefixer')(postcssConfig.autoprefixer)
        ]
      build:
        src: ".build/*.css"
    cssmin:
      options:
        compatibility: "ie9,-properties.zeroUnits"
        sourceMap: true
        advanced: false
      build:
        files: [{
          expand: true
          cwd: ".build"
          src: ["*.css", "!*.min.css"]
          dest: "assets/stylesheets"
          ext: ".min.css"
        }]
    # copy:
    #   js:
    #     files: [
    #       {expand: true, cwd: "bower_components/bootstrap/dist/js", src: "*.js", dest: 'assets/javascripts'},
    #       {expand: true, cwd: "bower_components/tether/dist/js", src: "*.js", dest: 'assets/javascripts'},
    #       {expand: true, cwd: "bower_components/jquery/dist", src: "jquery.min.*", dest: 'assets/javascripts'}
    #     ]
    clean:
      build: ['.build']
    watch:
      sass:
        files: "_sass/**/*.scss"
        tasks: ["css"]

  grunt.registerTask "css", ["sass:build", "postcss:build", "cssmin:build", "clean:build"]
  grunt.registerTask "default", ["css", "watch:sass"]
