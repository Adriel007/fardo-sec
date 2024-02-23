const fs = require('fs');
const { exec } = require('child_process');

const url = 'http://adriel007.github.io/fardo-sec';
const urlGit = 'https://github.com/Adriel007/fardo-sec';

const compareVersions = (webVersion, localVersion) => {
  if (webVersion > localVersion) {
    console.log(`Fardo Sec - Ataque de Segurança\n\n Nova versão (${webVersion}) disponível. Atualizando...\n\n`);
    exec(`git pull ${urlGit}`, async (error, stdout, stderr) => {
      if (error) {
        console.error(`Erro ao executar git pull: ${error.message}`);
        return;
      }/*
      if (stderr) {
        console.error(`Erro ao executar git pull: ${stderr}`);
        return;
      }*/
      console.log(`Repositório atualizado com sucesso: ${stdout}`);

      exec('npm install', async (error, stdout, stderr) => {
        if (error) {
          console.error(`Erro ao instalar as dependências: ${error.message}`);
          return;
        }
        if (stderr) {
          console.error(`Erro ao instalar as dependências: ${stderr}`);
          return;
        }
        console.log(`Dependências instaladas com sucesso: ${stdout}`);

        exec('ps aux | grep fardo-sec', async (error, stdout, stderr) => {
          if (error) {
            console.error(`Erro ao verificar processos: ${error.message}`);
            return;
          }
          if (stderr) {
            console.error(`Erro ao verificar processos: ${stderr}`);
            return;
          }
          const processes = stdout.split('\n').filter(line => line.includes('node fardo-sec.js'));
          if (processes.length > 0) {
            processes.forEach(process => {
              const pid = process.split(/\s+/)[1];
              exec(`kill ${pid}`, async (error, stdout, stderr) => {
                if (error) {
                  console.error(`Erro ao encerrar processo: ${error.message}`);
                  return;
                }
                console.log(`Processo encerrado: ${stdout}`);
              });
            });
          }

          require('./tools/menu')();
        });
      });
    });
  } else {
    require('./tools/menu')();
  }
};

fetch(url)
  .then(response => response.text())
  .then(dataWeb => {
    const matchWeb = dataWeb.match(/"version": "(\d+(\.\d+)*)"/);
    const webVersion = matchWeb ? matchWeb[1] : null;

    fs.readFile('./index.html', 'utf8', (err, data) => {
      if (err) {
        console.error('Erro ao ler o arquivo:', err);
        return;
      }

      const matchLocal = data.match(/"version": "(\d+(\.\d+)*)"/);
      const localVersion = matchLocal ? matchLocal[1] : null;

      if (webVersion && localVersion) {
        compareVersions(webVersion, localVersion);
      } else {
        console.log('Erro ao encontrar versões no conteúdo da web ou no arquivo local.');
      }
    });
  })
  .catch(error => {
    console.error('Erro ao fazer a solicitação:', error);
  });