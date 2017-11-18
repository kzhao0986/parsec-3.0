#!/bin/bash

name=$1
w1="0.5 0.5 0.5 0.5"
w2="1 1 1 1"

echo "Little Core"
sudo exp_nr=2 weights="$w1" SCHED_HEARTBEAT=1 \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 1 -i native \
     | grep "energy"

echo ""

echo "Big Core"
sudo exp_nr=2 weights="$w2" SCHED_HEARTBEAT=1 \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 1 -i native \
     | grep "energy"
