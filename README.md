# simple-linux-scripts

`simple-linux-scripts` is a collection of little, helpful bash scripts for (debian based) linux distributions.
You can find them in the [scripts](scripts) sub folder.
The scripts are tested on a Debian 9.4 'stretch' system with a 4.9.0 kernel.

**NOTE:** You can determine your kernel version with the console command `uname -r` and your system version with `lsb_release -a`!

**_IMPORTANT:_ Use the collection at your own risk! The scripts have been tested carefully on the system mentioned above but your system might be different to a certain degree. AS ALWAYS: Don't do it, if you don't know what you're doing!**


##Content:
* `ipv6-disable.sh`: Disable your IPv6 connectivity directly in your grub boot loader. (e.g. to prevent IPv6 leaks while using a VPN service)
* `ipv6-enable.sh`: Enable your IPv6 connectivity directly in your grub boot loader.

_more to come in the future_


##Description

###`ipv6-disable.sh`
_Disable your IPv6 connectivity directly in your grub boot loader. (e.g. to prevent IPv6 leaks while using a VPN service)_

**Prerequisites:**
* Your system needs to use [grub](https://wiki.debian.org/Grub) as its boot loader

**Run it as:**
* ROOT user

**How does it work:**
It changes some lines in the configuration file `/etc/default/grub`, updates the boot loader and **REBOOTS YOUR SYSTEM** for the changes to take effect.

**Additional comments:**
Check if the deactivation worked by running `ifconfig | grep inet6` as ROOT. If there is no output, you successfully deactivated cour IPv6 connectivity.


###`ipv6-enable.sh`
_Enable your IPv6 connectivity directly in your grub boot loader._

**Prerequisites:**
* Your system needs to use [grub](https://wiki.debian.org/Grub) as its boot loader

**Run it as:**
* ROOT user

**How does it work:**
It changes some lines in the configuration file `/etc/default/grub`, updates the boot loader and **REBOOTS YOUR SYSTEM** for the changes to take effect.

**Additional comments:**
Check if the activation worked by running `ifconfig | grep inet6` as ROOT. If there is output, you successfully activated cour IPv6 connectivity.
