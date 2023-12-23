kernel_headers() {
    local kernel_headers=()

    for kernel in /boot/vmlinuz-*; do
        [ -e "${kernel}" ] || continue
        $aur -S --noconfirm --needed "$(basename "${kernel}" | sed -e 's/vmlinuz-//')-headers"
    done
}

vm_max_map_count() {
    sudo tee -a /etc/sysctl.d/99-sysctl.conf <<EOF
vm.max_map_count=2147483642
EOF
}
