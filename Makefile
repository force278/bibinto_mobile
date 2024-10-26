.PHONY: prepare update get activate-fvm install-fvm pub-upgrade pub-upgrade-major activate-intl gen-build gen-build-delete gen-localization gen-watch gen-clean ios-update ios-update-x86_64 run run-shaders-warmup simulator git-ignore-update build-android-apk build-android-bundle build-ios build-mac build-linux build-web clean gen-asset

prepare: get activate-fvm install-fvm activate-intl gen-build-delete gen-localization gen-asset

update: install-fvm get install-fvm gen-build-delete gen-localization gen-asset

get:
	@echo "* Flutter pub get *"
	@fvm flutter pub get

activate-fvm:
	@echo "* Activating Flutter Version Management *"
	@dart pub global activate fvm

install-fvm:
	@echo "* Installing Flutter version for FVM from project configs *"
	@fvm install

pub-upgrade-major: get
	@echo "* Upgrading main project dependencies *"
	@fvm flutter pub upgrade --major-versions

pub-upgrade: get
	@echo "* Upgrading main project major dependencies *"
	@fvm flutter pub upgrade

activate-intl:
	@echo "Activate global Intl utils localization generator"
	@fvm flutter pub global activate intl_utils

gen-build:
	@echo "* Running build runner in main projects *"
	@fvm flutter packages pub run build_runner build

gen-asset:
	@echo "* Assets generation* "
	@fluttergen

gen-build-delete:
	@echo "* Running build runner in main projects with deletion of conflicting outputs *"
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

gen-localization:
	@echo "Generate localization"
	@fvm flutter pub global run intl_utils:generate

gen-watch:
	@echo "* Running build runner in main project in watch mode *"
	@fvm flutter pub run build_runner watch

gen-clean:
	@echo "* Cleaning build runner in main project *"
	@fvm flutter pub run build_runner clean

ios-update:
	@echo "* Pod install *"
	@cd ios && pod install

ios-update-x86_64:
	@echo "* Pod install *"
	@cd ios && arch -x86_64 pod install

run:
	@echo "* Running app *"
	@fvm flutter run

run-shaders-warmup:
	@echo "* Running app for shaders warmup *"
	@fvm flutter run --profile --cache-sksl --purge-persistent-cache

simulator:
	@echo "* Opening an iOS simulator *"
	@open -a Simulator

git-ignore-update:
	@echo "* Git ignore update *"
	@git rm -r --cached .
	@git add .

build-android-apk:
	@echo "* Build apk file for android *"
	@fvm flutter build apk --release

build-android-bundle:
	@echo "* Build android bundle *"
	@fvm flutter build appbundle --release

build-ios:	
	@echo "* Build iOS ipa *"
	@fvm flutter build ipa --release --export-options-plist=./ios/Runner/ExportOptions.plist

clean:
	@echo "* Flutter clean *"
	@fvm flutter clean
