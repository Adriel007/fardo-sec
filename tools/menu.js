const askQuestion = require('./askQuestion');

module.exports = async() => {
    console.clear();
    console.log("Fardo Sec - Ataque de Segurança");
    require(`../sec/${await askQuestion(`Escolha uma opção:\n- help\n- ssh\n- swarm\n- exit`)}`)();
};