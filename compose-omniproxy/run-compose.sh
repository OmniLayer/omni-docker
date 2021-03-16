#!/bin/bash

#
# Startup script to launch OmniProxy and Omni Core via Docker Compose.
#

#
# Parse parameters to figure out which network to run
#

if [[ -z "$1" ]] ; then
    echo "Error: must specify network"
    echo "Usage: run-compose.sh [mainnet|testnet|regtest]"
    exit 1
elif [[ "$1" == "mainnet" ]] ; then
    OVERRIDE=docker-compose.mainnet.yml
elif [[ "$1" == "testnet" ]] ; then
    OVERRIDE=docker-compose.testnet.yml
elif [[ "$1" == "regtest" ]] ; then
    OVERRIDE=docker-compose.override.yml
else
    echo "Error: invalid network parameter"
    echo "Usage: run-compose.sh [mainnet|testnet|regtest]"
    exit 1
fi

#
# Set user to `testuser` and generate a random password
#

gen_password () {
    chars=abcdefghijklmnipqrstuvwxyz01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
    pass=""
    for i in {1..20} ; do
        pass="$pass${chars:RANDOM%${#chars}:1}"
    done
    echo "$pass"
}

export RPCUSER="testuser"
export RPCPASSWORD="$(gen_password)"

#
# Run `docker-compose up` with the correct "override" file for the selected network,
# and using the environment variables in the hidden `.env` file.
#

docker-compose -f docker-compose.yml -f $OVERRIDE up --detach

