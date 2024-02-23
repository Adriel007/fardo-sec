const fs = require('fs');

fs.readFile('./index.html', 'utf8', (err, data) => {
  if (err) {
    console.error('Erro ao ler o arquivo:', err);
    return;
  }
  
  data.split("\n").forEach(line => {
    if (line.includes('"version": ')) {
      console.log(line.split('"')[3])
    }
  });
});

require('./tools/menu')();