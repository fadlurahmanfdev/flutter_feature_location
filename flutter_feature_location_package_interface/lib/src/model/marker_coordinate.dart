import 'package:flutter/material.dart';
import 'package:flutter_feature_location_package_interface/src/model/location_coordinate.dart';

class FeatureMarkerCoordinate extends FeatureLocationCoordinate {
  String id;
  Widget? icon;

  FeatureMarkerCoordinate({
    required this.id,
    this.icon,
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
