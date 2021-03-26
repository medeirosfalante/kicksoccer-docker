FROM debian:bullseye-slim
ENV KICKSOCCER_DATA=/home/kicksoccer/.kicksoccer

RUN useradd -r kicksoccer \
    && apt-get update -y \
    && apt-get install -y curl gnupg gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /kicksoccer
ADD bin /kicksoccer
COPY bin/kicksoccerd /usr/bin/kicksoccerd

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod 777  entrypoint.sh


VOLUME ["/home/kicksoccer/.kicksoccer"]

EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/entrypoint.sh"]

CMD ["kicksoccerd"]