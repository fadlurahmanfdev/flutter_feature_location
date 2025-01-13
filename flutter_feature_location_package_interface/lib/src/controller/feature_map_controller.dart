import 'package:flutter/material.dart';
import 'package:flutter_feature_location_package_interface/src/controller/map_controller_state.dart';
import 'package:flutter_feature_location_package_interface/src/model/location_coordinate.dart';
import 'package:flutter_feature_location_package_interface/src/model/zoom_option.dart';

class FeatureMapController extends ValueNotifier<MapControllerState> {
  FeatureMapController({
    required FeatureLocationCoordinate initCoordinate,
    this.zoomOption,
  }) : super(MapControllerState(
          coordinate: initCoordinate,
          zoomOption: zoomOption,
        )) {
    coordinate = initCoordinate;
  }

  FeatureLocationCoordinate? coordinate;

  FeatureZoomOption? zoomOption;

  void moveToPosition(FeatureLocationCoordinate coordinate) {
    if (this.coordinate?.serialize() != coordinate.serialize()) {
      this.coordinate = coordinate;
      value = value.copyWith(coordinate: coordinate);
    }
  }
}
