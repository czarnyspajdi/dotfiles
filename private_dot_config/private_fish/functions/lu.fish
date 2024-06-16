function lu --wraps='sudo pacman -Sy && pacman -Qu' --description 'alias lu=sudo pacman -Sy && pacman -Qu'
  sudo pacman -Sy && pacman -Qu $argv
        
end
