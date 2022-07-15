#!/bin/bash

#Unzip it
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
unzipFolder="${SCRIPT_DIR}/UnityLibrary"

if [ -d "$unzipFolder" ]; then
  rm -r "$unzipFolder"
fi

#Put it in desired folder
unzip -o "${SCRIPT_DIR}/UnityLibrary.zip" -d "$unzipFolder"