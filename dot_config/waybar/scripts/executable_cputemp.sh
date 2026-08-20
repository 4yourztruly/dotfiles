#!/bin/bash
# coretemp's hwmon index shifts across boots depending on module load
# order, so find it by name instead of hardcoding hwmonN.
hwmon_dir=$(grep -l '^coretemp$' /sys/class/hwmon/hwmon*/name 2>/dev/null | head -1 | xargs dirname)

if [ -z "$hwmon_dir" ]; then
    echo '{"text": "N/A", "tooltip": "coretemp sensor not found", "class": "critical"}'
    exit 0
fi

temp=$(( $(cat "$hwmon_dir/temp1_input") / 1000 ))

if [ "$temp" -ge 90 ]; then
    icon='<span font_family=\"Font Awesome 7 Free Solid\"></span>'
    class="critical"
elif [ "$temp" -ge 70 ]; then
    icon='<span font_family=\"Font Awesome 7 Free Solid\"></span>'
    class="warning"
else
    icon='<span font_family=\"Font Awesome 7 Free Solid\"></span>'
    class="normal"
fi

echo "{\"text\": \"${icon} ${temp}°C\", \"tooltip\": \"CPU ${temp}°C\", \"class\": \"${class}\"}"
