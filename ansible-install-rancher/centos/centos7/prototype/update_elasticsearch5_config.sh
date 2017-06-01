#!/usr/bin/env bash

# Upgrade form ElasticSearch 4 to ElasticSearch 5

# Usage: ansible elasticsearch  -b -K -m script -a ""/Users/developer/git/flow_insight_rancher/ansible-install-rancher/centos/centos7/prototype/update_elasticsearch5_config.sh"

# ElasticSearch logging configuration
# Mount to docker container using -v "$PWD/config":/usr/share/elasticsearch/config
# ElasticSearch will merge this configuration file with the one provided by the container
# at /usr/share/elasticsearch/config/log4j2.properties


rm -f /elasticsearch/config/logging.flowinsight.yml
rm -f /elasticsearch/config0/logging.flowinsight.yml
rm -f /elasticsearch/config1/logging.flowinsight.yml

rm -f /elasticsearch/config/logging.yml
rm -f /elasticsearch/config0/logging.yml
rm -f /elasticsearch/config1/logging.yml

rm -f /elasticsearch/config_lt/logging.flowinsight.yml
rm -f /elasticsearch/config_lt0/logging.flowinsight.yml
rm -f /elasticsearch/config_lt1/logging.flowinsight.yml

rm -f /elasticsearch/config_lt/logging.yml
rm -f /elasticsearch/config_lt0/logging.yml
rm -f /elasticsearch/config_lt1/logging.yml

new_user="elasticsearch"
new_group="elasticsearch"

old_uid="100"
new_uid="5000"

old_gid="101"
new_gid="5000"

#groupadd -g 5000 elasticsearch
#useradd -g 5000 -u 5000 -M  elasticsearch

# Assumes if the user is present the group can also be modified.
# This might be bad if other users belong to the same group and are expecting the gid to be fixed.
if id "$new_user" >/dev/null 2>&1; then
    /usr/sbin/groupmod -g $new_gid $new_group && /usr/sbin/usermod -u $new_uid $new_user
else
	# -d /elasticsearch if using this as a home directory.
    /usr/sbin/groupadd -g $new_gid $new_user && /usr/sbin/useradd -g $new_gid -u $new_uid -M  $new_user 
fi

chown -R "$new_user:$new_group" /elasticsearch

# https://muffinresearch.co.uk/linux-changing-uids-and-gids-for-user/
find / \( -name proc -o -name dev -o -name sys \) -prune -o \( -user $old_uid -exec chown -hv $new_uid {} + -o -group $old_gid -exec chgrp -hv $new_gid {} + \)