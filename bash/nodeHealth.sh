#!/bin/bash

#######################
#Author: malempati	
#Date: 1/24/25
#
#This script putputs the node Helth
#
#Version: v1
########################

set -x #debug mode
set -e #exists the script when there is an error
set -o pipefail  


df -h

free -g

nproc

ps -ef | grep amazon

ps -ef | grep amazon | awk -F" " '{print $2}'
