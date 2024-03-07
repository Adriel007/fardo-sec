---

## Fardo-Sec Installation and Usage Documentation

### Installation Steps:

1. This script requires `git` and `python3` to be installed. If they are not already installed, the script will install them automatically.

2. Additionally, the script requires the installation of the `figlet` package. This package is also installed automatically if not already present.

3. The script then clones the Sherlock project repository from GitHub and installs its dependencies by running `python3 -m pip install -r requirements.txt`.

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

---
