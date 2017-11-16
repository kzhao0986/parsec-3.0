#!/bin/bash

benchmark=$1

if [ -z $benchmark ]
then
	echo "Error: Must specify benchmark and scheduler"
	exit 1
fi

declare -a weights=("0.5 0.5 0.5 0.5" \
                    "0.5 0.5 0.5 1" \
                    "0.5 0.5 1 1" \
                    "0.5 1 1 1" \
                    "1 1 1 1")

# get length of an array
arraylength=${#weights[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ))
do
	echo "SCHED_DEADLINE"
	./__exp-2.sh blackscholes "${weights[$i]}" SCHED_DEADLINE=1 "dl-exp2"

	echo "SCHED_HEARTBEAT"
	./__exp-2.sh blackscholes "${weights[$i]}" SCHED_HEARTBEAT=1 "hb-exp2"
done
