#!/bin/bash
#Constants
readonly GITHUB_URL=https://api.github.com/repos/SatorNetwork/sator-unity/actions/artifacts
readonly NODE_NAME=unityLibrary

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

#Put it in desired folder
mkdir -p "$unzipFolder"
unzip -o unityTemp.zip -d "$unzipFolder"

rm -f unityTemp.zip

#Run flutter
#flutter pub get
#flutter pub run flutter_unity:unity_export_transmogrify

#Update unity gradle build script
unityGradlePath="${unzipFolder}/build.gradle"
value=`cat "$unityGradlePath"`
updated_gradle=${value%?}
updated_gradle="${updated_gradle}
    buildTypes {
        profile {}
    }
}"

if [[ "$OSTYPE" == "darwin"* ]]; then
  string_with_correct_slashes=".replaceAll('\\\\\\"
  updated_gradle="${updated_gradle//.replaceAll(''\'/$string_with_correct_slashes}"
fi

#Save changes to gradle build script
echo "$updated_gradle" > "$unityGradlePath"
echo "$updated_gradle"

il2cpp_path="${unzipFolder}/src/main/Il2CppOutputProject/IL2CPP/build/deploy/netcoreapp3.1"
rm -r "$il2cpp_path"

if [[ "$OSTYPE" == "msys"* ]]; then
  unzip -o "${SCRIPT_DIR}/netcoreapp3.1_windows.zip" -d "$il2cpp_path"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  unzip -o "${SCRIPT_DIR}/netcoreapp3.1_darwin.zip" -d "$il2cpp_path"
fi

#Fixed by plugin
#cp -R "${SCRIPT_DIR}/unity-classes.jar" "${unzipFolder}/libs"

#Update styles
function update_styles () {
   local styles_file=`cat "$1"`
   styles_file="${styles_file//<resources>/<resources>
    <string name=\"game_view_content_description\">Game view</string>}"
    echo "$styles_file" > "$1"
}

update_styles "${unzipFolder}/src/main/res/values/styles.xml"
update_styles "${unzipFolder}/src/main/res/values-v21/styles.xml"
update_styles "${unzipFolder}/src/main/res/values-v28/styles.xml"