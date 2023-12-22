source src/uninstall.sh

nvidia() {
    uninstall nvidia nvidia-lts nvidia-dkms nvidia-settings nvidia-utils opencl-nvidia libvdpau lib32-libvdpau lib32-libvdpau lib32-nvidia-utils egl-wayland dxvk-nvapi-mingw libxnvctrl lib32-libxnvctrl vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-headers lib32-nvidia-dev-utils-tkg lib32-opencl-nvidia-dev-tkg nvidia-dev-dkms-tkg nvidia-dev-egl-wayland-tkg nvidia-dev-settings-tkg nvidia-dev-utils-tkg opencl-nvidia-dev-tkg

    if [[ $nvidia_all == "y" ]]; then
        git clone https://github.com/Frogging-Family/nvidia-all.git
        cd nvidia-all
        makepkg -si --noconfirm
        cd ..
        rm -rf nvidia-all
    else
        sudo pacman -S --noconfirm --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader egl-wayland opencl-nvidia lib32-opencl-nvidia libvdpau-va-gl libvdpau
    fi
    if [[ $laptop_nvidia_intel == "y" ]]; then
        sudo pacman -S --noconfirm --needed intel-media-driver intel-gmmlib onevpl-intel-gpu nvidia-prime
    fi
    if [[ $cuda == "y" ]]; then
        sudo pacman -S --noconfirm --needed cuda
    fi
}
