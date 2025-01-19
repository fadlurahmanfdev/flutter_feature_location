import 'package:flutter_feature_location_package_interface/src/model/location_coordinate.dart';

class FeatureMarkerCoordinate extends FeatureLocationCoordinate {
  String id;

  FeatureMarkerCoordinate({
    required this.id,
    required super.latitude,
    required super.longitude,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
