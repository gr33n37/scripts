#!/bin/bash
#program showing big files in your linux system
echo -e "\n"
sudo du -ah /home | sort -r -h | less

#find /home/greenet/ -type f -size +1G
#find /home/greenet/ -type f -size +500M
#
#
#
#
#
#
