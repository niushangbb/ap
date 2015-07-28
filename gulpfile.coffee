path = require('path')
gulp = require('gulp')
gutil = require 'gulp-util'

runSequence = require('run-sequence')

del = require('del')

jsValidate = require('gulp-jsvalidate')
jshint = require('gulp-jshint')

webpack = require 'webpack'

mochaPhantomJS = require('gulp-mocha-phantomjs')

minimist = require('minimist')
argv = minimist(process.argv.slice(2))

do ->
  if argv.debug then argv.env = 'debug'
  if argv.dist then argv.env = 'dist'
  if argv.t then argv.test = true
  if argv.p then argv.env = 'dist'

console.log JSON.stringify(argv)

task = gulp.task.bind(gulp)
watch = gulp.watch.bind(gulp)
src = gulp.src.bind(gulp)
dest = gulp.dest.bind(gulp)

srcStream = src('').constructor
srcStream::to = (dst) -> @pipe(dest(dst))
srcStream::pipelog = (obj, log=gutil.log) -> @pipe(obj).on('error', log)

task 'clean', -> del.sync(['test-build', 'dist'])

task 'copy', ->
  #src(['test/**/*.json', 'test/**/*.html', 'test/**/*.css'], {cache:'copy'}).to( 'test-build')
  src(['src/html/**/*.*'], {cache:'copy'}).to( 'dist/html')
  src(['src/css/**/*.css'], {cache:'copy'}).to( 'dist/css')
  src(['src/img/**/*.*'], {cache:'copy'}).to( 'dist/img')
  src(['src/js/purchase-3.6.js', 'src/js/jq-mini.min.js'], {cache:'copy'}).to( 'dist/js')
  src(['src/static/js/**/*.min.js'], {cache:'copy'}).to( 'dist/static/js')
  src(['src/static/css/*.css'], {cache:'copy'}).to( 'dist/static/css')

jsFiles = ['src/js/**/*.js', 'test/**/*.js', 'rad/js/**/*.js']

task 'validjs', -> src(jsFiles).pipe(jsValidate())

task 'lint', -> src(jsFiles).pipe(jshint())

task 'jsok', ['validjs', 'lint']

uglify = require('gulp-uglify')

task 'uglify', ->
  src('src/js/jq-mini.js').pipe(uglify()).pipe(gulp.dest('dist/js'))

makeWebpackConfig = require './webpack.config'

distOptions =
  entry:
    cards: './src/js/entries/cards',
    tasks: './src/js/entries/tasks',
    doits: './src/js/entries/doits'
  outputPath: './dist/js'
  filename: '[name]-bundle.js'
  commons: "commons-bundle.js"
  minify: argv.env=='dist'
  pathinfo: argv.env!='dist'
  debug: argv.env!='dist'
  quiet: argv.env!='dist'


testOptions =
  entry: './test/mocha-phantomjs-index',
  outputPath: './test-build'
  filename: 'mocha-phantomjs-index.js'

webpackOptionsList = [distOptions, testOptions]

task 'webpack-run', (done) ->
  for options in webpackOptionsList
    config = makeWebpackConfig(options)
    webpack(config).run (err, stats) ->
      if err then console.log('Error', err)
      else console.log(stats.toString())
#      done()

task 'webpack-watch', (done) ->
  for options in webpackOptionsList
    config = makeWebpackConfig(options)
    webpack(config).watch 100, (err, stats) ->
      if err then console.log('Error', err)
      else console.log(stats.toString())
#      done()

task 'watch',  ->
  #gulp.watch ['test/**/*.css', 'test/**/*.html','test/**/*json'], ['copy']

task 'build', (callback) -> runSequence 'clean', 'copy', ['webpack-run'], callback

task 'build-watch', (callback) -> runSequence 'clean', 'copy', ['webpack-watch'], callback #'watch',

task 'default', ['build-watch']