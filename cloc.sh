#! /bin/bash
# Compute LOC for sections

if [ $# -ne 1 ]; then
    echo "Usage: $0 <dpdk source>"
    exit 1
fi

DPDK=$1
if [ ! -d $DPDK ]; then
    echo $DPDK is not a directory
    exit 1
fi

if [ ! -d $DPDK/lib/librte_eal ]; then
    echo No EAL
    exit 1
fi

out=$PWD/loc.csv
cd $DPDK/lib

echo > $out
for d in librte_*
do
    lib=$(echo $d | sed -e 's/librte_//')
    echo -n "$lib," >>$out
    cloc $d |  awk '$1 == "C" { print $5}' >>$out
done
