#!/usr/bin/env bash


# Usage: ansible elasticsearch_baremetal  -b -K -m script -a "/Users/developer/git/flow_insight_docker/centos/centos7/prototype/elasticsearch/prepare_elasticsearch_storage.sh "

# No identifiable swap partition.
# swapoff /dev/hdb2

# ElasticSearch short term datanode

sudo mkdir -p /disks/ssde/elasticsearch_data
sudo mkdir -p /disks/ssdf/elasticsearch_data

sudo chown 5000:5000 /disks/ssde/elasticsearch_data
sudo chown 5000:5000 /disks/ssdf/elasticsearch_data


# ElasticSearch long term datanode

sudo mkdir -p /disks/sdd/elasticsearch_data
sudo mkdir -p /disks/sdc/elasticsearch_data
sudo mkdir -p /disks/sdb10/elasticsearch_data
sudo mkdir -p /disks/sda10/elasticsearch_data

sudo chown 5000:5000 /disks/sdd/elasticsearch_data
sudo chown 5000:5000 /disks/sdc/elasticsearch_data
sudo chown 5000:5000 /disks/sdb10/elasticsearch_data
sudo chown 5000:5000 /disks/sda10/elasticsearch_data

