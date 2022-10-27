#!/bin/sh
docker run --rm --name omnicored-help -it \
  omnilayer/omnicored:latest \
  -?
