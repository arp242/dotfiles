#!/bin/bash
# $dotid$

$fm_import
for f in "${fm_files[@]}"; do
   echo -n "\"${f/\"/\\\"}\" "
done
