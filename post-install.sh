#! /bin/bash

echo "vWinter's Arch Configurator"
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.1.1 arch.localdomain  arch" >> /etc/hosts
mkinitcpio -P
passwd
echo "greeter-session=lightdm-deepin-greeter" >> /etc/lightdm/lightdm.conf

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m -G wheel,power,input,storage,uucp,network -s /usr/bin/zsh winter
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
echo "Set password for new user winter"
passwd winter
systemctl start sddm.service
systemctl enable sddm.service
systemctl enable NetworkManager.service
echo "Configuration done. You can now exit chroot."
