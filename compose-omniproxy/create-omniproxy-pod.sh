#!/bin/sh
set -x
export PODNAME=omniproxy-pod
export CORENAME=omnicored
export PROXYNAME=omniproxyd

export HOST_BITCOIN_DATADIR="./bitcoin-data-dir"
export BITCOIN_IMAGE="omnilayer/omnicored"
export BITCOIN_VERSION="0.12.0.1"
export BITCOIN_CONFIG_DIR=/home/bitcoin/.bitcoin
export BITCOIN_DATA_DIR=/home/bitcoin/bitcoin-data

export BTCPROXY_IMAGE="consensusj/btcproxyd-jit"
export BTCPROXY_VERSION="0.5.1"
export BTCPROXY_CONFIG_FILE=btcproxy.yml
export BTCPROXY_CONFIG_DIR=/etc/btcproxyd
export MICRONAUT_CONFIG_FILES=${BTCPROXY_CONFIG_DIR}/${BTCPROXY_CONFIG_FILE}

export PROXY_PORT=8080
export RPC_PORT=18332
export P2P_PORT=18333
export ZMQ_PORT_BLOCK=38332
export ZMQ_PORT_TX=38333

echo Creating pod $PODNAME

mkdir -p $HOST_BITCOIN_DATADIR

podman pod create --name $PODNAME \
  --volume ./bitcoin-conf:${BITCOIN_CONFIG_DIR} \
  --volume ./btcproxy-conf:${BTCPROXY_CONFIG_DIR} \
  --volume ${HOST_BITCOIN_DATADIR}:${BITCOIN_DATA_DIR} \
  -p $PROXY_PORT:$PROXY_PORT \
  -p $RPC_PORT:$RPC_PORT \
  -p $P2P_PORT:$P2P_PORT \
  -p $ZMQ_PORT_BLOCK:$ZMQ_PORT_BLOCK \
  -p $ZMQ_PORT_TX:$ZMQ_PORT_TX

# Use full path to omnicored to work around rootful operations in entrypoint.sh
# Using full path runs as root withing the rootless container (i.e. userid of host user)
# -datadir is provided to find the mount point

echo Creating ${BITCOIN_IMAGE}:${BITCOIN_VERSION} as $CORENAME in $PODNAME

podman create --pod $PODNAME --name $CORENAME \
    ${BITCOIN_IMAGE}:${BITCOIN_VERSION} \
    /opt/omnicore-${BITCOIN_VERSION}/bin/omnicored \
    -conf=${BITCOIN_CONFIG_DIR}/bitcoin.conf \
    -datadir=${BITCOIN_DATA_DIR} \
    -testnet=1

echo Creating ${BTCPROXY_IMAGE}:${BTCPROXY_VERSION} as omniproxyd in $PODNAME

podman create --pod $PODNAME --name $PROXYNAME -e MICRONAUT_CONFIG_FILES \
    ${BTCPROXY_IMAGE}:${BTCPROXY_VERSION}
