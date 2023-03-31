// Copyright (c) 2022 Jan Stehno

import 'package:latlng/latlng.dart';

class MapObject {
  final double _x, _y;
  final int _zone;

  MapObject({
    required x,
    required y,
    required zone,
  })  : _x = x,
        _y = y,
        _zone = zone;

  double get x => _x;

  double get y => _y;

  int get zone => _zone;

  LatLng get coord => toLatLng(_x, _y);

  static LatLng toLatLng(double x, double y) => LatLng((y * 720) - 360, (x * 720) - 360);
}
