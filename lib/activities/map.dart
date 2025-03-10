import 'dart:math' hide log;

import 'package:cotwcompanion/helpers/map.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/map/map_animals.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/projection.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/map/map_location.dart';
import 'package:cotwcompanion/model/map/map_zone.dart';
import 'package:cotwcompanion/widgets/map/map_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';

class ActivityMap extends StatefulWidget {
  final HelperMap _helperMap;

  const ActivityMap({
    super.key,
    required HelperMap helperMap,
  }) : _helperMap = helperMap;

  HelperMap get helperMap => _helperMap;

  @override
  ActivityMapState createState() => ActivityMapState();
}

class ActivityMapState extends State<ActivityMap> {
  final double _minZoom = 1;
  final double _maxZoom = 3;
  final double _zoomSpeed = 0.02;
  final MapController _mapController = MapController(
    zoom: 1,
    location: LatLng.degree(0, 0),
    projection: const MapProjection(),
  );

  final Map<int, Set<MapZone>?> _zones = {};
  final Map<String, Set<MapLocation>?> _locations = {};

  late MapTransformer _mapTransformer;
  late double _tileSize;

  Settings get _settings => Provider.of<Settings>(context, listen: false);

  Offset? _dragStart;
  double _scaleStart = 1.0;
  double _centerLatEnd = LatLng.degree(0, 0).latitude.degrees;
  double _centerLngEnd = LatLng.degree(0, 0).longitude.degrees;
  double _distanceThreshold = 0.3;

  double _dotSize = 5;
  double _circleSize = 200;

  int _level = 1;

  bool _render = true;
  bool _showInterface = true;

  @override
  void reassemble() {
    widget.helperMap.resetActive();
    super.reassemble();
  }

  void _onLongPress() {
    setState(() {
      _showInterface = !_showInterface;
    });
  }

  void _updateValues(double zoom) {
    if (zoom >= 1) {
      _level = 1;
      _dotSize = 5;
      _circleSize = 200;
      _distanceThreshold = 0.3;
      _updateMap();
    }
    if (zoom > 1.666) {
      _level = 2;
      _dotSize = 7.5;
      _circleSize = 150;
      _distanceThreshold = 0.2;
      _updateMap();
    }
    if (zoom > 2.333) {
      _level = 3;
      _dotSize = 10;
      _circleSize = 0;
      _distanceThreshold = 0;
      _updateMap();
    }
  }

  void _updateMap() {
    setState(() {
      _getLocations();
      _getClusteredObjects();
    });
  }

