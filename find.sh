#!/bin/bash

set -euo pipefail

search_path='/media/fjammes/T7 Shield/data'
search_strings="varennes plan"

for search_string in $search_strings;
do
    echo "SEARCHING $search_string"
    find "$search_path" -name '*.doc' | while read -r file; do
        if catdoc "$file" | grep -Hi --label="$file" "$search_string"; then
            echo "$file"
        fi
    done

    find "$search_path" -name '*.xls' | while read -r file; do
        if xls2csv "$file" | grep -Hi --label="$file" "$search_string"; then
            echo "$file"
        fi
    done

    find "$search_path" -name '*.docx' | while read -r file; do
        ugrep -Hi --label="$file" "$search_string" || true
    done

    find "$search_path" -name '*.xlsx' | while read -r file; do
        ugrep -Hi --label="$file" "$search_string" || true
    done

    find "$search_path" -name '*.pptx' | while read -r file; do
        ugrep -Hi --label="$file" "$search_string" || true
    done

    find "$search_path" -type f \( ! -iname  "*.doc" ! -iname "*.xls" ! -iname  "*.docx" ! -iname "*.xlsx" ! -iname "*.pptx" \) | while read -r file; do
        if grep -Hi "$search_string" "$file"; then
            echo "$file"
        fi
    done
done