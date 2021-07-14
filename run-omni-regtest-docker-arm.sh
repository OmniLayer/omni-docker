#!/bin/sh
docker run --platform linux/arm64 --rm --name omnicored-regtest -it \
  -p 18443:18443 \
  -p 18444:18444 \
  -p 38443:38443 \
  -p 38444:38444 \
  omnilayer/omnicored:0.11.0 \
  -printtoconsole \
  -debug=1 \
  -regtest=1 \
  -txindex=1 \
  -omnialertallowsender=any \
  -omniactivationallowsender=any \
  -addresstype=legacy \
  -acceptnonstdtxn=1 \
  -limitancestorcount=750 \
  -limitdescendantcount=750 \
  -paytxfee=0.0001 \
  -minrelaytxfee=0.00001 \
  -listenonion=false \
  -zmqpubrawblock=tcp://0.0.0.0:38443 \
  -zmqpubhashblock=tcp://0.0.0.0:38443 \
  -zmqpubrawtx=tcp://0.0.0.0:38444 \
  -zmqpubhashtx=tcp://0.0.0.0:38444 \
  -rpcallowip=172.17.0.0/16 \
  -rpcbind=0.0.0.0 \
  -rpcuser=bitcoinrpc \
  -rpcpassword=pass