  void _getTileSize(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _tileSize = MediaQuery.of(context).size.height / 4;
    } else {
      _tileSize = MediaQuery.of(context).size.width / 4;
    }
  }

  double _clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;
    return x;
  }

  bool _inView(double left, double top, double right, double bottom) {
    if ((right >= 0 && left <= MediaQuery.of(context).size.width) &&
        (bottom >= 0 && top <= MediaQuery.of(context).size.height)) {
      return true;
    }
    return false;
  }

  void _onScaleStart(ScaleStartDetails details) {
    setState(() {
      _render = false;
      _dragStart = details.focalPoint;
      _scaleStart = 1.0;
    });
  }

  void _onScaleEnd() {
    setState(() {
      _render = true;
      _updateValues(_mapController.zoom);
    });
  }

  void _onScaleMove(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      setState(() {
        _mapController.zoom = _clamp(_mapController.zoom + _zoomSpeed, _minZoom, _maxZoom);
      });
    } else if (scaleDiff < 0) {
      setState(() {
        _mapController.zoom = _clamp(_mapController.zoom - _zoomSpeed, _minZoom, _maxZoom);
      });
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      setState(() {
        _dragStart = now;
        _mapTransformer.drag(diff.dx, diff.dy);
      });
    }
  }

  void _onScaleBorder() {
    if (_mapTransformer.toOffset(LatLng.degree(_mapController.center.latitude.degrees, -360)).dx > 0) {
      double y = _centerLngEnd + (-360 - _mapTransformer.toLatLng(const Offset(0, 0)).longitude.degrees);
      y = y > 0 ? 0 : y;
      _mapController.center = LatLng.degree(_mapController.center.latitude.degrees, y);
    }
    if (_mapTransformer.toOffset(LatLng.degree(_mapController.center.latitude.degrees, 360)).dx <
        MediaQuery.of(context).size.width) {
      double y = _centerLngEnd +
          (360 - _mapTransformer.toLatLng(Offset(MediaQuery.of(context).size.width, 0)).longitude.degrees);
      y = y < 0 ? 0 : y;
      _mapController.center = LatLng.degree(_mapController.center.latitude.degrees, y);
    }
    if (_mapTransformer.toOffset(LatLng.degree(-360, _mapController.center.longitude.degrees)).dy > 0) {
      double x = _centerLatEnd + (-360 - _mapTransformer.toLatLng(const Offset(0, 0)).latitude.degrees);
      x = x > 0 ? 0 : x;
      _mapController.center = LatLng.degree(x, _mapController.center.longitude.degrees);
    }
    if (_mapTransformer.toOffset(LatLng.degree(360, _mapController.center.longitude.degrees)).dy <
        MediaQuery.of(context).size.height) {
      double x = _centerLatEnd +
          (360 - _mapTransformer.toLatLng(Offset(0, MediaQuery.of(context).size.height)).latitude.degrees);
      x = x < 0 ? 0 : x;
      _mapController.center = LatLng.degree(x, _mapController.center.longitude.degrees);
    }
    _centerLatEnd = _mapController.center.latitude.degrees;
    _centerLngEnd = _mapController.center.longitude.degrees;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    _onScaleMove(details);
    _onScaleBorder();
  }

  TileLayer _buildTileLayer() {
    return TileLayer(builder: (context, x, y, z) {
      if ((z == 1 && (x >= -1 && y >= -1 && x <= 2 && y <= 2)) ||
          (z == 2 && (x >= -2 && y >= -2 && x <= 5 && y <= 5)) ||
          (z == 3 && (x >= -4 && y >= -4 && x <= 11 && y <= 11))) {
        return Image.asset(
          Graphics.getTile(widget.helperMap.reserve, x, y, z),
          fit: BoxFit.fitWidth,
        );
      }
      return const SizedBox.shrink();
    });
  }

  Set<Widget> _listHides() {
    if (_render && _locations["2"] != null) {
      return _locations["2"]!.map((e) => _buildLocation(e, 3, MapLocationType.hide)).toSet();
    }
    return {};
  }

  Set<Widget> _listLookouts() {
    if (_render && _locations["1"] != null) {
      return _locations["1"]!.map((e) => _buildLocation(e, 15, MapLocationType.lookout)).toSet();
    }
    return {};
  }

  Set<Widget> _listOutposts() {
    if (_render && _locations["0"] != null) {
      return _locations["0"]!.map((e) => _buildLocation(e, 15, MapLocationType.outpost)).toSet();
    }
    return {};
  }

  List<Widget> _listZones() {
    if (_render && _zones.isNotEmpty) {
      return _zones.entries.expand((entry) {
        int key = entry.key;
        Set<MapZone>? zones = entry.value;
        return zones!.map((e) => _buildZone(e, key));
      }).toList();
    }
    return [];
  }

  Widget _buildMap(Orientation orientation) {
    _getTileSize(orientation);
    return MapLayout(
      tileSize: _tileSize.toInt() + 1,
      controller: _mapController,
      builder: (context, transformer) {
        _mapTransformer = transformer;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onScaleStart: (e) => _onScaleStart(e),
          onScaleUpdate: (e) => _onScaleUpdate(e),
          onScaleEnd: (e) => _onScaleEnd(),
          child: Stack(
            children: [
              _buildTileLayer(),
              Container(color: Interface.alwaysDark.withValues(alpha: 0.4)),
              ..._listHides(),
              ..._listLookouts(),
              ..._listOutposts(),
              ..._listZones(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationIcon(MapLocationType mapLocationType) {
    if (mapLocationType == MapLocationType.hide && _level == 1) return const SizedBox.shrink();
    return SvgPicture.asset(
      Graphics.getMapObjectIcon(mapLocationType),
      fit: BoxFit.fitWidth,
      colorFilter: const ColorFilter.mode(
        Interface.alwaysLight,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildLocation(MapLocation location, double initialSize, MapLocationType mapLocationType) {
    Offset offset = _mapTransformer.toOffset(location.coordination);
    double size = initialSize + (_mapController.zoom * 5);
    double left = offset.dx - (size / 2);
    double right = offset.dx + (size / 2);
    double top = offset.dy - (size / 2);
    double bottom = offset.dy + (size / 2);
    if (_inView(left, top, right, bottom)) {
      return Positioned(
        width: size,
        height: size,
        left: left,
        top: top,
        child: _buildLocationIcon(mapLocationType),
      );
    }
    return const SizedBox.shrink();
  }

  BoxDecoration _zoneBoxDecoration(Color color, double size) {
    if (widget.helperMap.showZoneStyle(_settings, _level)) {
      return BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(size),
      );
    }
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(size),
    );
  }

  Widget _buildZone(MapZone location, int key) {
    Offset offset = _mapTransformer.toOffset(location.coordination);
    int i = widget.helperMap.zonesKeys(context).indexOf(key);

    double mx = 0;
    double my = 0;

    if (!widget.helperMap.showZoneStyle(_settings, _level) && !widget.helperMap.showZoneType(_settings, _level)) {
      mx = cos(((360 / widget.helperMap.zones.length) / widget.helperMap.zones.length) * i) * (7);
      my = sin(((360 / widget.helperMap.zones.length) / widget.helperMap.zones.length) * i) * (7);
    }

    double size = widget.helperMap.showZoneStyle(_settings, _level) ? _circleSize : _dotSize;
    double left = offset.dx - (size / 2) + mx;
    double right = offset.dx + (size / 2) - mx;
    double top = offset.dy - (size / 2) + my;
    double bottom = offset.dy + (size / 2) - my;

    if (_inView(left, top, right, bottom)) {
      Color color =
          widget.helperMap.showZoneType(_settings, _level) && !widget.helperMap.showZoneStyle(_settings, _level)
              ? AnimalZone.colorFor(location.zone)
              : widget.helperMap.getAnimalColor(i);
      return Positioned(
        width: size,
        height: size,
        left: left,
        top: top,
        child: Container(decoration: _zoneBoxDecoration(color, size)),
      );
    }
    return const SizedBox.shrink();
  }

  void _getLocations() {
    _locations.clear();
    if (widget.helperMap.isEnvironmentActive(MapLocationType.outpost)) {
      _locations.putIfAbsent("0", () => widget.helperMap.outposts.toSet());
    }
    if (widget.helperMap.isEnvironmentActive(MapLocationType.lookout)) {
      _locations.putIfAbsent("1", () => widget.helperMap.lookouts.toSet());
    }
    if (widget.helperMap.isEnvironmentActive(MapLocationType.hide)) {
      _locations.putIfAbsent("2", () => widget.helperMap.hides.toSet());
    }
  }

  void _getClusteredObjects() {
    _zones.clear();
    widget.helperMap.zonesKeys(context).map((e) {
      if (widget.helperMap.isAnimalActive(widget.helperMap.zonesKeys(context).indexOf(e))) {
        Set<MapZone>? animalZones = widget.helperMap.zones[e];
        Set<MapZone>? clusteredZones =
            widget.helperMap.showClustered(_settings, _level) ? _clusterObjects(animalZones) : animalZones;
        _zones.putIfAbsent(e, () => clusteredZones);
      }
    }).toSet();
  }

  Set<MapZone> _clusterObjects(Set<MapZone>? animalZones) {
    final Set<Set<MapZone>> clusters = {};
    final Set<MapZone> usedPositions = {};

    if (animalZones != null) {
      for (MapZone e in animalZones) {
        if (!usedPositions.contains(e)) {
          final Set<MapZone> cluster = {}..add(e);
          for (MapZone f in animalZones) {
            if (!usedPositions.contains(f)) {
              final double distance = sqrt(pow(e.x - f.x, 2) + pow(e.y - f.y, 2));
              if (distance < _distanceThreshold) {
                cluster.add(f);
                usedPositions.add(f);
              }
            }
          }
          clusters.add(cluster);
        }
      }
    }
    final Set<MapZone> clusteredPositions = clusters.map((e) {
      final double x = e.map((f) => f.x).reduce((a, b) => a + b) / e.length;
      final double y = e.map((f) => f.y).reduce((a, b) => a + b) / e.length;
      final int zone = e.first.zone;
      return MapZone(x: x, y: y, zone: zone);
    }).toSet();

    return clusteredPositions;
  }

  Widget _buildAnimalList() {
    return ListMapAnimals(
      helperMap: widget.helperMap,
      zones: _zones,
      showInterface: _showInterface,
    );
  }

  Widget _buildMenu() {
    return WidgetMapMenuBar(
      helperMap: widget.helperMap,
      level: _level,
      showInterface: _showInterface,
      onChange: _updateMap,
    );
  }

  Widget _buildStack() {
    Orientation orientation = MediaQuery.orientationOf(context);
    return Stack(
      children: [
        _buildMap(orientation),
        Positioned(left: 0, top: 0, child: _buildAnimalList()),
        Positioned(right: 0, bottom: 0, child: _buildMenu()),
      ],
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onLongPress: () => _onLongPress(),
        child: _buildStack(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
