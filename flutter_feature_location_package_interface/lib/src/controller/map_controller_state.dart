import 'package:flutter_feature_location_package_interface/flutter_feature_location_package_interface.dart';

class MapControllerState {
  FeatureLocationCoordinate mapCoordinate;
  List<FeatureMarkerCoordinate> markersCoordinate;
  // for add marker purpose
  final List<FeatureMarkerCoordinate>? recentlyAddedMarkersCoordinate;
  // for remove marker purpose
  final List<String>? recentlyRemovedMarkersCoordinate;
  FeatureZoomOption? zoomOption;
  double zoom = 10.0;
  String? action;

  MapControllerState({
    required this.mapCoordinate,
    required this.markersCoordinate,
    this.recentlyAddedMarkersCoordinate,
    this.recentlyRemovedMarkersCoordinate,
    this.zoomOption,
    this.zoom = 16.0,
    this.action,
  });

  MapControllerState copyWith({
    FeatureLocationCoordinate? mapCoordinate,
    List<FeatureMarkerCoordinate>? markersCoordinate,
    List<FeatureMarkerCoordinate>? recentlyAddedMarkersCoordinate,
    List<String>? recentlyRemovedMarkersCoordinate,
    FeatureZoomOption? zoomOption,
    double? zoom,
    String? action,
  }) {
    return MapControllerState(
      mapCoordinate: mapCoordinate ?? this.mapCoordinate,
      markersCoordinate: markersCoordinate ?? this.markersCoordinate,
      recentlyAddedMarkersCoordinate: recentlyAddedMarkersCoordinate,
      recentlyRemovedMarkersCoordinate: recentlyRemovedMarkersCoordinate,
      zoomOption: zoomOption ?? this.zoomOption,
      zoom: zoom ?? this.zoom,
      action: action,
    );
  }
}
