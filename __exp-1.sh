#!/bin/bash

echo "" > /var/log/syslog 
sync

name=$1
ratio=$2
schedtype=$3
suffix=$4

mkdir -p $name
outfile=$name/$name-$suffix

echo "$name: $ratio to 1..."

sudo exp_nr=1 RATIO=$ratio $schedtype \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 2 -i native \
     > $outfile.log

cat /var/log/syslog | grep Heartbeat >> $outfile.log
# Isolate lines containing perf targets and CPU shares
grep -E '(Targets|share|Iterations)' $outfile.log > $outfile.tmp

echo "$ratio to 1" >> $outfile.results
echo "------------" >> $outfile.results

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

	echo $res >> $outfile.results
done < $outfile.tmp

echo "" >> $outfile.results

rm $outfile.tmp
