#!/bin/bash

echo "" > /var/log/syslog 

sync

sudo LD_LIBRARY_PATH=/usr/local/lib ./bin/parsecmgmt -c gcc-hooks -a run -p $1 -n 2 -i native

# Dump log to [test].log
cat /var/log/syslog | grep Heartbeat > $1.log
# Isolate lines containing perf targets and CPU shares
grep -E '(Targets|share)' $1.log > $1.tmp

while read in
do
	res=${in##*Heartbeat: }
	echo $res >> $1.results
done < $1.tmp

rm $1.tmp
