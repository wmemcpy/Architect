firewall() {
    $aur -S --noconfirm --needed firewalld python-pyqt5 python-capng
    sudo systemctl enable --now firewalld.service
}