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

  FeatureLocationCoordinate? _coordinate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      widget.controller.addListener(() {
        if (widget.controller.coordinate?.serialize() != _coordinate?.serialize()) {
          _coordinate = widget.controller.coordinate;
          controller.moveTo(
            GeoPoint(latitude: _coordinate!.latitude, longitude: _coordinate!.longitude),
            animate: true,
          );
        }
      });

      setState(() {
        _zoomOption = ZoomOption(
          stepZoom: widget.controller.zoomOption?.stepZoom ?? 1.0,
          maxZoomLevel: widget.controller.zoomOption?.maxZoomLevel ?? 19.0,
          minZoomLevel: widget.controller.zoomOption?.minZoomLevel ?? 2.0,
          initZoom: widget.controller.zoomOption?.initZoom ?? 10.0,
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
                  latitude: widget.controller.coordinate?.latitude ?? 0.0,
                  longitude: widget.controller.coordinate?.longitude ?? 0.0,
                ),
                animate: true,
              );
            }
          },
          osmOption: OSMOption(
            enableRotationByGesture: true,
            zoomOption: _zoomOption!,
          ),
        );
      },
    );
  }
}
