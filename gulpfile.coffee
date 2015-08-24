path = require('path')
gulp = require('gulp')
gutil = require 'gulp-util'

runSequence = require('run-sequence')

del = require('del')

webpack = require 'webpack'

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
#  src(['src/html/**/*.*'], {cache:'copy'}).to( 'dist/html')
#  src(['src/css/**/*.css'], {cache:'copy'}).to( 'dist/css')
#  src(['src/img/**/*.*'], {cache:'copy'}).to( 'dist/img')
#  src(['src/static/js/**/*.min.js'], {cache:'copy'}).to( 'dist/static/js')
#  src(['src/static/css/*.css'], {cache:'copy'}).to( 'dist/static/css')

jsFiles = ['src/js/**/*.js', 'test/**/*.js']

uglify = require('gulp-uglify')

task 'uglify', ->
  src('src/js/jq-mini.js').pipe(uglify()).pipe(gulp.dest('dist/js'))

{makeWebpackConfig, makeWebpackDevServer} = require './webpack.config'

distOptions =
  entry:
    generic: './src/generic',
  outputPath: './dist'
  filename: '[name]-bundle.js'
  minify: argv.env=='dist'
  pathinfo: argv.env!='dist'
  debug: argv.env!='dist'
  quiet: argv.env!='dist'


testOptions =
  entry: './test/mocha-index',
  outputPath: './test-build'
  filename: 'mocha-index.js'

webpackOptionsList = [distOptions, testOptions]

webpackRun = (entry, output, options) ->
  config = makeWebpackConfig(entry, output, options)
  webpackCompiler = webpack(config)
  webpackCompiler.run(->)

webpackDistribute = (mode) ->
  plugins = [new webpack.optimize.UglifyJsPlugin({minimize: true})]
  #plugins = [new ClosureCompilerPlugin()]
  webpackRun('./src/genetic', 'genetic.min.js', {path:'dist', pathinfo:false, libraryTarget:'umd', library:'genetic', plugins})
  pathinfo = mode=='dev'
  if mode=='dev' then plugins = []
  webpackRun('./src/genetic', 'genetic.js', {path:'dist', pathinfo:pathinfo, libraryTarget:'umd', library:'genetic', plugins})
  webpackRun('./test/mocha/index', 'mocha-index.js', {path:'test-build', pathinfo:pathinfo, plugins})
#  webpackRun('./demo/index', 'demo-index.js', {path:'dist', pathinfo:pathinfo, plugins})

task 'webpack-dist', () -> webpackDistribute('dist')
task 'webpack-dev', () -> webpackDistribute('dev')

task 'webpack-server', ->
  webServerPlugins = [
    new webpack.HotModuleReplacementPlugin()
    new webpack.NoErrorsPlugin()
  ]
  makeWebpackDevServer(["webpack/hot/dev-server", './src/genetic'], 'genetic.js', {port:8083, libraryTarget:'umd', library:'genetic', inline:true, plugins:webServerPlugins})
  makeWebpackDevServer(["webpack/hot/dev-server", './test/mocha/index'], 'mocha-index.js', {port:8088, plugins:webServerPlugins})
#  makeWebpackDevServer(["webpack/hot/dev-server", './demo/index'], 'demo-index.js', {port:8089, plugins:webServerPlugins})

task 'build', (callback) -> runSequence 'clean', 'copy', ['webpack-dist'], callback

task 'dev', (callback) -> runSequence 'clean', 'copy', ['webpack-dev'], callback

task 'wp-server', (callback) -> runSequence 'clean', 'copy', ['webpack-server'], callback

task 'default', ['wp-server']