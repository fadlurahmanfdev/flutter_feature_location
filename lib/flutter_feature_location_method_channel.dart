import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_feature_location_platform_interface.dart';

/// An implementation of [FlutterFeatureLocationPlatform] that uses method channels.
class MethodChannelFlutterFeatureLocation extends FlutterFeatureLocationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_feature_location');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
