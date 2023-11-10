// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:math' hide log;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/map_information.dart';
import 'package:cotwcompanion/activities/map_layers.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/projection.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/map_zone.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/menubar.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';

class ActivityMap extends StatefulWidget {
  final int reserveId;

  const ActivityMap({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  ActivityMapState createState() => ActivityMapState();
}

class ActivityMapState extends State<ActivityMap> {
  final MapController _mapController = MapController(location: const LatLng(0, 0), zoom: 1, projection: const MapProjection());
  final List<Widget> _outpostLocations = [];
  final List<Widget> _lookoutLocations = [];
  final List<Widget> _hideLocations = [];
  final List<Widget> _zoneLocations = [];
  final double _menuHeight = 75;
  final double _zoomSpeed = 0.02;
  final double _minZoom = 1;
  final double _maxZoom = 3;
  final int _minRowTiles = 4;
  final int _recommendedNumberOfZones = 100;

  late final Reserve _reserve;
  late final Settings _settings;

  late MapTransformer _mapTransformer;
  late double _tileSize;

  Offset? _dragStart;
  double _scaleStart = 1.0;
  double _centerLatEnd = const LatLng(0, 0).latitude;
  double _centerLngEnd = const LatLng(0, 0).longitude;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _distanceThreshold = 0.3;
  double _dotSize = 5;
  double _circleSize = 200;
  double _opacity = 1;
  int _level = 1;
  bool _showInterface = true;

  @override
  void initState() {
    _reserve = HelperJSON.getReserve(widget.reserveId);
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  void _reload() {
    setState(() {
      _updateMap();
    });
  }

  void _getScreenSize() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  void _getTileSize(Orientation orientation) {
    _tileSize = (orientation == Orientation.portrait ? _screenHeight : _screenWidth) / _minRowTiles;
  }

  double _clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;
    return x;
  }

  void _values(double zoom) {
    if (zoom >= 1) {
      _level = 1;
      _dotSize = 5;
      _circleSize = 200;
      _distanceThreshold = 0.3;
    }
    if (zoom > 1.666) {
      _level = 2;
      _dotSize = 7.5;
      _circleSize = 100;
      _distanceThreshold = 0.1;
    }
    if (zoom > 2.333) {
      _level = 3;
      _dotSize = 10;
      _circleSize = 0;
      _distanceThreshold = 0;
    }
  }

  bool _inView(double left, double top, double right, double bottom) {
    if ((right >= 0 && left <= _screenWidth) && (bottom >= 0 && top <= _screenHeight)) return true;
    return false;
  }

  void _updateZoneStyle() {
    setState(() {
      _settings.changeMapZonesStyle();
      _clearZoneLocations();
      _updateZoneLocations();
    });
  }

  void _updateZoneType() {
    setState(() {
      _settings.changeMapZonesType();
      _clearZoneLocations();
      _updateZoneLocations();
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    setState(() {
      _clearLocations();
      _clearZoneLocations();
    });
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleEnd() {
    setState(() {
      _updateLocations();
      _updateZoneLocations();
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;
    _values(_mapController.zoom);

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

    //LEFT BORDER
    if (_mapTransformer.toOffset(LatLng(_mapController.center.latitude, -360)).dx > 0) {
      double y = _centerLngEnd + (-360 - _mapTransformer.toLatLng(const Offset(0, 0)).longitude);
      y = y > 0 ? 0 : y;
      _mapController.center = LatLng(_mapController.center.latitude, y);
    }

    //RIGHT BORDER
    if (_mapTransformer.toOffset(LatLng(_mapController.center.latitude, 360)).dx < _screenWidth) {
      double y = _centerLngEnd + (360 - _mapTransformer.toLatLng(Offset(_screenWidth, 0)).longitude);
      y = y < 0 ? 0 : y;
      _mapController.center = LatLng(_mapController.center.latitude, y);
    }

    //TOP BORDER
    if (_mapTransformer.toOffset(LatLng(-360, _mapController.center.longitude)).dy > 0) {
      double x = _centerLatEnd + (-360 - _mapTransformer.toLatLng(const Offset(0, 0)).latitude);
      x = x > 0 ? 0 : x;
      _mapController.center = LatLng(x, _mapController.center.longitude);
    }

    //BOTTOM BORDER
    if (_mapTransformer.toOffset(LatLng(360, _mapController.center.longitude)).dy < _screenHeight) {
      double x = _centerLatEnd + (360 - _mapTransformer.toLatLng(Offset(0, _screenHeight)).latitude);
      x = x < 0 ? 0 : x;
      _mapController.center = LatLng(x, _mapController.center.longitude);
    }

    _centerLatEnd = _mapController.center.latitude;
    _centerLngEnd = _mapController.center.longitude;
  }

  Future<void> _updateMap() async {
    _clearLocations();
    await _updateLocations();
    _clearZoneLocations();
    await _updateZoneLocations();
  }

  void _clearLocations() {
    _outpostLocations.clear();
    _lookoutLocations.clear();
    _hideLocations.clear();
  }

  void _clearZoneLocations() {
    _zoneLocations.clear();
  }

  Future<void> _updateLocations() async {
    _outpostLocations.addAll(await _buildObjectMarkers(HelperMap.outposts, 15, MapItem.outpost));
    _lookoutLocations.addAll(await _buildObjectMarkers(HelperMap.lookouts, 15, MapItem.lookout));
    _hideLocations.addAll(await _buildObjectMarkers(HelperMap.hides, 3, MapItem.hide));
  }

  Future<void> _updateZoneLocations() async {
    for (int index = 0; index < HelperMap.animals.length; index++) {
      _zoneLocations.addAll(await _buildZones(index));
    }
  }

  Widget _buildMap(Orientation orientation) {
    return MapLayout(
        tileSize: _tileSize.toInt() + 1,
        controller: _mapController,
        builder: (context, transformer) {
          _mapTransformer = transformer;
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: (details) => _onScaleStart(details),
              onScaleUpdate: (details) => _onScaleUpdate(details),
              onScaleEnd: (details) => _onScaleEnd(),
              child: Stack(children: [
                TileLayer(builder: (context, x, y, z) {
                  if ((z == 1 && (x >= -1 && y >= -1 && x <= 2 && y <= 2)) ||
                      (z == 2 && (x >= -2 && y >= -2 && x <= 5 && y <= 5)) ||
                      (z == 3 && (x >= -4 && y >= -4 && x <= 11 && y <= 11))) {
                    return Image.asset(
                      Graphics.getMapTile(widget.reserveId, x, y, z),
                      fit: BoxFit.fitWidth,
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Container(color: Interface.alwaysDark.withOpacity(0.5)),
                ..._outpostLocations,
                ..._lookoutLocations,
                ..._hideLocations,
                ..._zoneLocations,
              ]));
        });
  }

  Widget _buildObjectMarker(Offset offset, String icon, double markerSize, MapItem objectType) {
    double size = markerSize + (_mapController.zoom * 5);
    double left = offset.dx - (size / 2);
    double right = offset.dx + (size / 2);
    double top = offset.dy - (size / 2);
    double bottom = offset.dy + (size / 2);
    markerSize + (_mapController.zoom * 5);
    if (_inView(left, top, right, bottom)) {
      return Positioned(
          width: size,
          height: size,
          left: left,
          top: top,
          child: objectType == MapItem.hide && _level == 1
              ? const SizedBox.shrink()
              : Image.asset(
                  icon,
                  fit: BoxFit.fitWidth,
                  color: Interface.alwaysLight,
                ));
    }
    return const SizedBox.shrink();
  }

  Future<List<Widget>> _buildObjectMarkers(List<LatLng> list, double iconSize, MapItem objectType) async {
    String icon = Graphics.getMapObjectIcon(objectType, _level);
    if (HelperMap.isActiveE(objectType.index)) {
      final positions = list.map(_mapTransformer.toOffset).toList();
      return positions.map((offset) => _buildObjectMarker(offset, icon, iconSize, objectType)).toList();
    }
    return [];
  }

  Future<Iterable<Widget>> _buildZones(int index) async {
    if (HelperMap.isActive(index)) {
      Animal animal = HelperMap.animals[index];
      return _buildZoneMarkers(HelperMap.getAnimalZones(animal.id), index);
    } else {
      return [];
    }
  }

  List<MapObject> _clusterObjects(List<MapObject> objects) {
    final List<List<MapObject>> clusters = [];
    final Set<MapObject> usedPositions = {};
    for (int i = 0; i < objects.length; i++) {
      if (usedPositions.contains(objects[i])) {
        continue;
      }
      final List<MapObject> cluster = [objects[i]];
      for (int j = 0; j < objects.length; j++) {
        if (usedPositions.contains(objects[j])) {
          continue;
        }
        final double distance = sqrt(pow(objects[i].x - objects[j].x, 2) + pow(objects[i].y - objects[j].y, 2));
        if (distance < _distanceThreshold) {
          cluster.add(objects[j]);
          usedPositions.add(objects[j]);
        }
      }
      clusters.add(cluster);
    }

    final List<MapObject> clusteredPositions = clusters.map((cluster) {
      final double x = cluster.map((position) => position.x).reduce((a, b) => a + b) / cluster.length;
      final double y = cluster.map((position) => position.y).reduce((a, b) => a + b) / cluster.length;
      final int zone = cluster.first.zone;
      return MapObject(x: x, y: y, zone: zone);
    }).toList();

    return clusteredPositions;
  }

  Future<Iterable<Widget>> _buildZoneMarkers(List<MapObject> objects, int index) async {
    List<MapObject> clusteredObjects = _settings.mapPerformanceMode ? _clusterObjects(objects) : objects;
    return clusteredObjects.map((object) {
      Offset offset = _mapTransformer.toOffset(object.coord);
      Color color = HelperMap.getColor(index);
      bool condition = (!_settings.mapPerformanceMode || _level == 3) && _settings.mapZonesType && object.zone != 3;
      if (condition) color = Zone.colorForZone(object.zone);
      return _buildZoneMarker(offset, color, index);
    });
  }

  Widget _buildZoneMarker(Offset offset, Color color, int index) {
    bool condition = _settings.mapPerformanceMode && _settings.mapZonesStyle && _level != 3;

    double mx = 0;
    double my = 0;

    if (!_settings.mapZonesType && (!_settings.mapPerformanceMode || _level == 3)) {
      mx = cos(((360 / HelperMap.animals.length) / HelperMap.animals.length) * index) * (7);
      my = sin(((360 / HelperMap.animals.length) / HelperMap.animals.length) * index) * (7);
    }

    double size = condition ? _circleSize : _dotSize;
    double left = offset.dx - (size / 2) + mx;
    double right = offset.dx + (size / 2) - mx;
    double top = offset.dy - (size / 2) + my;
    double bottom = offset.dy + (size / 2) - my;

    if (_inView(left, top, right, bottom)) {
      if (condition) {
        return Positioned(
            width: _circleSize,
            height: _circleSize,
            left: left,
            top: top,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.5),
                borderRadius: BorderRadius.circular(_circleSize),
              ),
            ));
      } else {
        return Positioned(
            width: _dotSize,
            height: _dotSize,
            left: left,
            top: top,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ));
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildAnimalList() {
    List<Widget> widgets = [];
    for (int i = 0; i < HelperMap.names.length; i++) {
      if (HelperMap.isActive(i)) {
        String name = HelperMap.names[i];
        int foundZones = HelperMap.getAnimalZones(HelperMap.getAnimal(i).id).length;
        int perCent = ((foundZones * 100) / _recommendedNumberOfZones).round();
        perCent = perCent > 100 ? 100 : perCent;
        widgets.add(
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _settings.mapZonesAccuracy
                  ? Container(
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 5),
                      child: AutoSizeText(
                        "$perCent%",
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: Interface.s12w300n(HelperMap.getColor(i)),
                      ))
                  : const SizedBox.shrink(),
              Expanded(
                  child: AutoSizeText(
                name,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: Interface.s12w300n(HelperMap.getColor(i)),
              ))
            ],
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildList(Orientation orientation) {
    return _showInterface
        ? orientation == Orientation.portrait
            ? Positioned(
                left: 0,
                top: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: _screenWidth,
                      color: Interface.alwaysDark.withOpacity(0.3),
                      padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                      child: _buildAnimalList(),
                    )))
            : Positioned(
                left: 0,
                top: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      height: _screenHeight,
                      color: Interface.alwaysDark.withOpacity(0.3),
                      padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                      child: _buildAnimalList(),
                    )))
        : const SizedBox.shrink();
  }

  Widget _buildMenu(Orientation orientation) {
    return _showInterface
        ? AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 200),
            child: WidgetMenuBar(
              width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height,
              height: _menuHeight,
              items: [
                EntryMenuBarItem(
                  barButton: WidgetButtonIcon(
                      icon: "assets/graphics/icons/back.svg",
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                EntryMenuBarItem(
                  barButton: WidgetButtonIcon(
                      icon: "assets/graphics/icons/about.svg",
                      color: Interface.alwaysDark,
                      background: Interface.alwaysLight,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityMapInformation()));
                      }),
                ),
                EntryMenuBarItem(
                  barButton: WidgetSwitchIcon(
                    icon: "assets/graphics/icons/zone_feed.svg",
                    color: Interface.alwaysDark,
                    background: Interface.alwaysLight,
                    isActive: _settings.mapZonesType,
                    disabled: _settings.mapPerformanceMode && _level != 3,
                    onTap: _updateZoneType,
                  ),
                ),
                EntryMenuBarItem(
                  barButton: WidgetSwitchIcon(
                    icon: "assets/graphics/icons/other.svg",
                    color: Interface.alwaysDark,
                    background: Interface.alwaysLight,
                    isActive: _settings.mapZonesStyle,
                    disabled: !_settings.mapPerformanceMode || _level == 3,
                    onTap: _updateZoneStyle,
                  ),
                ),
                EntryMenuBarItem(
                  barButton: WidgetButtonIcon(
                      icon: "assets/graphics/icons/menu_open.svg",
                      color: Interface.alwaysDark,
                      background: Interface.alwaysLight,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityMapLayers(name: _reserve.en, callback: _reload)));
                      }),
                )
              ],
            ))
        : const SizedBox.shrink();
  }

  Widget _buildStack() {
    return OrientationBuilder(builder: (context, orientation) {
      _getTileSize(orientation);
      return Container(
        color: Interface.alwaysDark,
        child: GestureDetector(
            onLongPress: () {
              if (_opacity == 1) {
                _opacity = 0;
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    _showInterface = false;
                  });
                });
              } else if (_opacity == 0) {
                _showInterface = true;
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    _opacity = 1;
                  });
                });
              }
              setState(() {});
            },
            child: Stack(children: [
              _buildMap(orientation),
              _buildList(orientation),
              Positioned(
                right: 0,
                bottom: 0,
                child: _buildMenu(orientation),
              )
            ])),
      );
    });
  }

  Widget _buildWidgets() {
    _getScreenSize();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Interface.alwaysDark,
      ),
      body: _buildStack(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
