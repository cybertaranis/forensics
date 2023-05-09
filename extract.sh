#!/bin/bash

set -euxo pipefail


BASE_PATH="/media/fjammes/secu"
REPORT_PATH="$BASE_PATH/home/LGP-mails/Reports/LGP-mails Excel Report 05-09-2023-17-26-53/Excel.csv"
data_path="$BASE_PATH/data/mails"
OUT_PATH="$data_path/outmail"

file_to_keep="/tmp/include.txt"

LFS="/LogicalFileSet1"

grep "$LFS" "$REPORT_PATH" | awk -F, '{print $(NF-1)}' | grep -v jpg | grep -v png > "$file_to_keep"
sed -i "s,^$LFS,," "$file_to_keep"
rsync -av --files-from="$file_to_keep" "$data_path" "$OUT_PATH"

