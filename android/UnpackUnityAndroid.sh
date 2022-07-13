#!/bin/bash

#Unzip it
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
unzipFolder="${SCRIPT_DIR}/unityLibrary"

if [ -d "$unzipFolder" ]; then
  rm -r "$unzipFolder"
fi

#Put it in desired folder
unzip -o "${SCRIPT_DIR}/unityLibrary.zip" -d "$SCRIPT_DIR"

unityGradlePath="${unzipFolder}/build.gradle"
value=`cat "$unityGradlePath"`
updated_gradle=$value
#updated_gradle="${updated_gradle}
#    buildTypes {
#        profile {}
#    }
#}"

if [[ "$OSTYPE" == "darwin"* ]]; then
    updated_gradle=${updated_gradle//\/il2cpp.exe/"/il2cpp"}
elif [[ "$OSTYPE" == "msys"* ]]; then
  if [[ $updated_gradle != *"/il2cpp.exe"* ]]; then
    updated_gradle=${updated_gradle//\/il2cpp/"/il2cpp.exe"}
  fi
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
