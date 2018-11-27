#! /bin/bash
# Take a list of projects and url and compute usage

# Results
OUT=$PWD/ethdev.csv

# List of DPDK etherdev API's
ETHDEV=$PWD/ethdev.list

# List of projects using DPDK
PROJECTS=projects.list

# storage are for all the projects
GIT=$HOME/git/dpdk-projects

# Make title bar
echo -n "Name" > $OUT
while read f
do
    t=$(echo $f | sed -e 's/rte_eth_//')
    echo -n ",$t" >> $OUT
done < $ETHDEV

echo >>$OUT
    
while read NAME URL
do
    echo $(date +"%T") "Measuring" $NAME

    echo -n "$NAME" >> $OUT
    TREE=$GIT/$NAME

    if [ ! -d $TREE/.git ]; then
	2>&1 echo "Missing $TREE"
	exit 1
    fi
    
    while read f
    do
	( cd $TREE;
	  if git grep -q $f $TREE
	  then echo -n ",TRUE" >> $OUT
	  else echo -n ",FALSE" >> $OUT
	  fi )
    done < $ETHDEV
    echo >> $OUT
done < $PROJECTS
