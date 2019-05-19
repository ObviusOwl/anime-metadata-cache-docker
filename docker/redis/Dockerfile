FROM ubuntu:18.04

VOLUME /data
WORKDIR /data
EXPOSE 6379

RUN groupadd -g 101 -r redis && useradd -d /var/lib/redis -u 101 -r -g redis redis

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        redis-server \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./rootfs/redis.conf /etc/redis/redis.conf
COPY ./rootfs/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER 101
CMD /entrypoint.sh