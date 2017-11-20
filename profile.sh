#!/bin/bash

name=$1
filename=$name.profile
w1="0.4 0.4 0.4 0.4"
w2="1 1 1 1"

echo "Little Core" >> $filename
echo "------------" >> $filename
sudo exp_nr=2 weights="$w1" SCHED_HEARTBEAT=1 \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 4 -i native \
     | grep "energy" >> $filename

echo "" >> $name.profile

echo "Big Core" >> $filename
echo "------------" >> $filename
sudo exp_nr=2 weights="$w2" SCHED_HEARTBEAT=1 \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 4 -i native \
     | grep "energy" >> filename
