#!/bin/bash

#Unzip it
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
unzipFolder="${SCRIPT_DIR}/UnityLibrary"

#Check for checksum
checkSumFile="${SCRIPT_DIR}/unity_zip_check_sum"
checksum=$(shasum -a256 "${SCRIPT_DIR}/UnityLibrary.zip")
oldChecksum=`cat "$checkSumFile"`

#If the same exit
if [ "$checksum" = "$oldChecksum" ]; then
  echo "Everything is updated"
  exit
fi

#If not unzip it
if [ -d "$unzipFolder" ]; then
  rm -r "$unzipFolder"
fi

#Put it in desired folder
unzip -o "${SCRIPT_DIR}/UnityLibrary.zip" -d "$unzipFolder"

#Update checksum file
echo "$checksum" > "$checkSumFile"