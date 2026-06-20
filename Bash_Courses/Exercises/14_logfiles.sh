#!/bin/bash

dir_search="${1:-/var/log}" # if no argument passed, default /var/log

echo "Listing readable files in ${dir_search}..."

output=$(find "$dir_search" -type f -readable) # find is recursive -> check sub-folder
mkdir ~/result_dir_search

while IFS= read -r file; do # IFS Internal Field Separator = keeps spaces before and after
    cp "$file" ~/result_dir_search
done <<< "$output"
echo "Compressing into result_dir_search.tar..."
tar -cf ~/result_dir_search.tar ~/result_dir_search 