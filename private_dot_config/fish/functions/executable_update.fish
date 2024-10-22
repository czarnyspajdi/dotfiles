function update --description 'alias update=sudo pacman -Syu && flatpak update'
    sudo pacman -Syu && flatpak update --noninteractive && chezmoi update $argv

end
