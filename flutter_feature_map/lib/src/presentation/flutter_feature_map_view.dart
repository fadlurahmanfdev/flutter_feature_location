import 'package:flutter/material.dart';
import 'package:flutter_feature_map/flutter_feature_map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterFeatureMapView extends StatefulWidget {
  final FeatureMapController controller;

  const FlutterFeatureMapView({
    super.key,
    required this.controller,
  });

  @override
  State<FlutterFeatureMapView> createState() => _FlutterFeatureMapViewState();
}

class _FlutterFeatureMapViewState extends State<FlutterFeatureMapView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, MapControllerState state, Widget? child) {
        return FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-6.1719, 106.8229),
            minZoom: 2,
            initialZoom: 15,
            maxZoom: 19,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.fadlurahmanfdev.example',
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: LatLng(-6.1719, 106.8229),
                  radius: 500,
                  useRadiusInMeter: true,
                  color: Colors.blue.withOpacity(0.1),
                  borderColor: Colors.blue,
                  borderStrokeWidth: 2,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
