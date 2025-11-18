bt-device -l | while read -r line; do
    mac=$(echo "$line" | grep -oP '\([0-9A-F:]+\)' | tr -d '()')
    name=$(echo "$line" | sed -E 's/ \([0-9A-F:]+\)//')
    [[ -z "$mac" ]] && continue
    status=$(bluetoothctl info "$mac" 2>/dev/null | grep "Connected" | awk '{print $2}')
    [[ -z "$status" ]] && status="no"
    echo "$status|$name"
done | sort -r | awk -F'|' '{printf "%-25s %s\n", $2, $1}' | walker --dmenu