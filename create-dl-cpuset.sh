#!/bin/bash

cd /sys/fs/cgroup/cpuset

mkdir dl-cpuset
echo 4-7 > dl-cpuset/cpuset.cpus
echo 0 > dl-cpuset/cpuset.mems
echo 1 > dl-cpuset/cpuset.cpu_exclusive
echo 1 > dl-cpuset/cpuset.mem_exclusive

chmod 666 tasks
chmod 666 cpuset.sched_load_balance
chmod 666 dl-cpuset/tasks

cd -
