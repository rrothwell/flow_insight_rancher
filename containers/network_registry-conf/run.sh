#!/bin/bash

# This script, run.sh, is specified to execute by docker-compose.yml 
# as provided by the Rancher template.
# 

set -e

# Wait for the new /etc/my.cnf to appear so MariaDB will pick the new configuration.
while [ ! -f "/etc/my.cnf.new" ]; do
    echo "Waiting for /etc/my.cnf.new"
    sleep 1
done

# Backup the existing config file and put in its place the new config file.
# my.cnf.new is doing double duty as a flag so we keep a copy.
# Otherwise a restart enters an infinite loop.
mv /etc/my.cnf /etc/my.cnf.bak
cp /etc/my.cnf.new /etc/my.cnf

# Backup the existing config file and put in its place the new config file.
mv /etc/mysql/conf.d/server.cnf /etc/mysql/conf.d/server.cnf.bak
mv /etc/mysql/conf.d/server.cnf.new /etc/mysql/conf.d/server.cnf

# Now delegate to the original entry point to finish the kibana startup process.
exec /docker-entrypoint.sh
