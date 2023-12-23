shell() {
    local config=(
        "${HOME}/.bashrc"
        "${HOME}/.zshrc"
        "${HOME}/.config/fish/config.fish"
    )
    local alias=(
        "alias fix-key='sudo rm /var/lib/pacman/sync/* && sudo rm -rf /etc/pacman.d/gnupg/* && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman -Sy --noconfirm archlinux-keyring && sudo pacman --noconfirm -Su'"
        "alias update-arch='$aur && flatpak update'"
        "alias update-mirrors='sudo reflector --verbose --score 100 --latest 20 --fastest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu'"
    )

    if [[ $aur == yay ]]; then
        alias+=("alias clean-arch='yay -Sc && yay -Yc && flatpak remove --unused'")
    elif [[ $aur == paru ]]; then
        alias+=("alias clean-arch='paru -Sc && paru -c && flatpak remove --unused'")
    fi

    for file in "${config[@]}"; do
        if [[ -f $file ]]; then
            for item in "${alias[@]}"; do
                if ! grep -q "$item" "$file"; then
                    echo "$item" >>"$file"
                fi
            done
        fi
    done

    if [[ $shell == 'fish' ]]; then
        $aur -S --noconfirm --needed fish

        local current_shell=$(getent passwd $USER | cut -d: -f7)

        while [ "$(getent passwd $USER | cut -d: -f7)" != "/usr/bin/fish" ]; do
            chsh -s "/usr/bin/fish"
        done
        
        fish -c 'fish_update_completions'
        fish -c 'set -U fish_greeting'
        mkdir -p "${HOME}/.config/fish"
        touch "${HOME}/.config/fish/config.fish"
    fi
}
