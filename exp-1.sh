#!/bin/bash

benchmark=$1
schedtype=$2

if [ -z $benchmark ] || [ -z $schedtype ]
then
	echo "Error: Must specify benchmark and scheduler"
	exit 1
fi

for i in {1..10}
do
	./__exp-1.sh $benchmark $i $schedtype
done
