#!/bin/bash

set -e

while [ ! -f "/usr/local/bin/lifecycle/start_reporter.sh" ]; do
    sleep 1
done

# Backup the original config file so confd can generate the replacement.
mv /srv/insight/farm/rooster/live.config /srv/insight/farm/rooster/live.config.original

exec /usr/local/bin/farm_entrypoint.sh
