#!/bin/bash

set -e

while [ ! -f "/usr/local/bin/lifecycle/start_reporter.sh" ]; do
    sleep 1
done

exec /usr/local/bin/farm_entrypoint.sh
