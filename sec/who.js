const { exec } = require('child_process');

function getClassBySubnet(subnet) {
    const firstByte = parseInt(subnet.split('.')[0]);
    if (firstByte >= 1 && firstByte <= 126) {
        return 'A';
    } else if (firstByte >= 128 && firstByte <= 191) {
        return 'B';
    } else if (firstByte >= 192 && firstByte <= 223) {
        return 'C';
    } else {
        return 'Unknown';
    }
}

function generateRandomIP(ipClass) {
    let ip;
    switch (ipClass) {
        case 'A':
            ip = `10.${Math.floor(Math.random() * 256)}.${Math.floor(Math.random() * 256)}.${Math.floor(Math.random() * 256)}`;
            break;
        case 'B':
            ip = `172.${Math.floor(Math.random() * 16) + 16}.${Math.floor(Math.random() * 256)}.${Math.floor(Math.random() * 256)}`;
            break;
        case 'C':
            ip = `192.168.${Math.floor(Math.random() * 256)}.${Math.floor(Math.random() * 256)}`;
            break;
        default:
            ip = '0.0.0.0'; // Caso não seja possível determinar a classe, um IP genérico é gerado
            break;
    }
    return ip;
}

function isIPAvailable(ip, callback) {
    exec(`ping -c 1 ${ip}`, (err, stdout, stderr) => {
        if (err) {
            // Se houve um erro, o IP está disponível
            callback(true);
        } else {
            // Se o ping teve sucesso, o IP está em uso
            callback(false);
        }
    });
}

function changeIPAndMAC() {
    // Descobrir o nome da interface de rede
    exec('ip route | grep default | awk \'{print $5}\'', (err, stdout, stderr) => {
        if (err) {
            console.error(`Error getting network interface name: ${err}`);
            return;
        }
        const interfaceName = stdout.trim();

        // Gerar um IP aleatório
        exec(`ifconfig ${interfaceName} | grep "inet " | awk \'{print $2}\'`, (err, stdout, stderr) => {
            if (err) {
                console.error(`Error getting current IP address: ${err}`);
                return;
            }
            const currentIPAddress = stdout.trim();
            const ipClass = getClassBySubnet(currentIPAddress);

            let newIPAddress;
            let attempts = 0;

            const generateAndCheckIP = () => {
                newIPAddress = generateRandomIP(ipClass);

                isIPAvailable(newIPAddress, (available) => {
                    if (available) {
                        // IP disponível, alterar o IP
                        const changeIPCommand = `sudo ifconfig ${interfaceName} ${newIPAddress} netmask 255.255.255.0 up`;
                        exec(changeIPCommand, (err, stdout, stderr) => {
                            if (err) {
                                console.error(`Error changing IP address: ${err}`);
                                return;
                            }
                            console.log(`Changed IP address to: ${newIPAddress}`);
                        });
                    } else {
                        // IP em uso, tentar novamente
                        attempts++;
                        if (attempts < 10) {
                            generateAndCheckIP();
                        } else {
                            console.error(`Failed to generate an available IP address after ${attempts} attempts.`);
                        }
                    }
                });
            };

            generateAndCheckIP();
        });
    });
}

// Executar a mudança de IP e MAC a cada 2 minutos
setInterval(changeIPAndMAC, 2 * 60 * 1000);
