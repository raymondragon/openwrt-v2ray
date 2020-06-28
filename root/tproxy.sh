#!/bin/bash

start() {
    iptables -t nat -N V2RAY
    iptables -t nat -A V2RAY -p tcp -j RETURN -m mark --mark 0xff
    iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345
    iptables -t nat -A PREROUTING -p tcp -j V2RAY
    iptables -t nat -A OUTPUT -p tcp -j V2RAY
}

stop() {
    iptables -t nat -D OUTPUT -p tcp -j V2RAY
    iptables -t nat -D PREROUTING -p tcp -j V2RAY
    iptables -t nat -F V2RAY
    iptables -t nat -X V2RAY
}

case $1 in
start)
    start
    ;;
stop)
    stop
    ;;
*)
    echo "$0 start|stop"
    ;;
esac