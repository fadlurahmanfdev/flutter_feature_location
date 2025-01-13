
import 'flutter_feature_location_platform_interface.dart';

class FlutterFeatureLocation {
  Future<String?> getPlatformVersion() {
    return FlutterFeatureLocationPlatform.instance.getPlatformVersion();
  }
}
