#!/bin/sh

npm install -g --build-from-source --unsafe-perm \
      homebridge \
      homebridge-meobox \
      homebridge-broadlink-rm \
      homebridge-server \
 && rm -rf /root/.npm
