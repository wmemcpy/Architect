pacman() {
    sudo sed -i 's/^#Color$/Color/' '/etc/pacman.conf'
    sudo sed -i 's/^#VerbosePkgLists$/VerbosePkgLists/' '/etc/pacman.conf'
    sudo sed -i 's/^#\(ParallelDownloads.*\)/\1\nILoveCandy/' '/etc/pacman.conf'
    sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' '/etc/pacman.conf'
    sudo sed -i 's/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' '/etc/makepkg.conf'
    sudo systemctl enable --now paccache.timer
}

mirrorlist() {
    sudo reflector --verbose --score 100 --latest 20 --fastest 5 --sort rate --save '/etc/pacman.d/mirrorlist'
    sudo pacman -Syyu --noconfirm
}

aur() {
    if ! pacman -Qi "${AUR}" &>/dev/null; then
        git clone ${git_url[$id]}
        cd "${aur_name[$id]}"
        makepkg -si --noconfirm
        cd ..
        rm -rf ${aur_name[$id]}
    fi

    if [[ $choice == "yay" ]]; then
        yay -Y --gendb
        yay -Y --devel --save
        sed -i 's/\"sudoloop\": false,/\"sudoloop\": true,/' $HOME/.config/yay/config.json
    elif [[ $choice == "paru" ]]; then
        paru --gendb
        sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf
        sudo sed -i 's/#SudoLoop/SudoLoop/' /etc/paru.conf
        sudo sed -i 's/#CombinedUpgrade/CombinedUpgrade/' /etc/paru.conf
        sudo sed -i 's/#UpgradeMenu/UpgradeMenu/' /etc/paru.conf
        sudo sed -i 's/#NewsOnUpgrade/NewsOnUpgrade/' /etc/paru.conf
        sudo sh -c 'echo "SkipReview" >> /etc/paru.conf'
    fi
}

flatpak() {
    sudo pacman -S --noconfirm --needed flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
