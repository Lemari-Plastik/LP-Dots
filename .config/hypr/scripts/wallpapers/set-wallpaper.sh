#!/bin/bash
set -eu

WALL_DIR="$HOME/.config/wallpapers"


if [ ! -d "$WALL_DIR" ]; then
    echo "Cannot find directory with wallpapers: $WALL_DIR"
    exit 1
fi

FILE_LIST=$(find "$WALL_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" \) -printf "%f\n")

SELECTED_FILE=$(echo "$FILE_LIST" | wofi --dmenu --prompt "Select wallpaper")

[ -z "$SELECTED_FILE" ] && exit 1

WALL="$WALL_DIR/$SELECTED_FILE"
echo "Setting wallpaper: $SELECTED_FILE"
awww img --transition-type center --transition-step 90 "$WALL"
echo "Wallpaper set successfully"

if command -v wal >/dev/null 2>&1; then
    echo "Applying pywal colors..."
    wal -i "$WALL"
    pkill -USR1 cava || echo "Cava is not running"
    
    echo "Pywal applied successfully"
    
    
    export PATH="$HOME/.local/bin:$PATH:/usr/local/bin"
    
    if command -v pywalfox >/dev/null 2>&1; then
        echo "Updating pywalfox..."
        pywalfox update &
    else
        echo "pywalfox not found in PATH"
    fi
    
    
    wait
    
else
    echo "Pywal not installed, skipping"
fi
echo "All done!"
