#!/bin/bash
NODE_NUMBER=$1

set -u
set -e

echo "[*] Cleaning up temporary data directories"
rm -rf qdata
mkdir -p qdata/logs

echo "[*] Configuring node $NODE_NUMBER"
mkdir -p qdata/dd"${NODE_NUMBER}"/{keystore,geth}
cp permissioned-nodes.json qdata/dd"${NODE_NUMBER}"/static-nodes.json
cp permissioned-nodes.json qdata/dd"${NODE_NUMBER}"/
cp keys/key"${NODE_NUMBER}" qdata/dd"${NODE_NUMBER}"/keystore
cp raft/nodekey"${NODE_NUMBER}" qdata/dd"${NODE_NUMBER}"/geth/nodekey
geth --datadir qdata/dd"${NODE_NUMBER}" init istanbul-genesis.json