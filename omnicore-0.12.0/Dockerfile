FROM debian:bullseye-slim

LABEL maintainer.0="M. Sean Gilligan (@msgilligan)"

RUN useradd -r bitcoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV OMNICORE_VERSION=0.12.0
ENV OMNICORE_HASH_AMD64=55c8a2062148430522d8b115b9dadfdad535dc3354cb58070cf832f13d72a41e
ENV OMNICORE_HASH_ARM64=331e9659a1427d3541198d4c75e65400242f56de6fb198a055bbbc79ce48aeeb
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
