#!/bin/bash

benchmark=$1

if [ -z $benchmark ]
then
	echo "Error: No benchmark specified"
	exit 1
fi

# blackscholes
# declare -a weights=("0.42 0.42 0.42 0.42")
# swaptions
# declare -a weights=("0.37 0.37 0.37 0.37")
# vips
# declare -a weights=("0.405 0.405 0.405 0.405")

# declare -a weights=("0.405 0.405 0.405 0.405" \
#                     "0.405 0.405 0.405 1" \
#                     "0.405 0.405 1 1" \
#                     "0.405 1 1 1" \
#                     "1 1 1 1")

declare -a weights=("0.24 0.24 0.24 0.24")

# get length of an array
arraylength=${#weights[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ))
do
	weight="${weights[$i]}"

	echo "SCHED_DEADLINE"
	./__exp-2.sh $benchmark "$weight" SCHED_DEADLINE=1 "dl-exp2"

	# echo "SCHED_HEARTBEAT"
	# ./__exp-2.sh $benchmark "$weight" SCHED_HEARTBEAT=1 "hb-exp2"
done
