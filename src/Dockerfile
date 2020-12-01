ARG BASE 
FROM ${BASE}
MAINTAINER Rui Carmo https://github.com/rcarmo/docker-homebridge

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

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get install \
    nodejs \
    -y --force-yes \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


RUN adduser --disabled-password --gecos "" -u 1001 user
USER user
ADD package.json /home/user/package.json
RUN npm config set prefix=/home/user/.npm-packages \
 && echo -e '\nexport PATH="/home/user/.npm-packages/bin:$PATH"' >> /home/user/.bashrc \
 && cd /home/user \
 && npm install -g

VOLUME /home/user/.homebridge
CMD /home/user/node_modules/homebridge/bin/homebridge -I

ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.build-date=$BUILD_DATE
