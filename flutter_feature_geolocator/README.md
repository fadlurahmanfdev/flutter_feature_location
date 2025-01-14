# Description

Flutter package to handle geolocator, it depends on [geolocator](https://pub.dev/packages/geolocator) library.

## Key Features

### Open App Setting

Opens the App settings page.

```dart
Future<void> screenFunction() async {
  final geolocator = FeatureGeoLocator();
  geolocator.openAppSetting();
}
```

### Open Location Setting

Opens the location settings page.

```dart
Future<void> screenFunction() async {
  final geolocator = FeatureGeoLocator();
  geolocator.openLocationSettings();
}
```

### Permission

Check the location permission of apps.

```dart
Future<void> screenFunction() async {
  final geolocator = FeatureGeoLocator();
  final permissionResult = await geolocator.checkPermission();
  if(permissionResult == LocationPermission.always || permissionResult == LocationPermission.whileInUse){
    // permission success
  }
}
```

### Last Known Location

Check the last known location of the device

```dart
Future<void> screenFunction() async {
  final lastKnownLocation = await featureGeoLocator.getLastKnownLocation();
  log("last known: ${lastKnownLocation?.longitude} & ${lastKnownLocation?.longitude}");
}
```

### Current Position

Check the current position

```dart
Future<void> screenFunction() async {
  final locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    timeLimit: Duration(seconds: 60),
  );
  final currentPosition = await featureGeoLocator.getCurrentPosition(locationSettings: locationSettings);
  // process current position
}
```

### Distance Between Two Location

Check the distance between two location

```dart
Future<void> screenFunction() async {
  final distance = featureGeoLocator.distanceBetween(
      startLatitude: -6.1719, 
      startLongitude: 106.8229, 
      endLatitude: -6.373102, 
      endLongitude: 106.834625,
  );
  // process distance
}
```

### Check Fake Location

Check device using fake/mock location

```dart
Future<void> screenFunction() async {
  final isFakeLocation = featureGeoLocator.isFakeLocation();
  // process fake location
}
```