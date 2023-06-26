#! /bin/bash
setBacklight(){
    MIN='10.00'
    MAX='100.00'
    STEP=2
    current=$(light)
    
    # 最大或最小时无法继续执行，防止屏幕亮度负数或过高
    [ "$current" = "$MIN" ] && [ $2 = down ] && return
    [ "$current" = "$MAX" ] && [ $2 = up ] && return
    
    $(light $1 $STEP)
}


case $1 in
    up) setBacklight -A up;;
  down) setBacklight -U down;;
esac
