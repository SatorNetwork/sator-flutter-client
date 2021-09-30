.PHONY: deps fix-deps

deps: 
	flutter clean && flutter pub get \
	&& cd ios && arch -x86_64 pod install && cd ../

fix-deps: 
	flutter clean && flutter pub get \
	# && sudo arch -x86_64 gem install ffi \
	&& cd ios && arch -x86_64 pod install && cd ../