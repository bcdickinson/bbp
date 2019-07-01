/* eslint-env node */
const BundleTracker = require('webpack-bundle-tracker');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const path = require('path');

module.exports = {
  entry: ['./bbp/static_src/js/main.js', './bbp/static_src/scss/main.scss'],
  plugins: [
    new BundleTracker({
      filename: 'webpack-stats.json',
      path: path.resolve(__dirname)
    }),
    new CleanWebpackPlugin({
      cleanOnceBeforeBuildPatterns: [
        '**/*',
        path.resolve(__dirname, 'webpack-stats.json')
      ]
    })
  ],
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'bbp/static_build/')
  },
  optimization: {
    minimizer: [new TerserPlugin()]
  }
};
