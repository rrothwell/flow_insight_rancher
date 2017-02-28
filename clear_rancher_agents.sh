#!/usr/bin/env bash

# Usage:  ansible elasticsearch  -b -K -m script -a "clear_rancher_agents.sh  "

docker rm -f $(docker ps -q)
