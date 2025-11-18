#!/usr/bin/env bash

# Get WiFi networks
get_networks() {
    # Use -t (terse) and -f SSID to handle SSIDs with spaces
    # tail -n +2 skips the header line
    # awk -F: '{print $1}' uses the colon separator to print the full SSID
    nmcli -t -f SSID device wifi list | tail -n +2 | awk -F: '{print $1}' | sort -u
}

# Build menu (networks only)
menu() {
    get_networks
}

# Launch menu:
# -dmenu: Standard mode.
# -p "Wi-Fi": Prompt.
# -no-fixed-num-lines: Keeps the list size dynamic.
# -no-filter: Explicitly removes the search bar/filter box.
chosen=$(menu | rofi -dmenu -p "Wi-Fi" -no-fixed-num-lines -no-filter)

# Handle selections
case "$chosen" in
    ("")
        # User cancelled the menu (e.g., pressed ESC)
        exit 0
        ;;

    (*)
        # Attempt to connect to the chosen SSID
        nmcli device wifi connect "$chosen"
        ;;
esac