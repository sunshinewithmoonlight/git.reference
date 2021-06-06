fdisk -l
fdisk -l /dev/sda
fdisk /dev/sda
timedatectl set-ntp true
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

echo "Server = http://mirrors.aliyun.com/ArchLinux/\$repo/os/\$arch">/etc/pacman.d/mirrorlist
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/ArchLinux/\$repo/os/\$arch">>/etc/pacman.d/mirrorlist

pacman -Syy
pacman -S arch-install-scripts
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
pacman -S vim dhcpcd
systemctl enable dhcpcd

echo "127.0.0.1 localhost"> /etc/hosts
echo "::1 localhost">> /etc/hosts

pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S xorg-server xorg-xinit xfce4 fcitx-im network-manager-applet xfce4-notifyd

passwd

exit
reboot
