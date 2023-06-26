#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

# theme
theme=#9999ff
black=#1a1b26
green=#9ece6a
white=#a9b1d6
grey=#24283b
blue=#7aa2f7
red=#f7768e
darkblue=$blue
orange=#ff9e64
pink=#bb9af7
poppy=#D66C44
syan=#01ffff



cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}


vol() {
  sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
  if [ "$sink" = "" ]; then sink=$(pactl info | grep '默认音频入口' | awk -F'：' '{print $2}');fi
  volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep '静音：否')
  vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($4)}')
  if [ "$LANG" != "zh_CN.UTF-8" ]; then
    volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')
    vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
  fi
  printf "^c$pink^ 󰂚 $vol_text"
}


battery() {
  icon=""
    [ ! "$(command -v acpi)" ] && echo command not found: acpi && return
    [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] &&
    [ -n "$(acpi -a | grep on-line)" ] && icon=" "
  get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  if [ "$icon" = "" ]; then  
    printf "^c$blue^  $get_capacity";
  else
    printf "^c$blue^ $icon$get_capacity";
  fi
}

brightness() {
  printf "^c$red^  "
  backlight=$(cat /sys/class/backlight/*/brightness)
  printf "^c$red^%.0f\n" $(expr $backlight / 1200 )
}

mem() {
  printf "^c$black^ ^b$orange^ RAM"
  memory=$(free --mebi | sed -n '2{p}'|awk '{printf ("%2.2f",($3 / 1024))}')
  printf "^c$white^ ^b$grey^ $memory"
}

wifi() {
  # check
  [ ! "$(command -v nmcli)" ] && echo command not found: nmcli && return

# 中英文适配
  wifi_grep_keyword="已连接 到"
  wifi_disconnected_notify="无网络"
  wifi_disconnected="未连接"
  if [ "$LANG" != "zh_CN.UTF-8" ]; then
    wifi_grep_keyword="connected to"
    wifi_disconnected_notofy="No Internet"
    wifi_disconnected="disconneted"
  fi

  wifi_text=$(nmcli | grep "$wifi_grep_keyword" | sed "s/$wifi_grep_keyword//" | awk '{print $2}' | paste -d " " -s)

  case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
    up) printf "^c$black^ ^b$pink^ WIFI^c$white^ ^b$grey^ $wifi_text" ;;
    down) printf "^c$black^ ^b$pink^ 󰤭 ^d^%s" ;;
  esac
}

clock() {
  printf "^c$black^^b$blue^ $(date '+%m/%d %H:%M') ^d^%s"
}


net(){
  # 上传下载速速,展示的是下载速率
  . ~/.dwm/script/net.sh
  printf "^c$theme^%s" $RX
}

while true; do
  xsetroot -name "$(net) $(battery) $(brightness) $(vol) $(cpu) $(mem) $(wifi) $(clock)"
  sleep 1
done
