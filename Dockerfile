FROM alpine:3.11.6

LABEL maintainer="Shihab Hasan <shihabhasan.official@gmail.com>"

RUN apk update && apk add gcc ca-certificates openssl musl-dev git fuse syslog-ng coreutils curl bash

ENV GOOFYS_VERSION 0.24.0
ENV CATFS_VERSION 0.8.0
ENV MNT_PATH /mnt/data
ENV S3_BUCKET ''
ENV S3_ACCESS_KEY ''
ENV S3_SECRET_KEY ''
ENV STAT_CACHE_TTL 1m0s
ENV TYPE_CACHE_TTL 1m0s
ENV DIR_MODE 0777
ENV FILE_MODE 0777

ARG S3_ENDPOINT
ARG S3_REGION

RUN curl --fail -sSL -o /usr/local/bin/goofys https://github.com/kahing/goofys/releases/download/v${GOOFYS_VERSION}/goofys \
    && chmod +x /usr/local/bin/goofys
RUN curl -sSL -o /usr/local/bin/catfs https://github.com/kahing/catfs/releases/download/v${CATFS_VERSION}}/catfs && chmod +x /usr/local/bin/catfs

ADD config/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD run.sh /goofys/run.sh

RUN chmod +x /goofys/run.sh

ENTRYPOINT ["sh"]
CMD ["/goofys/run.sh"]