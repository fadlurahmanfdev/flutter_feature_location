import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_feature_location_package_interface/flutter_feature_location_package_interface.dart';

class FeatureOSMMapView extends StatefulWidget {
  final FeatureMapController controller;

  const FeatureOSMMapView({
    super.key,
    required this.controller,
  });

  @override
  State<FeatureOSMMapView> createState() => _FeatureOSMMapViewState();
}

class _FeatureOSMMapViewState extends State<FeatureOSMMapView> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 0.0, longitude: 0.0),
  );
  ZoomOption? _zoomOption;

  FeatureLocationCoordinate? _mapCoordinate;
  final _markersCoordinate = <FeatureMarkerCoordinate>[];
  String? _action;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.addListener(() {
        if (widget.controller.value.mapCoordinate.serialize() != _mapCoordinate?.serialize()) {
          _mapCoordinate = widget.controller.value.mapCoordinate;
          controller.moveTo(
            GeoPoint(latitude: _mapCoordinate!.latitude, longitude: _mapCoordinate!.longitude),
            animate: true,
          );
        }

        if (widget.controller.value.action != _action) {
          _action = widget.controller.value.action;
          if (_action?.contains('zoom-in') == true) {
            controller.zoomIn();
            return;
          }

          if (_action?.contains('zoom-out') == true) {
            controller.zoomOut();
            return;
          }

          if (_action?.contains('move-marker') == true) {
            FeatureMarkerCoordinate? oldMarker;
            FeatureMarkerCoordinate? movedMarker;
            int indexMovedMarker = -1;

            for (int i = 0; i < (widget.controller.value.markersCoordinate ?? []).length; i++) {
              if ((_markersCoordinate ?? [])[i].serialize() !=
                  (widget.controller.value.markersCoordinate ?? [])[i].serialize()) {
                indexMovedMarker = i;
                oldMarker = (_markersCoordinate ?? [])[i];
                movedMarker = (widget.controller.value.markersCoordinate ?? [])[i];
                break;
              }
            }

            if (movedMarker != null && oldMarker != null) {
              _markersCoordinate[indexMovedMarker] = movedMarker;
              controller.changeLocationMarker(
                oldLocation: GeoPoint(latitude: oldMarker.latitude, longitude: oldMarker.longitude),
                newLocation: GeoPoint(latitude: movedMarker.latitude, longitude: movedMarker.longitude),
              );
            }
          }
        }
      });

      setState(() {
        _zoomOption = ZoomOption(
          stepZoom: widget.controller.value.zoomOption?.stepZoom ?? 1.0,
          maxZoomLevel: widget.controller.value.zoomOption?.maxZoomLevel ?? 19.0,
          minZoomLevel: widget.controller.value.zoomOption?.minZoomLevel ?? 2.0,
          initZoom: widget.controller.value.zoomOption?.initZoom ?? 10.0,
        );
      });
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, MapControllerState state, Widget? child) {
        if (_zoomOption == null) {
          return CircularProgressIndicator();
        }

        return OSMFlutter(
          controller: controller,
          onMapIsReady: (isReady) {
            if (isReady) {
              controller.moveTo(
                GeoPoint(
                  latitude: widget.controller.value.mapCoordinate.latitude,
                  longitude: widget.controller.value.mapCoordinate.longitude,
                ),
                animate: true,
              );


              if(widget.controller.value.markersCoordinate != null && widget.controller.value.markersCoordinate!.isNotEmpty){
                final markersCoordinate = widget.controller.value.markersCoordinate!;
                _markersCoordinate.addAll(markersCoordinate);
                for (final marker in _markersCoordinate) {
                  controller.addMarker(GeoPoint(latitude: marker.latitude, longitude: marker.longitude));
                }
              }
            }
          },
          osmOption: OSMOption(
            enableRotationByGesture: true,
            zoomOption: _zoomOption!,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.person,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.directions,
                  size: 48,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
