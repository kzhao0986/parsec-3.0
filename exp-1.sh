#!/bin/bash

benchmark=$1

for i in {1..10}
do
	./run-native.sh $benchmark $i
done
