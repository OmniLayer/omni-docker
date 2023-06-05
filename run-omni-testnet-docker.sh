#!/bin/sh
docker run --rm --name omnicored-testnet -v ${OMNI_SHARED_DATADIR}:/home/bitcoin/.bitcoin -it \
  -p 18332:18332 \
  -p 18333:18333 \
  -p 38332:38332 \
  -p 38333:38333 \
  omnilayer/omnicored:latest \
  -testnet \
  -rpcbind=0.0.0.0 \
  -rpcallowip=0.0.0.0/0
