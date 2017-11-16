#!/bin/bash

benchmark=$1
schedtype=$2

if [ -z $benchmark ] || [ -z $schedtype ]
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
	./__exp-2.sh $benchmark "${weights[$i]}" $schedtype
done
