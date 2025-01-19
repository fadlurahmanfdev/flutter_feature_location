import 'package:flutter/material.dart';
import 'package:flutter_feature_location_package_interface/src/controller/map_controller_state.dart';
import 'package:flutter_feature_location_package_interface/src/model/location_coordinate.dart';
import 'package:flutter_feature_location_package_interface/src/model/marker_coordinate.dart';
import 'package:flutter_feature_location_package_interface/src/model/zoom_option.dart';

class FeatureMapController extends ValueNotifier<MapControllerState> {
  FeatureMapController({
    required FeatureLocationCoordinate initMapCoordinate,
    List<FeatureMarkerCoordinate>? markersCoordinate,
    FeatureZoomOption? zoomOption,
  }) : super(MapControllerState(
          mapCoordinate: initMapCoordinate,
          markersCoordinate: markersCoordinate,
          zoomOption: zoomOption,
        )) {
    _zoomOption = zoomOption;
  }

  int id = 0;

  FeatureZoomOption? _zoomOption;

  void moveMap(FeatureLocationCoordinate coordinate) {
    if (value.mapCoordinate.serialize() != coordinate.serialize()) {
      value = value.copyWith(mapCoordinate: coordinate);
    }
  }

  void moveMarker(String idMarker, {required FeatureLocationCoordinate coordinate}) {
    assert(value.markersCoordinate != null);
    assert(value.markersCoordinate?.isNotEmpty == true);
    final newMarker = FeatureMarkerCoordinate(
      id: idMarker,
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
    );
    FeatureMarkerCoordinate? oldMarker;
    int indexMarkerChanges = -1;
    for (int i = 0; i < (value.markersCoordinate?.length ?? 0); i++) {
      if (value.markersCoordinate?[i].id == idMarker) {
        indexMarkerChanges = i;
        oldMarker = value.markersCoordinate?[i];
        break;
      }
    }

    if (oldMarker == null) return;

    final newMarkersCoordinate = value.markersCoordinate!
      ..[indexMarkerChanges] = newMarker;
    id++;
    value = value.copyWith(markersCoordinate: newMarkersCoordinate,action: 'move-marker$id');
  }

  void zoomIn() {
    assert(_zoomOption != null);

    if (_zoomOption == null) return;

    id++;
    double postZoomValue = value.zoom + _zoomOption!.stepZoom;
    if (postZoomValue < _zoomOption!.maxZoomLevel) {
      value = value.copyWith(zoom: postZoomValue, action: 'zoom-in$id');
    }
  }

  void zoomOut() {
    assert(_zoomOption != null);

    if (_zoomOption == null) return;

    id++;
    double postZoomValue = value.zoom - _zoomOption!.stepZoom;
    if (postZoomValue > _zoomOption!.minZoomLevel) {
      value = value.copyWith(zoom: postZoomValue, action: 'zoom-out$id');
    }
  }
}
