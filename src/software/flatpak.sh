source utils.sh

flatpak() {
    flatpak_list=(
        ["Firefox"]="org.mozilla.firefox"
        ["Google Chrome"]="com.google.Chrome"
        ["RetroArch"]="org.libretro.RetroArch"
        ["Discord"]="com.discordapp.Discord"
        ["Brave"]="com.brave.Browser"
        ["Spotify"]="com.spotify.Client"
        ["Deezer"]="dev.aunetx.deezer"
        ["Telegram"]="org.telegram.desktop"
        ["ProtonUP"]="net.davidotek.pupgui2"
        ["Lutris"]="net.lutris.Lutris"
        ["Steam"]="com.valvesoftware.Steam"
        ["OBS"]="com.obsproject.Studio"
    )
    select_and_install flatpak_list "flatpak"

    flatpak install -y flathub ${flatpak_list[@]}
}
