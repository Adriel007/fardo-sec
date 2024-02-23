const askQuestion = require("../tools/askQuestion");
const callbackExit = require("../tools/exitListener");
const { exec } = require('child_process');
const rl = require('../tools/rl');

module.exports = async () => {
    const sshCommand = "ssh <user>@<ip> -p <port>";
  
    const auto = await askQuestion("Auto conectar?[y/n]: ");
    const user = auto === "y" ? "user" : await askQuestion("Digite o nome de usuário: ");
    const ip = auto === "y" ? "192.168.0.49" :await askQuestion("Digite o IP: ");
    const port = auto === "y" ? "8022" :await askQuestion("Digite a porta: ");
  
    console.log(`Conectando via SSH em ${user}@${ip}:${port}...\n\n`);
  
    const sshProcess = exec(
      sshCommand
      .replace("<user>", user)
      .replace("<ip>", ip)
      .replace("<port>", port)
    );
  
    sshProcess.stdout.pipe(process.stdout);
    sshProcess.stderr.pipe(process.stderr);
  
  
    callbackExit(function () {
        console.log("Saindo do SSH...\n");
    });

    rl.on('line', async input => {
        if (input.trim() !== "fardo-sec-exit")
            sshProcess.stdin.write(input + "\n\n");
    });
};