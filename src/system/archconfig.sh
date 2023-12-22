pacman() {
    sudo sed -i 's/^#Color$/Color/' '/etc/pacman.conf'
    sudo sed -i 's/^#VerbosePkgLists$/VerbosePkgLists/' '/etc/pacman.conf'
    sudo sed -i 's/^#\(ParallelDownloads.*\)/\1\nILoveCandy/' '/etc/pacman.conf'
    sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' '/etc/pacman.conf'
    sudo sed -i 's/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' '/etc/makepkg.conf'
    # sudo systemctl enable --now paccache.timer
}

mirrorlist() {
    sudo pacman -S --noconfirm --needed reflector
    sudo reflector --verbose --score 100 --latest 20 --fastest 5 --sort rate --save '/etc/pacman.d/mirrorlist'
    sudo pacman -Syyu --noconfirm
}

aur() {
    if [[ $aur == "yay" ]]; then
        aur_folder="yay-bin"
        git_aur="https://aur.archlinux.org/yay-bin.git"
    elif [[ $aur == "paru" ]]; then
        aur_folder="paru-bin"
        git_aur="https://aur.archlinux.org/paru-bin.git"
    fi

    if ! pacman -Qi "$aur" &>/dev/null; then
        git clone "$git_aur"
        cd $aur_folder || exit
        makepkg -si --noconfirm
        cd .. && rm -rf $aur_folder
    fi

    if [[ $aur == "yay" ]]; then
        sed -i 's/\"sudoloop\": false,/\"sudoloop\": true,/' $HOME/.config/yay/config.json
        yay -Y --gendb
        yay -Y --devel --save
    elif [[ $aur == "paru" ]]; then
        sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf
        sudo sed -i 's/#SudoLoop/SudoLoop/' /etc/paru.conf
        sudo sed -i 's/#CombinedUpgrade/CombinedUpgrade/' /etc/paru.conf
        sudo sed -i 's/#UpgradeMenu/UpgradeMenu/' /etc/paru.conf
        sudo sed -i 's/#NewsOnUpgrade/NewsOnUpgrade/' /etc/paru.conf
        sudo sh -c 'echo "SkipReview" >> /etc/paru.conf'
        paru --gendb
    fi
}

flatpak() {
    sudo pacman -S --noconfirm --needed flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
