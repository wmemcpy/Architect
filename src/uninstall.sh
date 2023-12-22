uninstall() {
    for package in "$@"; do
        if pacman -Qi "$package" &>/dev/null; then
            sudo pacman -Rdd --noconfirm "$package"
        fi
    done
}
