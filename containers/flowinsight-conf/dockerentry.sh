#!/bin/sh


echo Copying run.sh

while [ ! -d "/usr/local/bin" ]; do
    echo Waiting for /usr/local/bin
    sleep 1
done

ls /usr/local/bin/
cp /run.sh /usr/local/bin/
echo After copying run.sh
ls /usr/local/bin/

exec /confd $@
