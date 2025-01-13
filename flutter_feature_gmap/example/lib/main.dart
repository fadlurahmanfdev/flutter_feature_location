import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feature_gmap/flutter_feature_gmap.dart';
import 'package:flutter_feature_gmap/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  FeatureMapController controller =  FeatureMapController(
    initCoordinate: FeatureLocationCoordinate(latitude: -6.373102, longitude: 106.834625),
    zoomOption: FeatureZoomOption(
      stepZoom: 1.0,
      maxZoomLevel: 19.0,
      minZoomLevel: 2.0,
      initZoom: 16.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FeatureGmapView(controller: controller),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the Monas!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    controller.moveToPosition(FeatureLocationCoordinate(latitude: -6.1719, longitude: 106.8229));
  }
}
