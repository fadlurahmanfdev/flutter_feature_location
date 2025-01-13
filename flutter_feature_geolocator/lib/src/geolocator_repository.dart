import 'package:geolocator/geolocator.dart';

abstract class FeatureGeoLocatorRepository {
  /// Returns a [Future] containing a [bool] value indicating whether location
  /// services are enabled on the device.
  Future<bool> isLocationServiceEnabled();

  /// Opens the App settings page.
  ///
  /// Returns [true] if the location settings page could be opened, otherwise
  /// [false] is returned.
  Future<void> openAppSetting();

  /// Opens the location settings page.
  ///
  /// Returns [true] if the location settings page could be opened, otherwise
  /// [false] is returned.
  Future<void> openLocationSettings();

  /// Returns a [Future] indicating if the user allows the App to access
  /// the device's location.
  Future<LocationPermission> checkPermission();

  /// Request permission to access the location of the device.
  ///
  /// Returns a [Future] which when completes indicates if the user granted
  /// permission to access the device's location.
  /// Throws a [PermissionDefinitionsNotFoundException] when the required
  /// platform specific configuration is missing (e.g. in the
  /// AndroidManifest.xml on Android or the Info.plist on iOS).
  /// A [PermissionRequestInProgressException] is thrown if permissions are
  /// requested while an earlier request has not yet been completed.
  Future<void> requestPermission();

  /// Returns the last known position stored on the users device.
  ///
  /// On Android you can force the plugin to use the old Android
  /// LocationManager implementation over the newer FusedLocationProvider by
  /// passing true to the [forceAndroidLocationManager] parameter. On iOS
  /// this parameter is ignored.
  /// When no position is available, null is returned.
  Future<void> getLastKnownLocation({bool useNewerFusedLocationProvider = true});

  /// Returns the current position.
  ///
  /// You can control the behavior of the location update by specifying an instance of
  /// the [LocationSettings] class for the [locationSettings] parameter.
  /// Standard settings are:
  /// * `LocationSettings.accuracy`: allows controlling the precision of the position updates by
  /// supplying (defaults to "best");
  /// * `LocationSettings.distanceFilter`: allows controlling the minimum
  /// distance the device needs to move before the update is emitted (default
  /// value is 0 which indicates no filter is used);
  /// * `LocationSettings.timeLimit`: allows for setting a timeout interval. If
  /// between fetching locations the timeout interval is exceeded a
  /// [TimeoutException] will be thrown. By default no time limit is configured.
  ///
  /// If you want to specify platform specific settings you can use the
  /// [AndroidSettings], [AppleSettings] and [WebSettings] classes.
  ///
  /// You can control the precision of the location updates by supplying the
  /// [desiredAccuracy] parameter (defaults to "best").
  /// On Android you can force the use of the Android LocationManager instead of
  /// the FusedLocationProvider by setting the [forceAndroidLocationManager]
  /// parameter to true. The [timeLimit] parameter allows you to specify a
  /// timeout interval (by default no time limit is configured).
  ///
  /// Calling the [getCurrentPosition] method will request the platform to
  /// obtain a location fix. Depending on the availability of different location
  /// services, this can take several seconds. The recommended use would be to
  /// call the [getLastKnownPosition] method to receive a cached position and
  /// update it with the result of the [getCurrentPosition] method.
  ///
  /// Throws a [TimeoutException] when no location is received within the
  /// supplied [timeLimit] duration.
  /// Throws a [LocationServiceDisabledException] when the user allowed access,
  /// but the location services of the device are disabled.
  ///
  ///
  /// **Note**: On Android the location *accuracy* is interpreted as
  /// [location *priority*](https://developers.google.com/android/reference/com/google/android/gms/location/Priority#constants).
  /// The interpretation works as follows:
  ///
  /// [LocationAccuracy.lowest] -> [PRIORITY_PASSIVE](https://developers.google.com/android/reference/com/google/android/gms/location/Priority#public-static-final-int-priority_passive):
  /// Ensures that no extra power will be used to derive locations. This
  /// enforces that the request will act as a passive listener that will only
  /// receive "free" locations calculated on behalf of other clients, and no
  /// locations will be calculated on behalf of only this request.
  ///
  /// [LocationAccuracy.low] -> [PRIORITY_LOW_POWER](https://developers.google.com/android/reference/com/google/android/gms/location/Priority#public-static-final-int-priority_low_power):
  /// Requests a tradeoff that favors low power usage at the possible expense of
  /// location accuracy.
  ///
  /// [LocationAccuracy.medium] -> [PRIORITY_BALANCED_POWER_ACCURACY](https://developers.google.com/android/reference/com/google/android/gms/location/Priority#public-static-final-int-priority_balanced_power_accuracy):
  /// Requests a tradeoff that is balanced between location accuracy and power
  /// usage.
  ///
  /// [LocationAccuracy.high]+ -> [PRIORITY_HIGH_ACCURACY](https://developers.google.com/android/reference/com/google/android/gms/location/Priority#public-static-final-int-priority_high_accuracy):
  /// Requests a tradeoff that favors highly accurate locations at the possible
  /// expense of additional power usage.
  Future<void> getCurrentPosition({LocationSettings? locationSettings});

  /// Calculates the distance between the supplied coordinates in meters.
  ///
  /// The distance between the coordinates is calculated using the Haversine
  /// formula (see https://en.wikipedia.org/wiki/Haversine_formula). The
  /// supplied coordinates [startLatitude], [startLongitude], [endLatitude] and
  /// [endLongitude] should be supplied in degrees.
  double distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}
