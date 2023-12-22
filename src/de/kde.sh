kde() {
    sudo pacman -S --noconfirm --needed plasma-meta konsole kwrite dolphin ark plasma-wayland-session powerdevil xdg-desktop-portal-kde okular print-manager gwenview spectacle partitionmanager ffmpegthumbs qt6-multimedia qt6-multimedia-gstreamer qt6-multimedia-ffmpeg qt6-wayland kdeplasma-addons powerdevil kcalc plasma-systemmonitor kwalletmanager

    if [ ! -f /etc/sddm.conf ]; then
        sudo touch /etc/sddm.conf
    fi

    echo -e '[Theme]\nCurrent=breeze' | sudo tee -a /etc/sddm.conf
    echo -e '[General]\nNumlock=on' | sudo tee -a /etc/sddm.conf
    echo 'GTK_USE_PORTAL=1' | sudo tee -a /etc/environment
}
