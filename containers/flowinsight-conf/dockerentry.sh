#!/bin/sh

cp /run.sh /usr/local/bin/

exec /confd $@
