# realm_flutter

A new Flutter project.

## Getting Started

Realm windows car example

``` shell
flutter pub add realm
```

``` shell
flutter pub run realm generate --watch
```

### Support for windows

``` shell
flutter config --enable-windows-desktop
flutter create --platforms=windows .
start ms-settings:developer
flutter pub get
flutter run -d windows .
```

### Support for mac

``` shell
flutter create --platforms=macos .
flutter run -d macos
```
