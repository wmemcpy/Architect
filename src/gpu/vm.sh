vm() {
    sudo pacman -S --noconfirm --needed virt-what vulkan-swrast lib32-vulkan-swrast

    local -r vm="$(sudo virt-what)"

    if [[ $vm == "qemu" ]]; then
        sudo pacman -S --noconfirm --needed virtualbox-guest-utils
        sudo systemctl enable --now vboxservice
        sudo VBoxClient-all
    else
        sudo pacman -S --noconfirm --needed spice-vdagent qemu-guest-agent
    fi

    sudo pacman -Rdd --noconfirm virt-what
}
