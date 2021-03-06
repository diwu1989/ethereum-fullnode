#!/bin/bash
docker stop ethereum-fullnode
docker rm ethereum-fullnode

export IMAGE=diwu1989/ethereum-fullnode:latest
export MAX_PEERS=128
export CACHE=1024
export PORT=30399
mkdir -p data
docker run --name ethereum-fullnode -d \
        --restart unless-stopped \
        --stop-timeout 30 \
        --memory 8G \
        -p 127.0.0.1:8745:8745 -p 8746:8746 -p $PORT:$PORT -p $PORT:$PORT/udp \
        -v $PWD/data:/opt/openethereum/data $IMAGE \
        --chain foundation \
        --base-path '/opt/openethereum/data' \
        --jsonrpc-port 8745 \
        --jsonrpc-cors all \
        --jsonrpc-interface all \
        --jsonrpc-hosts all \
        --jsonrpc-apis web3,eth,net,parity \
        --ws-port 8746 \
        --ws-interface all \
        --ws-apis web3,eth,net,parity,pubsub \
        --ws-origins all \
        --ws-hosts all \
        --max-peers $MAX_PEERS \
        --no-secretstore \
        --no-persistent-txqueue \
        --port $PORT \
        --cache-size $CACHE
