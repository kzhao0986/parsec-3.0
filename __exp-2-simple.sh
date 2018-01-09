#!/bin/bash

name=$1
weights=$2
schedtype=$3

sudo exp_nr=2 weights="$weights" $schedtype\
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 4 -i native
