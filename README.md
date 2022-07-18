[![Codemagic build status](https://api.codemagic.io/apps/60d536fd19e6aa32f8ae59d3/60d536fd19e6aa32f8ae59d2/status_badge.svg)](https://codemagic.io/apps/60d536fd19e6aa32f8ae59d3/60d536fd19e6aa32f8ae59d2/latest_build)

# satorio

Sator mobile client

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Building with Unity

The Unity library comes in zip file and should be extract in proper location.
For correct extraction, please use UnpackUnityAndroid.sh script.
It will unzip it in correct location and put correct il2cpp compiler version regarding on running platform (macOS, Win).

You can run UnpackUnityAndroid.sh script from your terminal or just add it to running configurations, like this:
<img width="351" alt="image" src="https://user-images.githubusercontent.com/20683443/179269494-6ec5cef0-f53f-425e-8b0d-a3936314bc77.png">

But please make sure, that you are running it from bash not from zsh!

For iOS you can also use UnpackUnityIos.sh script, or you can just unzip UnityLibrary.zip in the folder, where it is located.
Using scripts UnpackUnityIos.sh and UnpackUnityAndroid.sh is highly recommended, because they use checksums to make sure you always have
fresh Unity build.
Feel free to add unityLibrary folder to ignore list, but be aware of future builds.
Probably you will need to delete those folders (unityLibrary for Android and UnityLibrary for iOS).
