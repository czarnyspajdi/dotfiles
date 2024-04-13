function osync --wraps=echo\ \"gdrive\"\ \&\&\ rclone\ sync\ \~/Obrazy/fajne\\\ obrazki/\ gdrive:obrazy/fajne\\\ obrazki/\ \&\&\ echo\ \"nextcloud\"\ \&\&\ rclone\ sync\ \~/Obrazy/fajne\\\ obrazki/\ /mnt/uwu/nextcloud/pliki/obrazy/najfajniejsze\\\ obrazki/fajne\\\ obrazki/ --description alias\ osync=echo\ \"gdrive\"\ \&\&\ rclone\ sync\ \~/Obrazy/fajne\\\ obrazki/\ gdrive:obrazy/fajne\\\ obrazki/\ \&\&\ echo\ \"nextcloud\"\ \&\&\ rclone\ sync\ \~/Obrazy/fajne\\\ obrazki/\ /mnt/uwu/nextcloud/pliki/obrazy/najfajniejsze\\\ obrazki/fajne\\\ obrazki/
  echo "gdrive" && rclone sync ~/Obrazy/fajne\ obrazki/ gdrive:obrazy/fajne\ obrazki/ && echo "nextcloud" && rclone sync ~/Obrazy/fajne\ obrazki/ /mnt/uwu/nextcloud/pliki/obrazy/najfajniejsze\ obrazki/fajne\ obrazki/ $argv
        
end
