#!/bin/bash

# This script, run.sh, is specified to execute by docker-compose.yml 
# as provided by the Rancher template.
# 

set -e

# Wait for the new kibana.yml to appear so kibana will pick the new configuration.
while [ ! -f "/usr/share/kibana/config/kibana.yml.new" ]; do
    echo "Waiting for /usr/share/kibana/config/kibana.yml.new"
    sleep 1
done

# Backup the existing config file and put in its place the new config file.
# We keep a copy of kibana.yml.new as it also acts as a ready flag.
# If its not there a restart enters an infinite loop.
DATE=`date +%Y-%m-%d:%H:%M:%S`
mv /usr/share/kibana/config/kibana.yml "/usr/share/kibana/config/kibana.yml.$DATE.bak"
cp /usr/share/kibana/config/kibana.yml.new /usr/share/kibana/config/kibana.yml

echo "Config directory:"
ls -al /usr/share/kibana/config/

# Now delegate to the original entry point to finish the kibana startup process.
exec /usr/local/bin/kibana-docker
