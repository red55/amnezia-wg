#!/bin/sh

test -z "$1" && WG_STARTUP_SCRIPT=/opt/amnezia/start-wg.sh || WG_STARTUP_SCRIPT="$1"

if [ -f  "$WG_STARTUP_SCRIPT" ]; then
    # shellcheck disable=SC1090
    . "$WG_STARTUP_SCRIPT";
else
    echo "WG startup script not found $WG_STARTUP_SCRIPT" | tee 1>&2
    exit 1
fi

echo "Entering infinite loop..."
tail -f /dev/null
echo "Container exit."
