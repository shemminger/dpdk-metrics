#! /bin/bash
# Take a list of projects and create repo

# List of projects using DPDK
PROJECTS=projects.list

# Repository of all projects
GIT=$HOME/git/dpdk-projects

while read NAME URL
do
    echo $(date +"%T") "Fetching" $NAME $URL

    if [ -z "$URL" ];
    then >&2 echo missing url for $NAME
	 exit 1
    fi

    CLONE=$GIT/$NAME
    if [ -d $CLONE ]
    then
	    (cd $CLONE; git pull -q )
    elif ! git clone -q $URL $CLONE
    then
	>&2 echo "$URL not found"
	exit 1
    fi

done < $PROJECTS
