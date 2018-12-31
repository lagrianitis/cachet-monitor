FROM alpine:edge

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.0/s6-overlay-amd64.tar.gz /tmp/

ADD bin/cachet-monitor-linux-amd64 /usr/bin/cachet-monitor
ADD bin/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ADD etc /etc

RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C / \
    && apk add --update --no-cache ca-certificates \
    && chown -R 1000:1000 /etc/cachet-monitor.yaml \
    && chmod -R 755 /usr/bin/ \
    && rm /tmp/* && rm -rf /var/cache/apk/*

USER 1000
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
