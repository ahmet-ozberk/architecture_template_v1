flutter packages pub run build_runner build
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

flutter run --release

flutter clean
rm -Rf ios/Pods
rm -Rf ios/.symlinks
rm -Rf ios/Flutter/Flutter.framework
rm -Rf ios/Flutter/Flutter.podspec
flutter pub get
cd ios
pod install 
arch -x86_64 pod install  //(On an M1 mac use => arch -x86_64 pod install)
# arch -x86_64 pod install --repo-update
cd ..
flutter build ios
flutter run