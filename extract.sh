#!/bin/bash

set -euxo pipefail

BASE_PATH="/media/fjammes/secu"

# TODO add if statement mail/file

# MAILS
is_mail=true
REPORT_PATH="$BASE_PATH/home/LGP-mails/Reports/LGP-mails Excel Report 05-09-2023-17-26-53/Excel.csv"
data_path="$BASE_PATH/data/mails"
out_path="$BASE_PATH/annexes/mails"

# FILES
is_mail=false
REPORT_PATH="$BASE_PATH/home/LGP-fichiers/Reports/LGP-fichiers Excel Report 05-09-2023-20-19-12/Excel.csv"
data_path="$BASE_PATH/data/"
out_path="$BASE_PATH/annexes/fichiers"

# PHONE
is_mail=false
REPORT_PATH="$BASE_PATH/home/LGP-iphone/Reports/LGP-iphone Excel Report 05-11-2023-15-18-22/Excel.csv"
data_path="$BASE_PATH/data/iPhone"
out_path="$BASE_PATH/annexes/iphone"

file_to_keep="/tmp/file_to_keep.txt"
mailbody_to_keep="/tmp/mailbody_to_keep.txt"
archive_to_keep="/tmp/archive_to_keep.txt"
all_keep="/tmp/all_keep.txt"

LFS="/LogicalFileSet1"

grep "$LFS" "$REPORT_PATH" | awk -F, '{print $(NF-1)}' | grep -v jpg | grep -v png > "$file_to_keep"
sed -i "s,^$LFS,," "$file_to_keep"

# Remove zip file content because not present on filesystem
if cat "$file_to_keep" | egrep "\.zip"
then
  cat "$file_to_keep" | egrep "\.zip" | sed -E "s/(.*\.zip)\/(.*)/\1/" | uniq > $archive_to_keep
  sed -i -E "s/(.*\.zip)\/(.*)/\1/" "$file_to_keep"
fi

# Check mail for pdf and docx?

# Mail body to keep
# TODO add if statement

> "$mailbody_to_keep"
if $is_mail
then
  cat "$file_to_keep" | egrep "\/([0-9])+-" | sed -E "s/(.*)\/([0-9]+)-(.*)/\1\/\2/" | uniq > $mailbody_to_keep
fi

cat $file_to_keep $mailbody_to_keep $archive_to_keep | grep -v "mp4" > $all_keep

rm -rf $out_path/*
rsync -av --files-from="$all_keep" "$data_path" "$out_path"

