import 'dart:convert';

class FeatureLocationCoordinate {
  double latitude;
  double longitude;

  FeatureLocationCoordinate({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String serialize() => json.encode(toJson());
}
