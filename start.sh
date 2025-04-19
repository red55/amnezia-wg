#!/bin/sh

if [ -f /opt/amnezia/start-wg.sh ]; then . /opt/amnezia/start-wg.sh; fi

echo "Entering infinite loop"
tail -f /dev/null
echo "Container exit"
