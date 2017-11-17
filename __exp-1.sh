#!/bin/bash

echo "" > /var/log/syslog 
sync

name=$1
ratio=$2
schedtype=$3

echo "$name: $ratio to 1..."

sudo EXP_NR=1 RATIO=$ratio $schedtype LD_LIBRARY_PATH=/usr/local/lib \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 1 -i native \
     #> /dev/null

cat /var/log/syslog | grep Heartbeat > $name.log
# Isolate lines containing perf targets and CPU shares
grep -E '(Targets|share)' $name.log > $name.tmp

echo "$ratio to 1" >> $name.results
echo "------------" >> $name.results

# Copy [test].tmp into [test].results, pruning useless information.
while read in
do
	res=${in##*Heartbeat: }

	# If this line contains CPU share information, it'll contain
	# a big ugly fraction like "xxxxxxxxx/yyyyyyyyy". So let's
	# do some extra formatting by piping that into `bc` and
	# appending it to the end.
	is_share=$(echo $res | grep share)
	if [ -n "$is_share" ]
	then
		share_frac=${res##*share: } # x/y
		share=$(echo "scale=3; $share_frac" | bc)
		res="$res ($share)"
	fi

	echo $res >> $name.results
done < $name.tmp

echo "" >> $name.results

rm $name.tmp
