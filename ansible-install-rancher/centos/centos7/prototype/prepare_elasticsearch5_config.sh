#!/usr/bin/env bash

# Usage: ansible elasticsearch  -b -K -m script -a "/Users/developer/git/flow_insight_docker/centos/centos7/prototype/elasticsearch/prepare_elasticsearch_logs.sh "

# ElasticSearch logging configuration
# Mount to docker container using -v "$PWD/config":/usr/share/elasticsearch/config
# ElasticSearch will merge this configuration file with the one provided by the container
# at /usr/share/elasticsearch/config/log4j2.properties

sudo mkdir -p /elasticsearch/config
sudo mkdir -p /elasticsearch/config_lt
sudo chown 5000:5000 /elasticsearch/config
sudo chown 5000:5000 /elasticsearch/config_lt

# May need to delete these 2 config files if not up-to-date with rancher-compose.yml
#rm -f /elasticsearch/config/elasticsearch.yml 
#rm -f /elasticsearch/config/logging.yml 

rm /elasticsearch/config/logging.flowinsight.yml
cat << EOF > /elasticsearch/config/logging.flowinsight.properties

# you can override this using by setting a system property, for example -Des.logger.level=DEBUG
es.logger.level = INFO
rootLogger = \${es.logger.level}, file

# log action execution errors for easier debugging
logger.action = DEBUG
  
appender.file.type = org.apache.log4j.rolling.RollingFileAppender
appender.file.file = \${path.logs}/\${cluster.name}.log
appender.file.rollingPolicy = org.apache.log4j.rolling.TimeBasedRollingPolicy
appender.file.rollingPolicy.FileNamePattern = \${path.logs}/\${cluster.name}.log.%d{yyyy-MM-dd}.gz
appender.file.layout.type = pattern
appender.file.layout.conversionPattern = "%d{ISO8601}[%-5p][%-25c] %m%n"

EOF

# TODO RR Move this stuff to a storybook so only datanodes pick up this config.

rm /elasticsearch/config_lt/logging.flowinsight.yml
cat << EOF > /elasticsearch/config_lt/logging.flowinsight.properties

# you can override this using by setting a system property, for example -Des.logger.level=DEBUG
es.logger.level = INFO
rootLogger = \${es.logger.level}, file

# log action execution errors for easier debugging
logger.action = DEBUG
  
appender.file.type = org.apache.log4j.rolling.RollingFileAppender
appender.file.file = \${path.logs}/\${cluster.name}.log
appender.file.rollingPolicy = org.apache.log4j.rolling.TimeBasedRollingPolicy
appender.file.rollingPolicy.FileNamePattern = \${path.logs}/\${cluster.name}.log.%d{yyyy-MM-dd}.gz
appender.file.layout.type = pattern
appender.file.layout.conversionPattern = "%d{ISO8601}[%-5p][%-25c] %m%n"

EOF

# ElasticSearch short term datanode logging

sudo mkdir -p /var/log/elasticsearch
sudo chown 5000:5000 /var/log/elasticsearch

# ElasticSearch long term datanode logging

sudo mkdir -p /var/log/elasticsearch_lt
sudo chown 5000:5000 /var/log/elasticsearch_lt
