#!/bin/bash

benchmark=$1

if [ -z $benchmark ]
then
	echo "Error: Must specify benchmark"
	exit 1
fi

for i in {1..10}
do
	# ./__exp-1.sh $benchmark $i SCHED_DEADLINE=1 "dl-exp1"
	./__exp-1.sh $benchmark $i SCHED_HEARTBEAT=1 "hb-exp1"
done
