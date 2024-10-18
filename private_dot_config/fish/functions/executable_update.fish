function update --description 'alias update=sudo pacman -Syu && flatpak update'
    sudo pacman -Syu && flatpak update && chezmoi update $argv

end
