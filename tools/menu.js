const askQuestion = require('./askQuestion');

module.exports = async() => {
    console.clear();
    console.log(`
    ╭─━─━─━─━─━─━─━─━─━─≪✠≫─━─━─━─━─━─━─━─━─━─╮
    | Fardo Sec - Defense and Offense Toolkit |
    ╰─━─━─━─━─━─━─━─━─━─≪✠≫─━─━─━─━─━─━─━─━─━─╯
    `)
    console.log("");
    require(`../sec/${await askQuestion(`
    Menu:
→ help
→ ssh
→ swarm
→ exit
    
    
    Escolha uma opção:
    `)}`)();
};