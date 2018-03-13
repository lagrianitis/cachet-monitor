FROM alpine:edge

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

ADD bin/cachet-monitor-linux-amd64 /usr/bin/cachet-monitor && chmod +x /usr/bin/cachet-monitor

RUN apk add --update --no-cache ca-certificates

RUN rm /tmp/* && rm -rf /var/cache/apk/*
ADD etc /etc


ENTRYPOINT ["/init"]