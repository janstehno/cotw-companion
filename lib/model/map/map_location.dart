import 'package:latlng/latlng.dart';

class MapLocation {
  final double _x;
  final double _y;

  MapLocation({
    required double x,
    required double y,
  })  : _x = x,
        _y = y;

  double get x => _x;

  double get y => _y;

  LatLng get coordination => toLatLng(_x, _y);

  static LatLng toLatLng(double x, double y) => LatLng.degree((y * 720) - 360, (x * 720) - 360);
}
