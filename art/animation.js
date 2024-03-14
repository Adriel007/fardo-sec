const fs = require('fs');
const path = require('path');

const diretorio = "./lock";

function lerArquivo(arquivo) {
  try {
    return fs.readFileSync(arquivo, 'utf8');
  } catch (error) {
    console.error('Erro ao ler arquivo:', error);
    return null;
  }
}

function clearConsole() {
  process.stdout.write('\033c');
}

function main() {
  const arquivos = fs.readdirSync(diretorio).filter(file => file.endsWith('.txt'));
  let i = 0;

  setInterval(() => {
    const arquivo = path.join(diretorio, `${i}.txt`);
    const conteudo = lerArquivo(arquivo);
    if (conteudo !== null) {
      console.log(conteudo);
      i = (i + 1) % arquivos.length;
      clearConsole();
    }
  }, 200);
}

if (!diretorio) {
  console.error('Uso: node script.js <diretório>');
} else {
  main();
}
