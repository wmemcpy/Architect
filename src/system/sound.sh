source src/uninstall.sh

pipewire() {
    uninstall pulseaudio pulseaudio-bluetooth pulseaudio-alsa pulseaudio-jack jack2 pipewire-media-session
    sudo pacman -S --noconfirm --needed pipewire wireplumber lib32-pipewire pipewire-alsa pipewire-jack pipewire-pulse alsa-utils alsa-plugins alsa-firmware alsa-ucm-conf sof-firmware
}
