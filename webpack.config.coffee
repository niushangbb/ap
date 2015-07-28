path = require 'path'
webpack = require('webpack')

module.exports = (options)->
  config =
    entry: options.entry

    output:
      path: path.join(__dirname, options.outputPath)
      filename: options.filename
      #pathinfo: options.pathInfo? or true

    quiet: options.quiet or false

    debug: options.debug or false

    resolve:
      extensions: ['', '.js', '.coffee']

    module:
      loaders: [
        { test: /\.css$/, loader: "style!css" }
        {test: /\.coffee$/, loader: "coffee"}
      ]

    plugins: []

  if options.commons then config.plugins.push new webpack.optimize.CommonsChunkPlugin(options.commons)
  if options.minify then config.plugins.push new webpack.optimize.UglifyJsPlugin({minimize: true})

  config
