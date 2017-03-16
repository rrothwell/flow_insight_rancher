#!/bin/bash

# This script, run.sh, is specified to execute by docker-compose.yml 
# as provided by the Rancher template.
# 

set -e

# Wait for the new kibana.yml to appear so kibana will pick the new configuration.
while [ ! -f "/opt/kibana/config/kibana.yml.new" ]; do
    echo "Waiting for /opt/kibana/config/kibana.yml.new"
    sleep 1
done

# Backup the existing config file and put in its place the new config file.
# We keep a copy of kibana.yml.new as it also acts as a ready flag.
# If its not there a restart enters an infinite loop.
mv /opt/kibana/config/kibana.yml /opt/kibana/config/kibana.yml.bak
cp /opt/kibana/config/kibana.yml.new /opt/kibana/config/kibana.yml

# Now delegate to the original entry point to finish the kibana startup process.
exec /docker-entrypoint.sh kibana
