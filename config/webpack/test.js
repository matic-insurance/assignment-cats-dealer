process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const nodeExternals = require('webpack-node-externals');
const environment = require('./environment')

module.exports = environment.toWebpackConfig()

environment.resolve = {
  alias: {
    "react-dom/server": "preact-render-to-string",
    "react-dom/test-utils": "preact-test-utils",
    "react-dom": "preact-compat-enzyme",
    "react-test-renderer/shallow": "preact-test-utils",
    "react-test-renderer": "preact-test-utils",
    "react-addons-test-utils": "preact-test-utils",
    "react-addons-transition-group": "preact-transition-group",
    "react": "preact-compat-enzyme",
  }
}

const config = {
  ...environment.toWebpackConfig(),
  target: 'node',
  externals: [nodeExternals()],
};
