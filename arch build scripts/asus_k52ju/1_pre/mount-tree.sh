mount /dev/sda2 /mnt;
cd /mnt;
mkdir boot;
mkdir home;
mount /dev/sda1 /mnt/boot;
mount /dev/sda3 /mnt/home;
