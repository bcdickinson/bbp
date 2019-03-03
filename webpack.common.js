const path = require('path');

module.exports = {
  entry: './bbp/static_src/js/main.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'bbp/static_build/js')
  }
};
