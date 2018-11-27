#! /bin/bash
# Take a list of projects and url and compute usage

OUT=$PWD/dpdk-libs.csv

LIBS=$(eval echo "$PWD/symbols/*")

# List of projects using DPDK
PROJECTS=projects.list

# Repository of all projects
GIT=$HOME/git/dpdk-projects

# Make title bar
echo -n "Name,URL" > $OUT
for f in $LIBS
do
    echo -n ",$(basename $f)" >> $OUT
done
echo >>$OUT
    
while read NAME URL
do
    echo $(date +"%T") "Measuring" $NAME

    CLONE=$GIT/$NAME
    if [ ! -d $CLONE ]; then
	>&2 echo "$CLONE not found"
	exit 1
    fi

    echo -n "$NAME,$URL" >> $OUT

    for file in $LIBS
    do
	(cd $CLONE;
	 if git grep -q -F -f $file
	 then echo -n ",TRUE" >> $OUT
	 else echo -n ",FALSE" >> $OUT
	 fi )
    done
    echo >> $OUT

done < $PROJECTS
