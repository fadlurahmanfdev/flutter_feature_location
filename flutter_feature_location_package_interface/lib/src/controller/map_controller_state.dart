import 'package:flutter_feature_location_package_interface/flutter_feature_location_package_interface.dart';

class MapControllerState {
  FeatureLocationCoordinate mapCoordinate;
  List<FeatureMarkerCoordinate>? markersCoordinate;
  FeatureZoomOption? zoomOption;
  double zoom = 10.0;
  String? action;

  MapControllerState({
    required this.mapCoordinate,
    required this.markersCoordinate,
    this.zoomOption,
    this.zoom = 10.0,
    this.action,
  });

  MapControllerState copyWith({
    FeatureLocationCoordinate? mapCoordinate,
    List<FeatureMarkerCoordinate>? markersCoordinate,
    FeatureZoomOption? zoomOption,
    double? zoom,
    String? action,
  }) {
    return MapControllerState(
      mapCoordinate: mapCoordinate ?? this.mapCoordinate,
      markersCoordinate: markersCoordinate ?? this.markersCoordinate,
      zoomOption: zoomOption ?? this.zoomOption,
      zoom: zoom ?? this.zoom,
      action: action,
    );
  }
}
