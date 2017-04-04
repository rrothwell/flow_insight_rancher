#!/bin/sh


echo Copying run.sh

# Wait for volume sidekick to mount /usr/local/bin.
# This assumes busybox (in Dockerfile) does not provide /usr/local/bin
# and that Dockerfile does not itself define VOLUME /usr/local/bin.

# The volume sidekick needs to share /usr/local/bin as a volume for this to work.
# Then farm-conf will be able to see the same /usr/local/bin as the main container.

while [ ! -d "/usr/local/bin" ]; do
    echo Waiting for /usr/local/bin
    sleep 1
done

cp /run.sh /usr/local/bin/

echo After copying run.sh

exec /confd $@
