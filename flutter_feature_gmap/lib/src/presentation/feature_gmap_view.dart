import 'package:flutter/material.dart';
import 'package:flutter_feature_location_package_interface/flutter_feature_location_package_interface.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FeatureGmapView extends StatefulWidget {
  final FeatureMapController controller;

  const FeatureGmapView({
    super.key,
    required this.controller,
  });

  @override
  State<FeatureGmapView> createState() => _FeatureGmapViewState();
}

class _FeatureGmapViewState extends State<FeatureGmapView> {
  late GoogleMapController _controller;
  final _initialCameraPosition = CameraPosition(
    bearing: 0,
    target: LatLng(0.0, 0.0),
    zoom: 15.0,
  );

  FeatureLocationCoordinate? _coordinate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.addListener(() {
        if (widget.controller.coordinate?.serialize() != _coordinate?.serialize()) {
          _coordinate = widget.controller.coordinate;
          _controller.animateCamera(CameraUpdate.newLatLng(LatLng(_coordinate!.latitude, _coordinate!.longitude)));
        }
      });
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (BuildContext context, MapControllerState state, Widget? child) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            zoomControlsEnabled: false,
            compassEnabled: false,
            buildingsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;

              if (widget.controller.coordinate?.latitude != null && widget.controller.coordinate?.longitude != null) {
                final lat = widget.controller.coordinate!.latitude;
                final long = widget.controller.coordinate!.longitude;
                _controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
              }
            },
          );
        });
  }
}
