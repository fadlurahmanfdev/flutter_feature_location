import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_feature_location_method_channel.dart';

abstract class FlutterFeatureLocationPlatform extends PlatformInterface {
  /// Constructs a FlutterFeatureLocationPlatform.
  FlutterFeatureLocationPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFeatureLocationPlatform _instance = MethodChannelFlutterFeatureLocation();

  /// The default instance of [FlutterFeatureLocationPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFeatureLocation].
  static FlutterFeatureLocationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFeatureLocationPlatform] when
  /// they register themselves.
  static set instance(FlutterFeatureLocationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
