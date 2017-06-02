#!/bin/bash

set -e

PLUGIN_TXT=${PLUGIN_TXT:-/usr/share/elasticsearch/plugins.txt}

while [ ! -f "/usr/share/elasticsearch/config/elasticsearch.yml" ]; do
    sleep 1
done

if [ -f "$PLUGIN_TXT" ]; then
    for plugin in $(<"${PLUGIN_TXT}"); do
        /usr/share/elasticsearch/bin/plugin --install $plugin
    done
fi

# Report which user we are.
echo -n "User running this script: " ; whoami

echo "Elasticsearch directory:"
ls -al /usr/share/elasticsearch

echo "Config directory:"
ls -al /usr/share/elasticsearch/config

echo "Scripts directory:"
ls -al /usr/share/elasticsearch/config

exec /usr/share/elasticsearch/bin/es-docker
