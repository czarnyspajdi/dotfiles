function update --description 'alias update=sudo pacman -Syu && flatpak update'
    yay || sudo pacman -Syu && flatpak update --noninteractive $argv

end
