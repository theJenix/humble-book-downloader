#!/usr/bin/env bash
#

if [[ ! -e "done" ]];
then
    mkdir "done"
fi

for f in *.json
do
    ./download.sh $f
    mv $f "done"
done
