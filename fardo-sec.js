const fs = require('fs');
const { exec } = require('child_process');

const url = 'http://adriel007.github.io/fardo-sec/';

const compareVersions = (webVersion, localVersion) => {
  if (webVersion > localVersion) {
    console.log(`Fardo Sec - Ataque de Segurança\n\n Nova versão (${webVersion}) disponível. Atualizando...\n\n`);
    exec('git clone https://github.com/adriel007/fardo-sec.git', async (error, stdout, stderr) => {
      if (error) {
        console.error(`Erro ao clonar o repositório: ${error.message}`);
        return;
      }
      if (stderr) {
        console.error(`Erro ao clonar o repositório: ${stderr}`);
        return;
      }
      console.log(`Repositório clonado com sucesso: ${stdout}`);

      // Navegar até o diretório do projeto
      process.chdir('fardo-sec');

      // Instalar dependências
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

        // Verificar se o fardo-sec antigo está sendo executado
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

          // Executar o novo fardo-sec
          exec('node fardo-sec.js', async (error, stdout, stderr) => {
            if (error) {
              console.error(`Erro ao executar fardo-sec: ${error.message}`);
              return;
            }
            if (stderr) {
              console.error(`Erro ao executar fardo-sec: ${stderr}`);
              return;
            }
            console.log(`fardo-sec executado com sucesso: ${stdout}`);
          });
        });
      });
    });
  } else {
    console.log(`Fardo Sec - Ataque de Segurança\n\n Versão local (${localVersion}) é mais recente do que a versão da web (${webVersion}).\n\n`);
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

//require('./tools/menu')();
