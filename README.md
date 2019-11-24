# simple-linux-scripts

`simple-linux-scripts` is a collection of little, helpful bash scripts for (debian based) linux distributions.
You can find them in the [scripts](scripts) sub folder.
The scripts are tested on a Debian 10 'buster' system with a 4.19 kernel.

**NOTE:** You can determine your kernel version with the console command `uname -r` and your system version with `lsb_release -a`!

**_IMPORTANT:_ Use the collection at your own risk! The scripts have been tested carefully on the system mentioned above but your system might be different to a certain degree. AS ALWAYS: Don't do it, if you don't know what you're doing!**


## Content:
* [`ipv6-disable.sh`](https://github.com/OneShotDev/simple-linux-scripts#ipv6-disablesh): Disable your IPv6 connectivity directly in your grub boot loader. (e.g. to prevent IPv6 leaks while using a VPN service)
* [`ipv6-enable.sh`](https://github.com/OneShotDev/simple-linux-scripts#ipv6-enablesh): Enable your IPv6 connectivity directly in your grub boot loader.
* [`data-backup.sh`](https://github.com/OneShotDev/simple-linux-scripts#data-backupsh): Make a reliable backup of a folder/partition of your choice.
* [`safe-shutdown.sh`](https://github.com/OneShotDev/simple-linux-scripts#safe-shutdownsh): Shuts down your machine after entering a special arrow key stroke.

_more to come in the future_


## Description

### [`ipv6-disable.sh`](scripts/ipv6-disable.sh)
_Disable your IPv6 connectivity directly in your grub boot loader. (e.g. to prevent IPv6 leaks while using a VPN service)_

**Prerequisites:**
* Your system needs to use [grub](https://wiki.debian.org/Grub) as its boot loader

**Run it as:** ROOT user

**How does it work:**
It changes some lines in the configuration file `/etc/default/grub`, updates the boot loader and **REBOOTS YOUR SYSTEM** for the changes to take effect.

**Additional comments:**
Check if the deactivation worked by running `ifconfig | grep inet6` as ROOT. If there is no output, you successfully deactivated cour IPv6 connectivity.


### [`ipv6-enable.sh`](scripts/ipv6-enable.sh)
_Enable your IPv6 connectivity directly in your grub boot loader._

**Prerequisites:**
* Your system needs to use [grub](https://wiki.debian.org/Grub) as its boot loader

**Run it as:** ROOT user

**How does it work:**
It changes some lines in the configuration file `/etc/default/grub`, updates the boot loader and **REBOOTS YOUR SYSTEM** for the changes to take effect.

**Additional comments:**
Check if the activation worked by running `ifconfig | grep inet6` as ROOT. If there is output, you successfully activated cour IPv6 connectivity.


### [`data-backup.sh`](scripts/data-backup.sh)
_Make a reliable backup of a folder/partition of your choice._

**Prerequisites:**
* [rsync](https://packages.debian.org/stable/net/rsync) package has to be installed

**Run it as:** ROOT user

**How does it work:**
Specify the directory of your data ([`DATA_DIR`](https://github.com/OneShotDev/simple-linux-scripts/blob/9809109824ac7339b9d83a141bc9fe2aa8863983/scripts/data-backup.sh#L5)), your backup destination ([`BACKUP_DIR`](https://github.com/OneShotDev/simple-linux-scripts/blob/9809109824ac7339b9d83a141bc9fe2aa8863983/scripts/data-backup.sh#L6)), the folder that preserves deleted files ([`DEL_FILES_DIR`](https://github.com/OneShotDev/simple-linux-scripts/blob/9809109824ac7339b9d83a141bc9fe2aa8863983/scripts/data-backup.sh#L7)) and a folder for the generated log files ([`LOG_FILES_DIR`](https://github.com/OneShotDev/simple-linux-scripts/blob/9809109824ac7339b9d83a141bc9fe2aa8863983/scripts/data-backup.sh#L8)) in the _SETTINGS_ part of the script.
Run it and follow the instructions on screen.

**Additional comments:**
If you do the backup for the first time (the directory specified in `BACKUP_DIR` is empty) it is called a _full backup_.
When doing a backup, the script checks if the number of files found in `DATA_DIR` equals the number of created files in the target `BACKUP_DIR`. (Since rsync also counts the `DATA_DIR` folder itself - which isn't copied - we subtract one from the number of origin files.)

If it isn't the first time you run a backup, you almost certainly will get the warning that not all files were copied which is ok, since the script only copies new files and files that have changed since the last backup.

If a file in the `DATA_DIR` was deleted since the last backup, it will be removed from `BACKUP_DIR` to maintain an exact copy. Deleted files however will be stored in the directory specified by `DEL_FILES_DIR`. Make sure to clean up this directory from time to time to save disk space.

### [`safe-shutdown.sh`](scripts/safe-shutdown.sh)
_Shuts down your machine after entering a special arrow key stroke._

**Prerequisites:**
_None_

**Run it as:** ROOT user (or as user in sudoers file)

**How does it work:**
Gives you a few seconds to enter a correct pattern of four arrow keys. If you enter the right combination, your device shuts down after 5 seconds. The correct standard pattern is `UP_ARROW` (↑), `DOWN_ARROW` (↓), `LEFT_ARROW` (←), `DOWN_ARROW` (↓).

You can change the order of arrow keys to press as you wish in the _SETTINGS_ part of the script. 
Simply set the variables `key1`-`key4` to the letters in the order of your choice.

The key codes are:
`UP_ARROW=A`, `DOWN_ARROW=B`, `LEFT_ARROW=C`, `RIGHT_ARROW=D`.

You can cancel the shutdown at any point by canceling the script with the shortcut `Ctrl+C`.

**Additional comments:**
The idea of this script is to bind it to a shortcut on your keyboard. If the script would just shut down your computer upon executing, you may accidentally power off which can be quite frustrating (believe me).
Since you need to enter a special pattern of keys and get an additional delay of 5 seconds, you can always make sure to only shut down your device when you REALLY want to do so. When using it on a regular base, you should be soon familiar with your arrow key pattern and shutting down your computer is safe AND fast.
