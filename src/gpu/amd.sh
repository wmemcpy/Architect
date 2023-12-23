amd() {
    $aur -S --noconfirm --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader vulkan-mesa-layers lib32-vulkan-mesa-layers libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau
}

rocm() {
    $aur -S --noconfirm --needed rocm-opencl-runtime rocm-hip-runtime
}
