.PHONY: deps fix-deps

deps: 
	rm -Rf .dart_tool build .flutter-plugins .flutter-plugins-dependencies .packages \
	&& flutter clean && flutter pub get \
	&& cd ios && arch -x86_64 pod install && cd ../

fix-deps: 
	rm -Rf .dart_tool build .flutter-plugins .flutter-plugins-dependencies .packages \
	&& flutter clean && flutter pub get \
	&& sudo arch -x86_64 gem install ffi \
	&& rm -vf ios/Podfile.lock \
	&& cd ios && arch -x86_64 pod install --repo-update && cd ../