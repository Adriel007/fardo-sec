const Readline = require('readline');

module.exports = Readline.createInterface({
  input: process.stdin,
  output: process.stdout
});