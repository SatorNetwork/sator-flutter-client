.PHONY: deps fix-deps

deps: 
	flutter clean && flutter pub get \
	&& cd ios && arch -x86_64 pod install && cd ../

fix-deps: 
	flutter clean && flutter pub get \
	&& sudo arch -x86_64 gem install ffi \
	&& rm -vf ios/Podfile.lock \
	&& cd ios && arch -x86_64 pod install --repo-update && cd ../