#!/bin/bash

$fm_import
for f in "${fm_files[@]}"; do
   echo -n "\"${f/\"/\\\"}\" "
done
