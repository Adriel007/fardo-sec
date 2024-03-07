const askQuestion = require('./askQuestion');
const colors = require('./colors');
module.exports = async() => {
    console.clear();
    console.log(colors.bgBlack, colors.fgWhite);
    console.log(`
    ╭─━─━─━─━─━─━─━─━─━─━─≪ ☭ ≫─━─━─━─━─━─━─━─━─━─━─╮
    │     Fardo Sec - Defense and Offense Toolkit   │
    ╰─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─━─╯
    `.split("\n").map((line, indexLine) => {
        if (indexLine === 2) {
            return line.split("").map((char, indexChar) => {
                return indexChar === 4 || indexChar === line.length - 1 ? colors.fgRed + char : colors.fgWhite + char;
            }).join("");
        }
        return line.split("").map((char, indexChar) => {
            return char === "☭" ? colors.fgYellow + char : colors.fgRed + char;
        }).join("");
    }).join("\n"));
    
    console.log(colors.fgWhite);
    require(`../sec/${(await askQuestion(`
    ┌───────────────────  MENU  ────────────────────┐
    ├↦  SSH                                         │
    ├↦  Swarm                                       │
    ├↦  Broker                                      │
    ├↦  Who                                         │
    │                                               │
    ├↦  ${colors.bgRed}fardo-sec-exit${colors.bgBlack} para sair de um programa     │
    └───────────────────────────────────────────────┘
    Escolha uma opção: `)).toLowerCase()}`)();
};