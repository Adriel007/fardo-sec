## Fardo-Sec Installation and Usage Documentation

`Fardo - Sec` is a cybersecurity toolbox that brings together tools created by me and third parties.

Tools:

- `Cameras`: Shortcut to access traffic cameras.
- `Sherlock`: Hunt down social media accounts by username across social networks.
- `Mr.Holmes`: Mr.Holmes is an information gathering tool (OSINT).
- `SSH`: Connect to SSH servers.
- `Swarm`: Multi-threaded DoS attack.
- `Glitch`: Periodic automatic change of IP.
- `Broker`: Router admin bruteforce + dictionary attack.
- `Wlan-F`: Connect to a Wi-Fi network. with bruteforce and dictionary methods.
- `Create Alias (shortcut)`: Create a custom shortcut in home directory.
- `Update Alias (manually)`: Update aliases in home directory, sometimes you need to update to use new Alias.

### Tips for newcomers to Termux

- Install Termux and requested Plugins from [F-Droid](https://f-droid.org/)

- Grant app permission to geolocation, notifications and files

- Update your Termux with these commands:

```bash
apt upgrade -y
apt update -y

pkg update -y
pkg upgrade -y

termux-setup-storage
```

### Requirements:

```bash
pkg install git -y
pkg install termux-api -y
pkg install figlet -y
pkg install wireless-tools -y
pkg install iproute2 -y

apt install -y git python3
```

- `Termux API` Plugin (Install from the same source where you installed termux)
- `Termux Widgets` Plugin (Install from the same source where you installed termux)

- `Git` Package
- `Termux API` Package
- `FIGlet` Package
- `Wireless Tools` Package

- `Python 3` Advanced Package Tool

### Installation Steps:

```bash
git clone https://github.com/adriel007/fardo-sec
cd ./fardo-sec
chmod +x ./fardo-sec.sh
./fardo-sec.sh
```

1. This script requires the pkg `git` to be installed.

2. Additionally, the script requires the installation of the `figlet` package. This package is also installed automatically if not already present.

3. The script then clones projects repositories from GitHub and installs its dependencies.

4. Finally, the script creates an alias named `fardo-sec` in the `bash.bashrc` file of Termux. This alias allows easy access to the Fardo-Sec application from the Termux shell.

### Usage:

To use Fardo-Sec, follow these steps:

1. Open Termux on your Android device.

2. Run the following command to start the Fardo-Sec menu:

   ```bash
   fardo-sec
   ```

3. The menu will display various options, each assigned a number. Type the number corresponding to the option you want to select and press Enter.

4. Depending on the selected option, the script will execute the corresponding command or provide instructions for creating or loading aliases.

5. After completing an action, press Enter to return to the main menu or follow any additional instructions provided.

6. To exit the Fardo-Sec menu, select the "Exit" option.

### Uninstall:

Code to remove directory, alias and shortcuts:

```bash
cd $HOME
lsof +D $HOME/fardo-sec
rm -rf $HOME/fardo-sec
rm $HOME/.shortcuts/glitch.sh
sed -i "/alias fardo-sec='$HOME\/fardo-sec\/fardo-sec.sh'/d" /data/data/com.termux/files/usr/etc/bash.bashrc
source /data/data/com.termux/files/usr/etc/bash.bashrc
```

### Credits:

- [Mr.Holmes](https://github.com/Lucksi/Mr.Holmes)
- [Sherlock](https://github.com/sherlock-project/sherlock)
