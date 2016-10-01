pacman -S mc;
echo 'Seting up root password';
passwd;
groupadd adrian;
useradd -g adrian adrian -s /bin/bash;
echo 'user adrian password';
passwd adrian;
echo 'Now you can reboot the system';
