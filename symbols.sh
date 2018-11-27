#! /bin/bash
# generate symbol table

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

OUT=$PWD/symbols
if [ ! -d $OUT ]; then
    echo $OUT is not a directory
    exit 1
fi

cd $DPDK/lib

for d in librte_*
do
    lib=$(echo $d | sed -e 's/librte_//')
    map=${d}/rte_${lib}_version.map

    if [ -f $map ]; then
	awk '/rte_*/ { print $1 }' < $map  | sed -e 's/;//' > $OUT/$lib
    fi
done
