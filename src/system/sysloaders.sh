sysloaders() {
    sudo mkdir -p /etc/pacman.d/hooks
    sudo touch /etc/pacman.d/hooks/grub.hook
    echo -e '[Trigger]
Type = File
Operation = Install
Operation = Upgrade
Operation = Remove
Target = usr/lib/modules/*/vmlinuz

[Action]
Description = Updating grub configuration ...
When = PostTransaction
Exec = /usr/bin/grub-mkconfig -o /boot/grub/grub.cfg
' | sudo tee -a /etc/pacman.d/hooks/grub.hook
    sudo pacman -S --noconfirm --needed update-grub
}
