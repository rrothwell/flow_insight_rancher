#!/bin/bash

# This script, run.sh, is specified to execute by docker-compose.yml 
# as provided by the Rancher template.
# 

set -e

# Wait for the new kibana.yml to appear so kibana will pick the new configuration.
while [ ! -f "/opt/kibana/config/ready" ]; do
    sleep 1
done

# Now delegate to the original entry point to finish the kibana startup process.
exec /docker-entrypoint.sh kibana
