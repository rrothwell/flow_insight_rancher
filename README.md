# FlowInsight Deployment with Rancher

## Synopsis

A collection of resources used to deploy FlowInsight within the Rancher/Docker environment. This includes:
1. Ansible playbooks:
..1. to install the Rancher management web application on a server.
..1. to install the Rancher Agent on a group of servers.
1. Modified Rancher templates to deploy:
..1. An ElasticSearch cluster
1. Modified Dockerfiles to build images for:
..1. ElasticSearch.

## ElasticSearch Rancher Template
The template provided here is based on the official ElasticSearch template found in the community [Rancher Catalog](https://github.com/rancher/community-catalog/tree/master/templates/elasticsearch-2).

Modifications to docker-compose.yml are as follows:
1. the Java JVM memory limits are increased in line with the available RAM on the bare metal and VM servers used in the cluster.
1. host affinity is set so that Rancher deploys each service to the appropriate host to match the service's resource requirements.