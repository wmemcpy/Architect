#!/usr/bin/env bash

if sudo -v; then
    echo "${GREEN}Sudo is already authenticated${RESET}"
else
    echo "${YELLOW}Sudo requires authentication${RESET}"
    sudo -v
fi

if ! curl -s --connect-timeout 8 https://www.google.com > /dev/null 2>&1; then
    echo "${RED}You don't have an Internet connection!${RESET}"
    exit 1
fi

export RESET=$(tput sgr0)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)

# Import functions
#  System
source src/system/archconfig.sh
source src/system/btrfs.sh
source src/system/firewall.sh
source src/system/kernel.sh
source src/system/shell.sh
source src/system/sound.sh
source src/system/sysloaders.sh
#  GPU
source src/gpu/amd.sh
source src/gpu/intel.sh
source src/gpu/nvidia.sh
source src/gpu/vm.sh
#  DE
source src/de/kde.sh
source src/de/gnome.sh
source src/de/xfce.sh

export ARCHITECT_VERSION="3.0.0"

# export LOG_FILE="$(cd "$(dirname "$0")" && pwd)/logfile_$(date "+%Y%m%d-%H%M%S").log"

export BOOT_LOADER="grub"
if [ -d "/boot/loader/entries" ]; then
    export BOOT_LOADER="systemd-boot"
fi

export BTRFS=false
if [ "$(lsblk -o FSTYPE | grep -c btrfs)" -gt 0 ]; then
    export BTRFS=true
fi

main() {
    aur="yay"
    de="kde"
    shell="fish"
    gpu=""
    nvidial_all="n"
    laptop_nvidia_intel="n"
    cuda="n"

    echo "
 █████╗ ██████╗  ██████╗██╗  ██╗██╗████████╗███████╗ ██████╗████████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██║╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝ ${GREEN}Architect v${ARCHITECT_VERSION}${RESET}
███████║██████╔╝██║     ███████║██║   ██║   █████╗  ██║        ██║            by https://github.com/Cardiacman13
██╔══██║██╔══██╗██║     ██╔══██║██║   ██║   ██╔══╝  ██║        ██║               https://github.com/wmemcpy
██║  ██║██║  ██║╚██████╗██║  ██║██║   ██║   ███████╗╚██████╗   ██║   
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝ ╚═════╝   ╚═╝   
                                                                     
"

    printf "Choose an AUR manager (yay/paru) [yay]: "
    read input
    case "$input" in
    paru) aur=$input ;;
    esac

    printf "Choose a desktop environment (kde/gnome/xfce4) [kde]: "
    read de
    de=${de:-kde}

    printf "Choose a shell (fish/bash) [fish]: "
    read shell
    shell=${shell:-fish}

    printf "Choose a GPU type (nvidia/amd/intel/vm): "
    read gpu

    if [ "$gpu" = "nvidia" ]; then
        printf "Are all devices Nvidia (y/n) [n]: "
        read nvidial_all
        if [ "$nvidial_all" != "y" ]; then
            printf "Is it a Nvidia-Intel laptop (y/n) [n]: "
            read laptop_nvidia_intel
            printf "Enable CUDA (y/n) [n]: "
            read cuda
        fi
    fi

    export aur de shell gpu nvidial_all laptop_nvidia_intel cuda

    echo "${GREEN}AUR manager:${RESET} ${aur}"
    echo "${GREEN}Desktop environment:${RESET} ${de}"
    echo "${GREEN}Shell:${RESET} ${shell}"
    echo "${GREEN}GPU:${RESET} ${gpu}"
    if [ "$gpu" = "nvidia" ]; then
        echo "${GREEN}Nvidia all:${RESET} ${nvidial_all}"
        if [ "$nvidial_all" != "y" ]; then
            echo "${GREEN}Laptop Nvidia-Intel:${RESET} ${laptop_nvidia_intel}"
            echo "${GREEN}CUDA:${RESET} ${cuda}"
        fi
    fi

    echo "${YELLOW}Press enter to continue or Ctrl+C to cancel${RESET}"
    read

    # archconfig
    pacman
    mirrorlist
    aur
    flatpak
    if [ "$BTRFS" = true ]; then
        btrfs
    fi
    firewall
    kernel_headers
    vm_max_map_count
    shell
    pipewire
    sysloaders

    # gpu
    if [ "$gpu" = "nvidia" ]; then
        nvidia
    elif [ "$gpu" = "amd" ]; then
        amd
    elif [ "$gpu" = "intel" ]; then
        intel
    elif [ "$gpu" = "vm" ]; then
        vm
    fi

    # de
    if [ "$de" = "kde" ]; then
        kde
    elif [ "$de" = "gnome" ]; then
        gnome
    elif [ "$de" = "xfce4" ]; then
        xfce4
    fi
}

main
