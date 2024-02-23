const rl = require('./rl');
const menu = require('./menu');

module.exports = callback => {
    rl.on('line', async input => {
        if (input.trim() === "fardo-sec-exit") {
            callback();
            menu();
        }
      });
}