#!/bin/sh
docker run --rm --name omnicored-help -it \
  omnilayer/omnicored:0.9.0 \
  -?
