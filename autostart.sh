# Input method

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_CTYPE=en_US.UTF-8

fcitx &

_thisdir=$(cd $(dirname $0);pwd)

$_thisdir/statusbar.sh &   # 开启状态栏定时更新
# wallpaper
feh --bg-fill --randomize  ~/.dwm/bg/outbreak.jpg
# when you typing that stop touchpad device
syndaemon -i 0.5 -t -K -R -d

#picomi
picom -b

# start dwm
exec dwm


