const path = require('path');

const src_dir = path.resolve(__dirname, 'bbp/static_src');
const dist_dir = path.resolve(__dirname, 'bbp/static');

module.exports = {
    entry: path.resolve(src_dir, 'js/main.js'),
    output: {
      filename: 'main.js',
      path: path.resolve(dist_dir, 'js')
    },
    module: {
        rules: [
             {
                 test:/\.(s*)css$/,
                 use:['style-loader','css-loader', 'sass-loader']
             }
        ]
    }
};
