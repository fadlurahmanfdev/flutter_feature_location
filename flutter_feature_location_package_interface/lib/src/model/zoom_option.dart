import 'dart:convert';

class FeatureZoomOption {
  const FeatureZoomOption({
    this.stepZoom = 1.0,
    this.initZoom = 10.0,
    this.minZoomLevel = 2.0,
    this.maxZoomLevel = 19.0,
  })  : assert(maxZoomLevel <= 19),
        assert(minZoomLevel >= 2),
        assert(initZoom >= minZoomLevel || initZoom <= maxZoomLevel);

  /// the default step zoom of map when zoomIn or zoomOut (default = 1)
  final double stepZoom;

  /// the initialized zoom in when initializing the map  (default = 2)
  final double initZoom;

  /// the minimum zoom level of the osm map
  final double minZoomLevel;

  /// the maximum zoom level of the osm map
  final double maxZoomLevel;

  Map<String, double> toJson() => {
        "stepZoom": stepZoom,
        "initZoom": initZoom,
        "minZoom": minZoomLevel,
        "maxZoom": maxZoomLevel,
      };

  FeatureZoomOption copyWith({
    double? stepZoom,
double? initZoom,
double? minZoomLevel,
double? maxZoomLevel,
}){
    return FeatureZoomOption(
      stepZoom: stepZoom ?? this.stepZoom,
      initZoom: initZoom ?? this.initZoom,
      minZoomLevel: minZoomLevel ?? this.minZoomLevel,
      maxZoomLevel: maxZoomLevel ?? this.maxZoomLevel,
    );
  }

  String serialize() => json.encode(toJson());
}
