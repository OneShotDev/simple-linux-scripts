#!/bin/bash

echo "Enabling IPv6 ..."
LINE1_NR=$(awk '/GRUB_CMDLINE_LINUX_DEFAULT=/{ print NR; exit }' /etc/default/grub)
LINE2_NR=$(awk '/GRUB_CMDLINE_LINUX=/{ print NR; exit }' /etc/default/grub)
sed -i $LINE1_NR's/.*/GRUB_CMDLINE_LINUX_DEFAULT=\"ipv6.disable=1 quiet\"/' /etc/default/grub
sed -i $LINE2_NR's/.*/GRUB_CMDLINE_LINUX=\"ipv6.disable=1 initrd=\/install\/initrd.gz\"/' /etc/default/grub
update-grub 
echo "... Done!"
echo "Rebooting ..."
sleep 3
reboot
