import 'package:flutter_feature_location_package_interface/flutter_feature_location_package_interface.dart';

class MapControllerState {
  FeatureLocationCoordinate coordinate;
  FeatureZoomOption? zoomOption;

  MapControllerState({
    required this.coordinate,
    this.zoomOption,
  });

  MapControllerState copyWith({
    FeatureLocationCoordinate? coordinate,
    FeatureZoomOption? zoomOption,
  }) {
    return MapControllerState(
      coordinate: coordinate ?? this.coordinate,
      zoomOption: zoomOption ?? this.zoomOption,
    );
  }
}
