FROM debian:bullseye-slim

LABEL maintainer.0="M. Sean Gilligan (@msgilligan)"

RUN useradd -r bitcoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV OMNICORE_VERSION=0.10.0
ENV PRINTED_VERSION=0.20.1.0-9b4fd9564
ENV OMNICORE_HASH_AMD64=e967aeba3a8a66073617f1d5564a99bf21cdaf1d20bb03330d5f8fa17902ba82
ENV OMNICORE_HASH_ARM7=821a48eeca4aaadbc6e9f6a22ec7bd8ed208f7fdb7174fbfc2f5da83542bd1e2
ENV URL_BASE=https://github.com/OmniLayer/omnicore/releases/download
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV PATH=/opt/omnicore-${OMNICORE_VERSION}/bin:$PATH

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; export OMNICORE_HASH=$OMNICORE_HASH_AMD64; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then export TARGETPLATFORM=arm-linux-gnueabihf; export OMNICORE_HASH=$OMNICORE_HASH_ARM7; fi \
  && curl -SLO ${URL_BASE}/v${OMNICORE_VERSION}/omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz \
  && echo "$OMNICORE_HASH  omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz" | sha256sum -c - \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 28332 28333

ENTRYPOINT ["/entrypoint.sh"]

RUN omnicored -version | grep "Omni Core version v${PRINTED_VERSION}"

CMD ["omnicored"]
