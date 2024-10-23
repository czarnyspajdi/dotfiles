wallpaper_dir="$HOME/Obrazy/tapety/"

conf_dir="$HOME/.config/"
hypr_dir="$conf_dir/hypr"
waybar_dir="$conf_dir/waybar"

choosen_wallpaper=$(find $wallpaper_dir -type f | rofi -dmenu -i -p "Wybierz tapetę")

hyprpaper_content="
preload = $choosen_wallpaper\n
wallpaper = ,$choosen_wallpaper\n
splash = off\n
ipc = off
"

echo -e $hyprpaper_content >$hypr_dir/hyprpaper.conf
$hypr_dir/scripts/restart_hyprpaper.sh
