const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const path = require('path');

module.exports = {
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name].css'
    })
  ],
  entry: ['./bbp/static_src/js/main.js', 'bbp/static_src/scss$/main.scss'],
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
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
    filename: 'js/[name].js',
    path: path.resolve(__dirname, 'bbp/static_build/')
  }
};
