#!/bin/bash

echo "" > /var/log/syslog 
sync
sudo $3 LD_LIBRARY_PATH=/usr/local/lib ./bin/parsecmgmt -c gcc-hooks -a run -p $1 -n 2 -i native
cat /var/log/syslog | grep Heartbeat > $2
