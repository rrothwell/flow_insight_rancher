#!/bin/sh

# run.sh is executed by docker-compose.yml in the Rancher template in place of docker-entrypoint.sh.

# Wait for volume sidekick to mount /usr/local/bin.
# A prerequisite assumption is busybox (in Dockerfile) does not provide /usr/local/bin
# and that Dockerfile does not itself define VOLUME /usr/local/bin.

# The volume sidekick needs to share /usr/local/bin as a volume for this to work.
# Then kibana-conf will be able to see the same /usr/local/bin as the main container.

echo Copying run.sh
while [ ! -d "/usr/local/bin" ]; do
    echo Waiting for /usr/local/bin
    sleep 1
done
cp /run.sh /usr/local/bin/
echo After copying run.sh

# The volume sidekick needs to share /etc as a volume for this to work.
# Then nework_registry-conf will be able to see the same /etc
echo Copying confd data
while [ ! -d "/etc" ]; do
    echo Waiting for /etc
    sleep 1
done
mkdir /etc/confd
cp /conf.d /etc/confd
cp /templates /etc/confd
echo After copying confd data

# Build the new config file.
exec /confd $@
