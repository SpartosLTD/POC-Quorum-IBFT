#!/bin/bash
NODE_NUMBER=$1

set -u
set -e

privacyImpl=constellation

NETWORK_ID=10 #same as in genesis.json

mkdir -p qdata/logs

echo "[*] Starting Constellation nodes"
./constellation-start.sh $NODE_NUMBER

echo "[*] Starting Ethereum nodes with ChainID and NetworkId of $NETWORK_ID"
set -v
ARGS="--nodiscover --istanbul.blockperiod 1 --networkid $NETWORK_ID --syncmode full --mine --minerthreads 1 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain \"*\" --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul"
PRIVATE_CONFIG=qdata/c${NODE_NUMBER}/tm.ipc nohup geth --datadir qdata/dd${NODE_NUMBER} $ARGS --rpcport 22000 --port 21000 --unlock 0 --password passwords.txt 2>>qdata/logs/$NODE_NUMBER.log
set +v

echo
echo "Node $NODE_NUMBER configured"

exit 0
