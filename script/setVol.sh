#! /bin/bash
sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')

if [ "$sink" = "" ]; then sink=$(pactl info | grep '默认音频入口' | awk -F'：' '{print $2}');fi
volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep '静音：否')
vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($4)}')

if [ "$LANG" != "zh_CN.UTF-8" ]; then
  volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')
  vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
fi

# 音量最高为100
MAX="100"
[ "$vol_text" = "$MAX" ] && [ $1 = up ] && return

vol=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
mod=$((vol % 2))
echo $mod
case $1 in
  none) target="-200%" ;;
  up) target="+2%" ;;
  down) [ $mod -eq 0 ] && target="-5%" || target="-$mod%" ;;
esac

echo $target


pactl set-sink-volume @DEFAULT_SINK@ $target
