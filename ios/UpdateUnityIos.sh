#!/bin/bash
#Constants
readonly GITHUB_URL=https://api.github.com/repos/cc-setwo/ActionsUnityTest/actions/artifacts
readonly NODE_NAME=UnityProject

#Fetch list of all artifacts
content=$(curl -L $GITHUB_URL)

#Split them by comma
a=($(echo "$content" | tr ',' '\n'))

declare artifact_number

id_node="\"id\":"
name_node="\"name\":"
name_value="\"${NODE_NAME}\""

#Find node with the name value NODE_NAME

for index in "${!a[@]}"
do
  current_node=${a[index]}

  if [ "$current_node" = "$name_node" ] && [ "${a[index + 1]}" = "$name_value" ]; then
    break
  fi

  if [ "$current_node" = "$id_node" ]; then
    artifact_number="${a[index + 1]}"
  fi
done

#Download a zip
downloadUrl="${GITHUB_URL}/${artifact_number}/zip"
curl -v -L -H "Authorization: token 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" $downloadUrl -o unityTemp.zip

#Unzip it
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
unzipFolder="${SCRIPT_DIR}/${NODE_NAME}"

if [ -d "$unzipFolder" ]; then
  rm -r "$unzipFolder"
fi

#Put it in deisred folder
mkdir -p "$unzipFolder"
unzip -o unityTemp.zip -d "$unzipFolder"

rm -f unityTemp.zip

update_permissions_file="${unzipFolder}/MapFileParser.sh"
chmod +x "$update_permissions_file"