# FlowInsight Deployment with Rancher

## Synopsis

A collection of resources used to deploy FlowInsight within the Rancher/Docker environment. This includes:

1. Ansible playbooks:
  1. to install the Rancher management web application on a server.
  1. to install the Rancher Agent on a group of servers.
1. Installation scripts.
  1. Bash scripts that can be run across the cluster using Ansible.
1. Modified Rancher templates to deploy:
  1. An ElasticSearch cluster
1. Modified Dockerfiles to build images that Rancher uses to deploy:
  1. ElasticSearch.

## ElasticSearch Rancher Template

The template provided here is based on the official ElasticSearch template found in the community [Rancher Catalog](https://github.com/rancher/community-catalog/tree/master/templates/elasticsearch-2).

There are 2 files provided in the template: rancher-compose.yml and docker-compose.yml.
docker-compose.yml is used to define/modify the behavior of the Docker images.
rancher-compose.yml is used to provide configuration that is inserted into elasticsearch.yml.

### Memory Configuration

The default Java JVM settings are not sufficient. 
The allocation needs to be set to half the available RAM up to a maximum of 32 Gig.
As the bare metal servers assigned the role of datanodes have 128Gig, the JVM is set to use 31Gig.

### Data Node Storage Configuration

Additional configuration is used to tell an ElasticSearch data node which actual volumes to used for data storage. 
There are 2 kinds of storage provide on the bare metal servers, SSD and HD, with SSDs being assigned for use by short term indexes and HDs being assigned for use by long term indexes. 

For some datanodes SSDs are to be used and the volume names are as follows:
* /dev/sdf1       447G   33M  447G   1% /disks/ssdf
* /dev/sde1       447G   33M  447G   1% /disks/ssde

These values need to be set in the file elasticsearch.yml where they can be used by ElasticSearch. 

### Configuration File Modifications

Modifications to docker-compose.yml are as follows:

1. the Java JVM memory limits are increased in line with the available RAM on the bare metal and VM servers used in the cluster.
1. host affinity is set so that Rancher deploys each service to the appropriate host to match the service's resource requirements.
1. Data volumes are mapped from the host to the datanode container.

Modifications to rancher-compose.yml are as follows:

1. Data volumes are defined so that the default path is over-ridden by 2 data volume paths.

## ElasticSearch Rancher Docker Images

The Rancher template currently (Feb2017) supports configuration via the rancher/elasticsearch-conf:v0.5.0 Docker image. 
A modified Dockerfile to rebuild this image can be based on the official community ElasticSearch Docker file. 
This base is found in the Rancher GitHub repository [catalog-dockerfiles/elasticsearch](https://github.com/rancher/catalog-dockerfiles/tree/master/elasticsearch/containers/0.5.0/elasticsearch-conf).

Currently there does not seem to be a need to modify the Docker images, 
as the configuration provided via the template's docker-compose.yml and rancher-compose.yml files seems to be sufficient.

Configuration in the file elasticsearch.yml is populated during Docker image startup from metadata stored in the rancher-compose.yml file under the yml block.
The properties defined there are inserted directly into the elasticsearch.yml file.

## Installation Scripts

### Volume Mappings

The short term data nodes use container data directories that are mapped to host directories on SSD volumes. 
The data directories as seen from the host need to have a uid/guid that looks like the elasticsearch user as seen from the container,
otherwise ElasticSearch will thrown AccessDenied exceptions during startup and the data node container will file to start.

The elasticsearch uid/gui was found by starting up the base container via:
``` bash
docker run -it -v /disks/ssde/elasticsearch_data:/data0  elasticsearch:2.4.3-alpine /bin/bash
````
And the running the id command
``` bash
id elasticsearch
```

The script prepare_elasticsearch_storage.sh can then be run across the cluster like this:
``` bash
ansible baremetal -b -K -m script -a "/Users/developer/git/flow_insight_docker/centos/centos7/prototype/elasticsearch/prepare_elasticsearch_storage.sh "
```
