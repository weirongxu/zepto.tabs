gulp = require 'gulp'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
jade = require 'gulp-jade'
stylus = require 'gulp-stylus'
nib = require 'nib'

gulp.task 'coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe coffee
      bare: true
    .pipe gulp.dest 'build'
    .pipe uglify()
    .pipe rename('zepto.tabs.min.js')
    .pipe sourcemaps.write('./')
    .pipe gulp.dest 'build'
    .pipe gulp.dest 'gh-pages'

gulp.task 'watch', ->
  gulp.watch 'src/**/*.coffee', ['coffee']

gulp.task 'default', ['coffee', 'watch']


gulp.task 'gh-pages:jade', ->
  gulp.src 'gh-pages/**/*.jade'
    .pipe plumber()
    .pipe jade()
    .pipe gulp.dest './gh-pages'

gulp.task 'gh-pages:stylus', ->
  gulp.src 'gh-pages/**/*.styl'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe stylus
      use: [ nib() ]
      compress: true
    .pipe sourcemaps.write('./')
    .pipe gulp.dest './gh-pages'

gulp.task 'gh-pages:watch', ->
  gulp.watch 'gh-pages/**/*.styl', ['gh-pages:stylus']
  gulp.watch 'gh-pages/**/*.jade', ['gh-pages:jade']

gulp.task 'gh-pages', ['gh-pages:jade', 'gh-pages:stylus', 'gh-pages:watch']
