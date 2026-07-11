#!/usr/bin/env bash

#CTL Script for Shady-XShell

SERVICE="org.Fabric.fabric.shady-xshell"
OBJECT="/org/Fabric/fabric"
INTERFACE="org.Fabric.fabric"

eval_code() {
    gdbus call \
        --session \
        --dest "$SERVICE" \
        --object-path "$OBJECT" \
        --method "$INTERFACE.Evaluate" \
        "$1" >/dev/null
}

case "$1" in
    launcher)      eval_code 'notch.open_notch("launcher")' ;;
    dashboard)     eval_code 'notch.open_notch("dashboard")' ;;
    overview)      eval_code 'notch.open_notch("overview")' ;;
    tools)         eval_code 'notch.open_notch("tools")' ;;
    tmux)          eval_code 'notch.open_notch("tmux")' ;;
    cliphist)      eval_code 'notch.open_notch("cliphist")' ;;
    emoji)         eval_code 'notch.open_notch("emoji")' ;;
    power)         eval_code 'notch.open_notch("power")' ;;
    mixer)         eval_code 'notch.open_notch("mixer")' ;;
    wallpapers)    eval_code 'notch.open_notch("wallpapers")' ;;
    pins)          eval_code 'notch.open_notch("pins")' ;;
    kanban)        eval_code 'notch.open_notch("kanban")' ;;
    bluetooth)     eval_code 'notch.open_notch("bluetooth")' ;;
    network)       eval_code 'notch.open_notch("network_applet")' ;;

    random-wallpaper)
        eval_code 'notch.dashboard.wallpapers.set_random_wallpaper(None, external=True)'
        ;;

    caffeine)
        eval_code 'notch.dashboard.widgets.buttons.caffeine_button.toggle_inhibit(external=True)'
        ;;

    toggle-bar)
        eval_code 'from utils.global_keybinds import get_global_keybind_handler; get_global_keybind_handler().toggle_bar()'
        ;;

    reload-css)
        eval_code 'app.set_css()'
        ;;

    *)
        cat <<EOF
Usage: $(basename "$0") <command>

Notch modules:
  launcher
  dashboard
  overview
  tools
  tmux
  cliphist
  emoji
  power
  mixer
  wallpapers
  pins
  kanban
  bluetooth
  network

Other actions:
  random-wallpaper
  caffeine
  toggle-bar
  reload-css
EOF
        exit 1
        ;;
esac