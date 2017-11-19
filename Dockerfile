ARG BASE
FROM ${BASE}
MAINTAINER Rui Carmo https://github.com/rcarmo

# Update the system and set up the ReadyNAS repository
RUN apt-get update && apt-get dist-upgrade -y && apt-get install \
    curl \
    apt-transport-https \
    libavahi-compat-libdnssd-dev \
    wget \
    -y --force-yes  \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get install \
    git \
    nodejs \
    -y --force-yes \
 && npm install -g --unsafe-perm \
    homebridge \
    homebridge-meobox \
    homebridge-broadlink-rm \
    homebridge-server \
 && rm -rf /root/.npm

RUN adduser --disabled-password --gecos "" -u 1001 user
USER user
VOLUME /home/user/.homebridge

CMD ["homebridge"]

ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.build-date=$BUILD_DATE
