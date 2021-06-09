#!/bin/bash

declare -a mdcType=("2DC" "2.5DC" "3DC")

scenarios=( $(sed 1,1d scenarios.tsv | cut -d$'\t' -f1) )

for i in "${mdcType[@]}"
do
    echo "Generating scenarios for $i...."

    for s in "${scenarios[@]}"
    do
        category=$(cat scenarios.tsv | grep -e "^$s" | cut -d$'\t' -f2)
        name=$(cat scenarios.tsv | grep -e "^$s" | cut -d$'\t' -f3)
        description=$(cat scenarios.tsv | grep -e "^$s" | cut -d$'\t' -f4)

        #echo "Category: $category"
        #echo "Name: $name"
        #echo "Description: $description"
        #echo ""
        
        mkdir -p $i/scenarios/$s
        FILE=$i/scenarios/$s/runbook.adoc
        if test -f "$FILE"; then
            echo "$FILE exists."
            cat __Template_.adoc | sed "s/\${scenario-id}/$s/g; s/\${name}/$name/g; s/\${category}/$category/g; s/\${description}/$description/g" > $i/scenarios/$s/runbook.adoc
        else
            echo "Generating runbook $FILE"
            cat __Template_.adoc | sed "s/\${scenario-id}/$s/g; s/\${name}/$name/g; s/\${category}/$category/g; s/\${description}/$description/g" > $i/scenarios/$s/runbook.adoc
        fi

    done
done
