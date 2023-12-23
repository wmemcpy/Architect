vm() {
    $aur -S --noconfirm --needed virt-what vulkan-swrast lib32-vulkan-swrast

    local -r vm="$(sudo virt-what)"

    if [[ $vm == "qemu" ]]; then
        $aur -S --noconfirm --needed virtualbox-guest-utils
        sudo systemctl enable --now vboxservice
        sudo VBoxClient-all
    else
        $aur -S --noconfirm --needed spice-vdagent qemu-guest-agent
    fi

    sudo pacman -Rdd --noconfirm virt-what
}
