#!/bin/sh
docker run --rm --name omnicored-regtest -it \
  -p 18443:18443 \
  -p 18444:18444 \
  omnilayer/omnicored:0.9.0 \
  -printtoconsole \
  -debug=1 \
  -regtest=1 \
  -txindex=1 \
  -rpcport=18443 \
  -omnialertallowsender=any \
  -omniactivationallowsender=any \
  -rpcserialversion=0 \
  -addresstype=legacy \
  -limitancestorcount=750 \
  -limitdescendantcount=750 \
  -deprecatedrpc=generate \
  -paytxfee=0.00001 \
  -minrelaytxfee=0.00001 \
  -listenonion=false \
  -rpcallowip=172.17.0.0/16 \
  -rpcbind=0.0.0.0 \
  -rpcuser=bitcoinrpc \
  -rpcpassword=pass
