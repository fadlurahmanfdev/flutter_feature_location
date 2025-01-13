import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_feature_location/flutter_feature_location.dart';
import 'package:flutter_feature_location/flutter_feature_location_platform_interface.dart';
import 'package:flutter_feature_location/flutter_feature_location_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFeatureLocationPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFeatureLocationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFeatureLocationPlatform initialPlatform = FlutterFeatureLocationPlatform.instance;

  test('$MethodChannelFlutterFeatureLocation is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFeatureLocation>());
  });

  test('getPlatformVersion', () async {
    FlutterFeatureLocation flutterFeatureLocationPlugin = FlutterFeatureLocation();
    MockFlutterFeatureLocationPlatform fakePlatform = MockFlutterFeatureLocationPlatform();
    FlutterFeatureLocationPlatform.instance = fakePlatform;

    expect(await flutterFeatureLocationPlugin.getPlatformVersion(), '42');
  });
}
