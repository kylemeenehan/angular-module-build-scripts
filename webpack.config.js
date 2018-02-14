const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: './src/styles.scss',
  output: {
    filename: 'dist/styles.js'
  },
  module: {
    rules: [
      { test: /\.scss$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: 'styles.css',
              outputPath: 'dist/'
            }
          },
          {
            loader: 'extract-loader'
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'postcss-loader'
          },
          {
            loader: 'sass-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new CopyWebpackPlugin([
      { from: './src/app/your-components-module/types.d.ts', to: './dist/types.d.ts' },
      { from: './src/app/your-components-module/types/**/*', to: './dist/types/', flatten: true }
    ])
  ]
}
