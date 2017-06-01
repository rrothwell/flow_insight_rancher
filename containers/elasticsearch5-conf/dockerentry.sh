#!/bin/sh

set -e

# We do some waiting here as the volume container can take a while before its visible.

# Wait for /opt/rancher/bin/ to appear so we have a destination for the run.sh file copy.
while [ ! -d "/opt/rancher/bin/" ]; do
    echo "Waiting for /opt/rancher/bin/"
    sleep 1
done
echo "Found /opt/rancher/bin/ so copying run.sh"
cp /run.sh /opt/rancher/bin/

# Wait for /usr/share/elasticsearch/config to appear so we can verify its access privileges.
while [ ! -d "/usr/share/elasticsearch/config" ]; do
    echo "Waiting for /usr/share/elasticsearch/config"
    sleep 1
done
echo "Listing of /usr/share/elasticsearch/config:"
ls -al /usr/share/elasticsearch/config

# Wait for /usr/share/elasticsearch/config/scripts to appear so we can verify its access privileges.
# ElasticSearch can fail to start due to bad permissions on this directory.
while [ ! -d "/usr/share/elasticsearch/config/scripts" ]; do
    echo "Waiting for /usr/share/elasticsearch/config/scripts"
    sleep 1
done
echo "Listing of /usr/share/elasticsearch/config/scripts:"
ls -al /usr/share/elasticsearch/config/scripts


# Wait for /usr/share/elasticsearch/config/ to appear so we have a destination for the elasticsearch.yml file copy.
while [ ! -d "/usr/share/elasticsearch/config/" ]; do
    echo "Waiting for /usr/share/elasticsearch/config/"
    sleep 1
done
echo "Found /usr/share/elasticsearch/config/"

su elasticsearch
exec /confd $@
