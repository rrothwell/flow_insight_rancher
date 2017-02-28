#!/usr/bin/env bash

# Usage: ansible elasticsearch  -b -K -m script -a "start_rancher_agents.sh

sudo docker run -e CATTLE_HOST_LABELS='es_node=es_data'  -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.0 http://vic-crlt-gloriad4.aarnet.net.au:8080/v1/scripts/FEF02637576FDC362F96:1483142400000:poopbOTan5rlzro6ACiShOlwbU

