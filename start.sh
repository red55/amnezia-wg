#!/bin/sh
set -eou pipefail

test -z "$1" && WG_STARTUP_SCRIPT="/opt/amnezia/start-wg.sh" || WG_STARTUP_SCRIPT="$1"

if [ -f  "$WG_STARTUP_SCRIPT" ]; then
    echo "Executing WG startup script $WG_STARTUP_SCRIPT"
    # shellcheck disable=SC1090
    . "$WG_STARTUP_SCRIPT";
    echo "Done executing WG startup script"
elif [ -f "/etc/amnezia/amneziawg/wg0.conf" ]; then
    echo "WG startup script not found $WG_STARTUP_SCRIPT"
    echo "Continuing without WG startup script"
    wg-quick up wg0
    iptables -A INPUT -i wg0 -j ACCEPT
    iptables -A FORWARD -i wg0 -j ACCEPT
    iptables -A OUTPUT -o wg0 -j ACCEPT
    iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
#    ip r d default || true
#    ip r add default dev wg0
else
    echo "WG startup script and default configuration not found. Exiting."
    exit 1
fi

echo "Entering infinite loop..."
tail -f /dev/null
echo "Container exit."
