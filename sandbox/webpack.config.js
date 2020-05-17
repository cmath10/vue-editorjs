const path = require('path')

const { CleanWebpackPlugin } = require('clean-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const VueLoaderPlugin = require('vue-loader/lib/plugin')

const PORT = 8080
const PORT_EXTERNAL = process.env.PORT_EXTERNAL || PORT

module.exports = {
  mode: 'development',
  entry: {
    main: path.resolve(__dirname, 'src/main.js'),
  },
  devtool: 'inline-source-map',
  module: {
    rules: [{
      test: /\.vue$/,
      loader: 'vue-loader',
    }, {
      test: /\.js$/,
      loader: 'babel-loader',
    }],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, 'public/index.html'),
      inject: 'body',
    }),
    new VueLoaderPlugin(),
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
    publicPath: '/',
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'public'),
    compress: true,
    host: '0.0.0.0',
    port: PORT,
    sockPort: PORT_EXTERNAL,
    inline: true,
    hot: true,
  },
  resolve: {
    alias: {
      vue$: 'vue/dist/vue.esm.js',
    },
    extensions: ['*', '.js', '.vue', '.json'],
  }
}
