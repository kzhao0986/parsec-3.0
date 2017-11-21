#!/bin/bash

benchmark=$1

if [ -z $benchmark ]
then
	echo "Error: No benchmark specified"
	exit 1
fi

# declare -a weights=("0.5 0.5 0.5 0.5" \
#                     "0.5 0.5 0.5 1" \
#                     "0.5 0.5 1 1" \
#                     "0.5 1 1 1" \
#                     "1 1 1 1")

declare -a weights=("1 1 1 1")

# get length of an array
arraylength=${#weights[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ))
do
	weight="${weights[$i]}"

	echo "SCHED_HEARTBEAT"
	./__exp-2.sh blackscholes "$weight" SCHED_HEARTBEAT=1 "hb-exp2"

	echo "SCHED_DEADLINE"
	./__exp-2.sh blackscholes "$weight" SCHED_DEADLINE=1 "dl-exp2"
done
