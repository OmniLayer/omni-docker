#!/bin/sh
docker run --rm --name omnicored-testnet -v ${OMNI_SHARED_DATADIR}:/home/bitcoin/.bitcoin -it \
  -p 18332:18332 \
  -p 18333:18333 \
  -p 38332:38332 \
  -p 38333:38333 \
  omnilayer/omnicored:0.11.0 \
  -printtoconsole \
  -debug=1 \
  -testnet \
  -txindex=1 \
  -experimental-btc-balances=1 \
  -peerbloomfilters \
  -addresstype=legacy \
  -limitancestorcount=750 \
  -limitdescendantcount=750 \
  -listenonion=false \
  -zmqpubrawblock=tcp://0.0.0.0:38332 \
  -zmqpubhashblock=tcp://0.0.0.0:38332 \
  -zmqpubrawtx=tcp://0.0.0.0:38333 \
  -zmqpubhashtx=tcp://0.0.0.0:38333 \
  -rpcallowip=172.17.0.0/16 \
  -rpcbind=0.0.0.0 \
  -rpcuser=bitcoinrpc \
  -rpcpassword=pass
