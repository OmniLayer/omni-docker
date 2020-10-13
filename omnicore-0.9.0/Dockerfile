FROM debian:bullseye-slim

LABEL maintainer.0="M. Sean Gilligan (@msgilligan)"

RUN useradd -r bitcoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV OMNICORE_VERSION=0.9.0
ENV OMNICORE_HASH=70adddaff52e597975fa5ebee1642be95664f21c7e356d5c931dc4ea8a112fb9
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV PATH=/opt/omnicore-${OMNICORE_VERSION}/bin:$PATH
ENV TARGETPLATFORM=linux/amd64

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
  && curl -SLO https://bintray.com/artifact/download/omni/OmniBinaries/omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz \
  && echo "$OMNICORE_HASH  omnicore-${OMNICORE_VERSION}-${TARGETPLATFORM}.tar.gz" | sha256sum -c - \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 28332 28333

ENTRYPOINT ["/entrypoint.sh"]

RUN omnicored -version | grep "Omni Core Daemon version v${OMNICORE_VERSION}"

CMD ["omnicored"]
