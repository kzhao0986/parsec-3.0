#!/bin/bash

cd /sys/fs/cgroup/cpuset
mkdir dl-cpuset
echo 4-7 > dl-cpuset/cpuset.cpus
echo 0 > dl-cpuset/cpuset.mems
chmod 666 dl-cpuset/tasks
