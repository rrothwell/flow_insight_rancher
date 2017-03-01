#!/bin/sh


echo Copying run.sh

# Wait for volume sidekick to mount /usr/local/bin.
while [ ! -d "/usr/local/bin" ]; do
    echo Waiting for /usr/local/bin
    sleep 1
done

cp /run.sh /usr/local/bin/

echo After copying run.sh

exec /confd $@
