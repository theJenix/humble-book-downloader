#!/usr/bin/env bash
#

set -e
#set -x

# Eval for tilde/path expansion
eval desttop=`cat .destination`
jsonfile=$1
echo "Downloading $jsonfile"
json=`jq . < $jsonfile`
# TODO: assumes that there's only one colon, and the second part after the split is the right name.  This breaks on things like 'Humble Book Bundle: DIY presented by Make:'.  For now, we get around
# it by changing that package's json file
IFS=:  read -r -a human_name <<< `jq -r .product.human_name < $jsonfile`
folder="`sed -e 's/^\s*//' <<< ${human_name[-1]}`"

folder=$desttop/"$folder"

if [[ -e "$folder" ]];
then
    rm -rf "$folder"
fi

mkdir "$folder"

subproducts=`jq .subproducts <<< $json`
length=`jq length <<< $subproducts`
i=0
while [[ $i -lt $length ]]; do
    subproduct=`jq .[$i] <<< $subproducts`
    name=`jq .human_name <<< $subproduct`
    echo "Found $name..."
    # TODO: downloads array always is length=1...if we find that it's not we need to revisit this.
    downloads=`jq .downloads[0].download_struct <<< $subproduct`
    typelength=`jq length <<< $downloads`
    j=0
    while [[ $j -lt $typelength ]]; do
        download=`jq .[$j] <<< $downloads`
        typename=`jq .name <<< $download`
        url=`jq -r .url.web <<< $download`
        echo "Downloading $typename at $url..."
        wget -P "$folder/" --content-disposition $url
        j=$((j + 1))
    done
    i=$((i + 1))
done

echo "Download complete, $length titles downloaded."
