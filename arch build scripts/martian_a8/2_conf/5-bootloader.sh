pacman -S grub os-prober;
grub-install --recheck /dev/sda;
grub-mkconfig -o /boot/grub/grub.cfg;