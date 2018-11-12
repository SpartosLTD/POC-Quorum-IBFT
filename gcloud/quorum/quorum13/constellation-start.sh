#!/bin/bash
i=$1
set -u
set -e

IP=$(dig +short myip.opendns.com @resolver1.opendns.com)


    DDIR="qdata/c$i"
    mkdir -p $DDIR
    mkdir -p qdata/logs
    cp "keys/tm$i.pub" "$DDIR/tm.pub"
    cp "keys/tm$i.key" "$DDIR/tm.key"
    rm -f "$DDIR/tm.ipc"
    CMD="constellation-node --url=https://${IP}:9000/ --port=9000 --workdir=$DDIR --socket=tm.ipc --publickeys=tm.pub --privatekeys=tm.key --othernodes=https://35.242.146.192:9000/"
    echo "$CMD >> qdata/logs/constellation$i.log 2>&1 &"
    $CMD >> "qdata/logs/constellation$i.log" 2>&1 &

DOWN=true
while $DOWN; do
    sleep 0.1
    DOWN=false
	if [ ! -S "qdata/c$i/tm.ipc" ]; then
            DOWN=true
	fi
done
