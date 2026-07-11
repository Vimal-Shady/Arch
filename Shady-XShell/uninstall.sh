#!/bin/bash

echo "This will permanently delete Shady-XShell cache, configuration, and remove its entry from hyprland.conf."
read -p "Are you sure you want to continue? [y/N] " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 1
fi

rm -rf ~/.cache/shady-xshell
rm -rf ~/.config/Shady-XShell

conf_file=~/.config/hypr/hyprland.conf
tmp_file=$(mktemp)

awk '
BEGIN { found_comment=0 }
{
    if ($0 ~ /# Shady-XShell/) {
        found_comment=1
        next
    }
    if (found_comment && $0 ~ /source[[:space:]]*=[[:space:]]*~\/\.config\/Shady-XShell\/config\/hypr\/shady-xshell\.conf/) {
        found_comment=0
        next
    }
    print
}' "$conf_file" > "$tmp_file" && mv "$tmp_file" "$conf_file"

echo "Shady-XShell data and config removed successfully."
