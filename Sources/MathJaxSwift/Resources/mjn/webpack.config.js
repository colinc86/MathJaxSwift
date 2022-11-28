var path = require('path');

module.exports = {
  entry: { mjn: "./index.js" },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: "[name].bundle.js",
    library: "[name]",
    libraryTarget: "var"
  }
};
