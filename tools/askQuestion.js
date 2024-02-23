const rl = require('./rl');
module.exports = (question, isPassword = false) => {
    return new Promise(resolve => {
      rl.question(question, answer => {
        resolve(isPassword ? `echo "${answer}" |` : answer);
      });
    });
  };