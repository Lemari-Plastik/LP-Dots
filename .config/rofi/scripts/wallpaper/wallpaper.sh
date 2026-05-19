#!/bin/bash

wallpapers_dir="$HOME/.config/wallpapers/"

build_theme() {
  rows=$1
  cols=$2
  icon_size=$3
  echo "element{orientation:vertical;}element-text{horizontal-align:0.5;}element-icon{size:$icon_size.0000em;}listview{lines:$rows;columns:$cols;}"
}

theme="$HOME/.config/rofi/scripts/wallpaper/style.rasi"

rofi_cmd="rofi -dmenu -i -show-icons -theme-str $(build_theme 2 3 10) -theme ${theme}"

choice=$(
  ls --escape "$wallpapers_dir" |
    while read A; do echo -en "$A\x00icon\x1f$wallpapers_dir/$A\n"; done |
    $rofi_cmd
)

if [ -z "$choice" ]; then
  exit 1
fi

WALLPAPER="$wallpapers_dir/$choice"

awww img "$WALLPAPER" \
  --transition-type wipe \
  --transition-duration 3 \
  --transition-fps 60

wal -i "$WALLPAPER" -n

pkill -USR2 waybar
pkill -USR1 swaync
pkill -USR1 cava || echo "Cava is not running"

notify-send "Wallpaper & Theme Updated" -i "$WALLPAPER" --app-name=Wallpaper

exit
