# Description

Flutter package to handle [OpenStreetMap](https://www.openstreetmap.org)

## Key Features

### Map Controller

Controller to handle map view (zoomIn, zoomOut, addMarker, removeMarker, etc).

| Key - FeatureMapController | Desc                                                |
|----------------------------|-----------------------------------------------------|
| initMapCoordinate          | Coordinate map to display to user.                  |
| markersCoordinate          | List of marker coordinate to tag position in a map. |
| zoomOption                 | Zoom configuration setting related to map view.     |


### Display Map

Display MAP from OpenStreetMap

```dart
final controller = FeatureMapController(
  initMapCoordinate: FeatureLocationCoordinate(latitude: -6.1719, longitude: 106.8229),
  markersCoordinate: [
    FeatureMarkerCoordinate(
      id: 'id-marker-1',
      latitude: -6.1719,
      longitude: 106.8229,
    )
  ],
  zoomOption: FeatureZoomOption(
    stepZoom: 1.0,
    maxZoomLevel: 19.0,
    minZoomLevel: 2.0,
    initZoom: 16.0,
  ),
);

Widget mapView(){
  return FeatureOSMMapView(controller: controller);
}
```

### Add Marker

Add marker to existing Map Controller

```dart
Future<void> screenFunction() async {
  controller.addMarker(
    coordinates: [
      FeatureMarkerCoordinate(id: 'id-marker-2', latitude: -6.373102, longitude: 106.834625),
    ],
  );
}
```

### Move Marker

Move marker based on existing id marker in a controller.

```dart
Future<void> screenFunction() async {
  controller.moveMarker('id-marker-1',
      coordinate: FeatureLocationCoordinate(latitude: -6.1719, longitude: 106.8229));
}
```

### Remove Marker

Remove marker based on existing id

```dart
Future<void> screenFunction() async {
  controller.removeMarker(
    idsMarker: [
      'id-marker-2',
    ],
  );
}
```

### Zoom In & Zoom Out

Zoom in & Zoom out

```dart
Future<void> screenFunction() async {
  controller.zoomIn();
}
```

```dart
Future<void> screenFunction() async {
  controller.zoomOut();
}
```

### Move Map

Move existing map to the specific latitude & longitude

```dart
Future<void> screenFunction() async {
  controller.moveToPosition(FeatureLocationCoordinate(latitude: -6.1719, longitude: 106.8229));
}
```
