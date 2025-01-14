import 'dart:developer';

import 'package:example/data/dto/model/feature_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feature_geolocator/flutter_feature_geolocator.dart';
import 'package:flutter_feature_geolocator/geolocator.dart';

import 'presentation/widget/feature_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Feature Biometric',
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
      home: const MyHomePage(title: 'Flutter Feature Biometric'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FeatureGeoLocatorRepository featureGeoLocator;
  List<FeatureModel> features = [
    FeatureModel(
      title: 'Open App Setting',
      desc: 'Open App Setting',
      key: 'OPEN_APP_SETTING',
    ),
    FeatureModel(
      title: 'Open Location Setting',
      desc: 'Open Location Setting',
      key: 'OPEN_LOCATION_SETTING',
    ),
    FeatureModel(
      title: 'Check Permission',
      desc: 'Check Permission',
      key: 'CHECK_PERMISSION',
    ),
    FeatureModel(
      title: 'Request Permission',
      desc: 'Request Permission',
      key: 'REQUEST_PERMISSION',
    ),
    FeatureModel(
      title: 'Last Known Location',
      desc: 'Last Known Location',
      key: 'LAST_KNOWN_LOCATION',
    ),
    FeatureModel(
      title: 'Current Position',
      desc: 'Current Position',
      key: 'CURRENT_POSITION',
    ),
    FeatureModel(
      title: 'Distance Between Two Location',
      desc: 'Distance Between Two Location',
      key: 'DISTANCE_BETWEEN_TWO_LOCATION',
    ),
    FeatureModel(
      title: 'Is Fake Location',
      desc: 'Is Fake Location',
      key: 'IS_FAKE_LOCATION',
    ),
  ];

  @override
  void initState() {
    super.initState();
    featureGeoLocator = FeatureGeoLocator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: features.length,
        itemBuilder: (_, index) {
          final feature = features[index];
          return GestureDetector(
            onTap: () async {
              switch (feature.key) {
                case "OPEN_APP_SETTING":
                  featureGeoLocator.openAppSetting();
                  break;
                case "OPEN_LOCATION_SETTING":
                  featureGeoLocator.openLocationSettings();
                  break;
                case "CHECK_PERMISSION":
                  final res = await featureGeoLocator.checkPermission();
                  log("permission result: $res");
                  break;
                case "REQUEST_PERMISSION":
                  final res = await featureGeoLocator.requestPermission();
                  log("permission result: $res");
                  break;
                case "LAST_KNOWN_LOCATION":
                  final lastKnownLocation = await featureGeoLocator.getLastKnownLocation();
                  log("last known: ${lastKnownLocation?.longitude} & ${lastKnownLocation?.longitude}");
                  break;
                case "CURRENT_POSITION":
                  final locationSettings = LocationSettings(
                    accuracy: LocationAccuracy.high,
                    timeLimit: Duration(seconds: 60),
                  );
                  final currentPosition = await featureGeoLocator.getCurrentPosition(locationSettings: locationSettings);
                  log("current position: ${currentPosition.latitude} & ${currentPosition.longitude}");
                  break;
                case "DISTANCE_BETWEEN_TWO_LOCATION":
                  final distance = featureGeoLocator.distanceBetween(startLatitude: -6.1719, startLongitude: 106.8229, endLatitude: -6.373102, endLongitude: 106.834625);
                  log("distance: $distance");
                  break;
                case "IS_FAKE_LOCATION":
                  final isFakeLocation = featureGeoLocator.isFakeLocation();
                  log("isFakeLocation: $isFakeLocation");
                  break;
              }
            },
            child: ItemFeatureWidget(feature: feature),
          );
        },
      ),
    );
  }
}
