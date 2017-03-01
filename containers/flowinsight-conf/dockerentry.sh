#!/bin/sh

echo Copying run.sh
ls /usr/local/bin/
cp /run.sh /usr/local/bin/
echo After copying run.sh
ls /usr/local/bin/

exec /confd $@
