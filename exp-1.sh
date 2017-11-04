#!/bin/bash

benchmark=$1

if [ -z $benchmark ]
then
	echo "Error: Must specify benchmark name"
	exit 1
fi

for i in {1..10}
do
	./run-native.sh $benchmark $i
done
