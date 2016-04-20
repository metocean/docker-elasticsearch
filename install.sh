#!/bin/sh
set -e

apk update
apk upgrade

# Install Java
apk add openjdk8-jre

# Install gosu
wget -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64
chmod +x /usr/bin/gosu

# Install elasticsearch
wget -O- https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz | tar -xz -C /usr/lib
mv /usr/lib/elasticsearch-$ELASTICSEARCH_VERSION /usr/lib/elasticsearch
rm /usr/lib/elasticsearch/config/elasticsearch.yml
cp /install/elasticsearch.yml /usr/lib/elasticsearch/config/
addgroup -S elasticsearch
adduser -S -G elasticsearch elasticsearch
chown -R elasticsearch:elasticsearch /usr/lib/elasticsearch
mkdir -p /etc/service/elasticsearch
cp /install/elasticsearch.sh /etc/service/elasticsearch/run

# Clean up
rm -rf /install
rm -rf /tmp/*
rm -rf /var/cache/apk/*