import 'package:cotwcompanion/model/map/map_location.dart';

class MapZone extends MapLocation {
  final int _zone;

  MapZone({
    required super.x,
    required super.y,
    required int zone,
  }) : _zone = zone;

  int get zone => _zone;
}
