btrfs() {
    sudo pacman -S --noconfirm --needed timeshift grub-btrfs timeshift-autosnap btrfs-progs btrfs-assistant btrfs-du btrfsmaintenance
    sudo systemctl enable --now cronie.service
    sudo systemctl enable --now grub-btrfsd
    sudo sed -i 's|ExecStart=/usr/bin/grub-btrfsd --syslog /.snapshots|ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto|' /etc/systemd/system/multi-user.target.wants/grub-btrfsd.service
}
