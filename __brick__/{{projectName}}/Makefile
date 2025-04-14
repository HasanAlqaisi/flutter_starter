.PHONY: translate clean_get build watch apk aab

translate:
	dart run slang

splash:
	dart run flutter_native_splash:create --path=flutter_native_splash.yaml

clean_get:
	flutter clean
	flutter pub get

build:
	flutter pub run build_runner build -d

watch:
	flutter pub run build_runner watch

apk: clean_get build
	flutter build apk

aab: clean_get build
	flutter build aab