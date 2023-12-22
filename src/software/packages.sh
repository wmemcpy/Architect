source utils.sh

declare -A desktop_list
declare -A system_list
declare -A browser_list
declare -A video_list
declare -A picture_list
declare -A gaming_list

packages() {
    desktop_list=(
        ["Discord"]="discord"
        ["Telegram"]="telegram-desktop"
        ["Spotify"]="spotify"
        ["LibreOffice"]="libreoffice-fresh"
        ["OnlyOffice"]="onlyoffice-bin"
        ["Audacity"]="audacity"
        ["Kazam"]="kazam"
        ["Visual Studio Code"]="visual-studio-code-bin"
        ["Virtualbox"]="virtualbox virtualbox-host-dkms virtualbox-guest-iso"
    )

    system_list=(
        ["Open RGB"]="openrgb-bin"
        ["Arch Update"]="arch-update"
        ["PAMAC ALL"]="pamac-all"
        ["PAMAC tray icon for plasma"]="pamac-tray-icon-plasma"
    )

    picture_list=(
        ["Gimp"]="gimp"
        ["Krita"]="krita"
        ["Inkscape"]="inkscape"
        ["Blender"]="blender"
    )

    video_list=(
        ["Kdenlive"]="kdenlive"
        ["Davinci Resolve"]="davinci-resolve"
        ["Davinci Resolve (paid version)"]="davinci-resolve-studio"
        ["OBS Studio"]="obs-studio"
        ["VLC"]="vlc"
        ["MPV"]="mpv"
    )

    browser_list=(
        ["Firefox"]="firefox"
        ["Brave"]="brave-bin"
        ["Chromium"]="chromium"
        ["Vivaldi"]="vivaldi vivaldi-ffmpeg-codecs"
        ["Google Chrome"]="google-chrome"
        ["Microsoft Edge"]="microsoft-edge-stable-bin"
    )

    gaming_list=(
        ["Steam"]="steam"
        ["Lutris (LOL, etc.)"]="lutris wine-staging "
        ["Heroic Games Launcher (Epic Games, GOG, etc.)"]="heroic-games-launcher-bin"
        ["Prism Launcher (Minecraft)"]="prismlauncher-qt5 jdk8-openjdk"
        ["ProtonUp QT"]="protonup-qt-bin"
        ["Goverlay"]="goverlay"
        ["Gamemode"]="gamemode"
    )

    select_and_install browser_list "browsers"
    select_and_install system_list "system"
    select_and_install desktop_list "desktop"
    select_and_install video_list "video"
    select_and_install picture_list "image"
    select_and_install gaming_list "gaming"

    sudo pacman -S --noconfirm --needed $selected_packages

    if pacman -Qi arch-update &>/dev/null; then
        systemctl --user enable --now arch-update.timer
    fi
}
