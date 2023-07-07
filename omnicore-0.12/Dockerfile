FROM debian:bullseye-slim

LABEL maintainer.0="M. Sean Gilligan (@msgilligan)"

RUN useradd -r bitcoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV OMNICORE_VERSION=0.12.0.1
ENV OMNICORE_HASH_AMD64=d6ac1e9af48f9d77ea88b697f35d3825a9b8c972f8de37f1213b433945a435a5
ENV OMNICORE_HASH_ARM64=a8c85b9133bea311fd90e4bde66273474f667743947b7955fb5edf666d41df2c
ENV URL_BASE=https://github.com/OmniLayer/omnicore/releases/download
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV PATH=/opt/omnicore-${OMNICORE_VERSION}/bin:$PATH

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; export OMNICORE_HASH=$OMNICORE_HASH_AMD64; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; export OMNICORE_HASH=$OMNICORE_HASH_ARM64; fi \
  && curl -SLO ${URL_BASE}/v${OMNICORE_VERSION}/omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz \
  && echo "$OMNICORE_HASH  omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz" | sha256sum -c - \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 28332 28333 38332 38333 38443 38443

ENTRYPOINT ["/entrypoint.sh"]

RUN omnicored -version | grep "Omni Core version ${OMNICORE_VERSION}"

CMD ["omnicored"]
