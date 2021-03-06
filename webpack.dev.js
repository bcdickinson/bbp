/* eslint-env node */
const common = require('./webpack.common.js');
const merge = require('webpack-merge');
const webpack = require('webpack');

module.exports = merge(common, {
  mode: 'development',
  devServer: {
    hot: true,
    host: '0.0.0.0',
    port: 3000,
    publicPath: process.env.WDS_PUBLIC_PATH,
    index: '',
    proxy: {
      '/': {
        target: process.env.WDS_PROXY_TARGET
      }
    }
  },
  devtool: 'eval-source-map',
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    rules: [
      {
        test: /\.s?css$/,
        use: [
          "style-loader",
          {
            loader: "css-loader",
            options: {
              sourceMap: true
            }
          },
          {
            loader: "sass-loader",
            options: {
              implementation: require("sass"),
              sourceMap: true
            }
          }
        ]
      }
    ]
  },
  output: {
    publicPath: 'http://localhost:3000/static/'
  }
});
