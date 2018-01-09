#!/bin/bash

name=$1
weights=$2
schedtype=$3

if [ $schedtype == "SCHED_DEADLINE=1" ]
then
	cd $cpuset_dir
	echo 0 > cpuset.sched_load_balance
	echo $$ > dl-cpuset/tasks
	cd - > /dev/null
fi

sudo exp_nr=2 weights="$weights" $schedtype\
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 4 -i native

if [ $schedtype == "SCHED_DEADLINE=1" ]
then
	cd $cpuset_dir
	echo $$ > tasks
	echo 1 > cpuset.sched_load_balance
	cd - > /dev/null
fi
