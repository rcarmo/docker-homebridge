ARG BASE 
FROM ${BASE}
MAINTAINER Rui Carmo https://github.com/rcarmo

#RUN apt-get update \
# && apt-get dist-upgrade -y \
# && i
RUN apt-get update \
 && apt-get install \
    apt-transport-https \
    build-essential \
    curl \
    git \
    libavahi-compat-libdnssd-dev \
    wget \
    -y --force-yes  \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get install \
    nodejs \
    -y --force-yes \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD rootfs /
VOLUME /home/user/.homebridge

RUN adduser --disabled-password --gecos "" -u 1001 user \
 && chown -R user:user /home/user

USER user
RUN npm install -g \
    bignum \
    homebridge \
    homebridge-meobox \
    homebridge-broadlink-rm \
    homebridge-server

CMD ["homebridge"]

ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.build-date=$BUILD_DATE
