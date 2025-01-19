import 'dart:developer';

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
          markersCoordinate: markersCoordinate ?? [],
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

  void addMarker({required List<FeatureMarkerCoordinate> coordinates}) {
    List<FeatureMarkerCoordinate> existingMarkers = value.markersCoordinate;
    List<String> oldIds = existingMarkers.map((element) => element.id).toList();
    List<String> existingLatLngs =
        existingMarkers.map((element) => '${element.latitude}|${element.longitude}').toList();
    List<FeatureMarkerCoordinate> newMarkers = coordinates;
    String? idsConflicted;
    bool? latLngConflicted;
    for (final newMarker in newMarkers) {
      if (oldIds.contains(newMarker.id)) {
        idsConflicted = newMarker.id;
        break;
      }

      if (existingLatLngs.contains('${newMarker.latitude}|${newMarker.longitude}')) {
        idsConflicted = newMarker.id;
        latLngConflicted = true;
        break;
      }
    }

    if (idsConflicted != null) {
      if (latLngConflicted == true) {
        log("conflicted latitude & longitude in marker id: $idsConflicted", level: 2000);
      } else {
        log("there is already marker with id: $idsConflicted", level: 2000);
      }
      return;
    }

    final newMarkersCoordinate = (value.recentlyAddedMarkersCoordinate ?? [])..addAll(coordinates);
    id++;
    value = value.copyWith(recentlyAddedMarkersCoordinate: newMarkersCoordinate, action: 'add-marker$id');
  }

  void removeMarker({required List<String> idsMarker}) {
    id++;
    value = value.copyWith(recentlyRemovedMarkersCoordinate: idsMarker, action: 'remove-marker$id');
  }

  void removeAllMarker() {
    id++;
    value = value.copyWith(recentlyRemovedMarkersCoordinate: value.markersCoordinate.map((element) => element.id).toList(), action: 'remove-marker$id');
  }

  void moveMarker(String idMarker, {required FeatureLocationCoordinate coordinate}) {
    assert(value.markersCoordinate.isNotEmpty == true);
    final newMarker = FeatureMarkerCoordinate(
      id: idMarker,
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
    );
    FeatureMarkerCoordinate? oldMarker;
    int indexMarkerChanges = -1;
    for (int i = 0; i < value.markersCoordinate.length; i++) {
      if (value.markersCoordinate[i].id == idMarker) {
        indexMarkerChanges = i;
        oldMarker = value.markersCoordinate[i];
        break;
      }
    }

    if (oldMarker == null) return;

    final newMarkersCoordinate = value.markersCoordinate..[indexMarkerChanges] = newMarker;
    id++;
    value = value.copyWith(markersCoordinate: newMarkersCoordinate, action: 'move-marker$id');
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
