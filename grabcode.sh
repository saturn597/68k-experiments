#!/bin/bash

# Doing development in Mini vMac, so the files are on an HFS disk image.
# This script grabs them off the image and moves them to the project directory.

mount -t hfs disk.dsk mnt -o ro

if [ $? -ne 0 ]; then
  echo "Script failed."
  echo "We probably need superuser privileges to mount the disk image."
  exit 1
fi

# Classic Macs used carriage returns as line breaks. Switch to \n.
FILES=`ls mnt`
for f in $FILES
do
  if [ "${f: -2}" == ".a" ]; then
    sed 's/\r/\n/g' "mnt/$f" > "src/$f"
  fi
done

chmod 666 src/*

# Clean up
umount mnt
