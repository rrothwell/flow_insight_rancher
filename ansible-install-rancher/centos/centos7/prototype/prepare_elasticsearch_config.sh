#!/usr/bin/env bash

# Usage: ansible elasticsearch  -b -K -m script -a "/Users/developer/git/flow_insight_docker/centos/centos7/prototype/elasticsearch/prepare_elasticsearch_logs.sh "

# ElasticSearch logging configuration
# Mount to docker container using -v "$PWD/config":/usr/share/elasticsearch/config
# ElasticSearch will merge this configuration file with the one provided by the container
# at /usr/share/elasticsearch/config/logging.yml



sudo mkdir -p /elasticsearch/config
sudo mkdir -p /elasticsearch/config_longterm
sudo chown 100:101 /elasticsearch/config
sudo chown 100:101 /elasticsearch/config_longterm

rm -f /elasticsearch/config_longterm/logging.flowinsight_longterm.yml

# May need to delete these 2 config files if not up-to-date with rancher-compose.yml
#rm -f /elasticsearch/config/elasticsearch.yml 
#rm -f /elasticsearch/config/logging.yml 

cat << EOF > /elasticsearch/config/logging.flowinsight.yml

# you can override this using by setting a system property, for example -Des.logger.level=DEBUG
es.logger.level: INFO
rootLogger: \${es.logger.level}, file

logger:
  # log action execution errors for easier debugging
  action: DEBUG

appender:
    file:
        type: org.apache.log4j.rolling.RollingFileAppender
        file: \${path.logs}/\${cluster.name}.log
        rollingPolicy: org.apache.log4j.rolling.TimeBasedRollingPolicy
        rollingPolicy.FileNamePattern: \${path.logs}/\${cluster.name}.log.%d{yyyy-MM-dd}.gz
        layout:
          type: pattern
          conversionPattern: "%d{ISO8601}[%-5p][%-25c] %m%n"
EOF

# TODO RR Move this stuff to a storybook so only datanodes pick up this config.

cat << EOF > /elasticsearch/config_longterm/logging.flowinsight.yml

# you can override this using by setting a system property, for example -Des.logger.level=DEBUG
es.logger.level: INFO
rootLogger: \${es.logger.level}, file

logger:
  # log action execution errors for easier debugging
  action: DEBUG

appender:
    file:
        type: org.apache.log4j.rolling.RollingFileAppender
        file: \${path.logs}/\${cluster.name}.longterm.log
        rollingPolicy: org.apache.log4j.rolling.TimeBasedRollingPolicy
        rollingPolicy.FileNamePattern: \${path.logs}/\${cluster.name}.longterm.log.%d{yyyy-MM-dd}.gz
        layout:
          type: pattern
          conversionPattern: "%d{ISO8601}[%-5p][%-25c] %m%n"
EOF


# ElasticSearch short term datanode logging

sudo mkdir -p /var/log/elasticsearch
sudo chown 100:101 /var/log/elasticsearch

# ElasticSearch long term datanode logging

sudo mkdir -p /var/log/elasticsearch_longterm
sudo chown 100:101 /var/log/elasticsearch_longterm
