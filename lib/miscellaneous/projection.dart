import 'package:latlng/latlng.dart';

class MapProjection extends Projection {
  const MapProjection();

  @override
  LatLng toLatLng(TileIndex tile) {
    final x = tile.x;
    final y = tile.y;

    final xx = x - 0.5;
    final yy = y - 0.5;

    final lat = 360.0 * yy;
    final lng = 360.0 * xx;

    return LatLng.degree(lat, lng);
  }

  @override
  TileIndex toTileIndex(LatLng location) {
    final lng = location.longitude;
    final lat = location.latitude;

    double x = (lng.degrees + 180.0) / 360.0;
    double y = (lat.degrees + 180.0) / 360.0;

    return TileIndex(x, y);
  }
}
