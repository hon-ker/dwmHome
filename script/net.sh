#!/bin/sh
case $BUTTON in

  3) notify-send "🌐 网络流量模块" "\- 查看实时网络流量
- 🔼: 下行流量
- 🔽: 上行流量" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

netUpdate() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

RX=$(netUpdate /sys/class/net/[ew]*/statistics/rx_bytes)
TX=$(netUpdate /sys/class/net/[ew]*/statistics/tx_bytes)

# 换算单位
if [[ $RX -lt 1024 ]];then
    # 如果接收速率小于1024,则单位为B/s
    RX=$(printf "%dB/s" $RX)
elif [[ $RX -gt 1048576 ]];then
    # 否则如果接收速率大于 1048576,则改变单位为MB
    RX=$(( $RX / 1048576 ))
    RX=$(printf "%dMb/s" $RX)
else
    # 否则如果接收速率大于1024但小于1048576,则单位为KB/s
    RX=$(( $RX / 1024 ))
    RX=$(printf "%dKb/s" $RX)
fi

# 换算单位
if [[ $TX -lt 1024 ]];then
    TX=$(printf "%dB/s" $TX)
elif [[ $TX -gt 1048576 ]];then
    # 否则如果发送速率大于 1048576,则改变单位为MB/s
    TX=$(( $TX / 1048576 ))
    TX=$(printf "%dMb/s" $TX)
else
    # 否则如果发送速率大于1024但小于1048576,则单位为KB/s
    TX=$(( $TX / 1024 ))
    TX=$(printf "%dKb/s" $TX)
fi

