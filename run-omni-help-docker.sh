#!/bin/sh
docker run --rm --name omnicored-help -it \
  omnilayer/omnicored:0.11.0 \
  -?
