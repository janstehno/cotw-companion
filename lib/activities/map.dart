// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/map_information.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/projection.dart';
import 'package:cotwcompanion/activities/map_layers.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/map_zone.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';
import 'package:cotwcompanion/model/zone.dart';

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
  final double _zoomSpeed = 0.02;
  final double _minZoom = 1;
  final double _maxZoom = 3;
  final int _minRowTiles = 4;
  final int _recommendedNumber = 100;

  late final Reserve _reserve;
  late final Settings _settings;

  late double _tileSize;

  Offset? _dragStart;
  double _scaleStart = 1.0;
  double _centerLatEnd = const LatLng(0, 0).latitude;
  double _centerLngEnd = const LatLng(0, 0).longitude;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _circle = 200;
  double _circleBorder = 2;
  int _level = 1;
  double _opacity = 1;
  bool _showInterface = true;

  @override
  void initState() {
    _reserve = HelperJSON.getReserve(widget.reserveId);
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  void _reload() {
    setState(() {});
  }

  void _getScreenSize() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
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
      _circle = 200;
      _circleBorder = 2;
    }
    if (zoom > 1.667) {
      _level = 2;
      _circle = 150;
      _circleBorder = 3;
    }
    if (zoom > 2.334) {
      _level = 3;
      _circle = 10;
      _circleBorder = 5;
    }
  }

  bool _inView(double left, double top, double right, double bottom) {
    if ((right >= 0 && left <= _screenWidth) && (bottom >= 0 && top <= _screenHeight)) return true;
    return false;
  }

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;
    _values(_mapController.zoom);

    if (scaleDiff > 0) {
      _mapController.zoom = _clamp(_mapController.zoom + _zoomSpeed, _minZoom, _maxZoom);
      setState(() {});
    } else if (scaleDiff < 0) {
      _mapController.zoom = _clamp(_mapController.zoom - _zoomSpeed, _minZoom, _maxZoom);
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }

    //LEFT BORDER
    if (transformer.toOffset(LatLng(_mapController.center.latitude, -360)).dx > 0) {
      double y = _centerLngEnd + (-360 - transformer.toLatLng(const Offset(0, 0)).longitude);
      y = y > 0 ? 0 : y;
      _mapController.center = LatLng(_mapController.center.latitude, y);
    }

    //RIGHT BORDER
    if (transformer.toOffset(LatLng(_mapController.center.latitude, 360)).dx < _screenWidth) {
      double y = _centerLngEnd + (360 - transformer.toLatLng(Offset(_screenWidth, 0)).longitude);
      y = y < 0 ? 0 : y;
      _mapController.center = LatLng(_mapController.center.latitude, y);
    }

    //TOP BORDER
    if (transformer.toOffset(LatLng(-360, _mapController.center.longitude)).dy > 0) {
      double x = _centerLatEnd + (-360 - transformer.toLatLng(const Offset(0, 0)).latitude);
      x = x > 0 ? 0 : x;
      _mapController.center = LatLng(x, _mapController.center.longitude);
    }

    //BOTTOM BORDER
    if (transformer.toOffset(LatLng(360, _mapController.center.longitude)).dy < _screenHeight) {
      double x = _centerLatEnd + (360 - transformer.toLatLng(Offset(0, _screenHeight)).latitude);
      x = x < 0 ? 0 : x;
      _mapController.center = LatLng(x, _mapController.center.longitude);
    }

    _centerLatEnd = _mapController.center.latitude;
    _centerLngEnd = _mapController.center.longitude;
  }

  Widget _buildStack() {
    return OrientationBuilder(builder: (context, orientation) {
      _getTileSize(orientation);
      return Container(
          color: Interface.colorMapBackground,
          child: GestureDetector(
              onLongPress: () {
                if (_opacity == 1) {
                  _opacity = 0;
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _showInterface = false;
                    setState(() {});
                  });
                } else if (_opacity == 0) {
                  _showInterface = true;
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _opacity = 1;
                    setState(() {});
                  });
                }
                setState(() {});
              },
              child: Stack(children: [
                _buildMap(orientation),
                _buildMenu(orientation),
              ])));
    });
  }

  Widget _buildMap(Orientation orientation) {
    return MapLayout(
        tileSize: _tileSize.toInt(),
        controller: _mapController,
        builder: (context, transformer) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _onScaleStart,
              onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
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
                Container(color: Interface.colorMapBackground.withOpacity(0.5)),
                ..._buildObjectMarkers(transformer, HelperMap.getOutposts, Interface.colorMapOLH, 15, MapObjectType.outpost),
                ..._buildObjectMarkers(transformer, HelperMap.getLookouts, Interface.colorMapOLH, 15, MapObjectType.lookout),
                ..._buildObjectMarkers(transformer, HelperMap.getHides, Interface.colorMapOLH, 3, MapObjectType.hide),
                for (int index = 0; index < HelperMap.getAnimals.length; index++) ..._buildZones(transformer, index)
              ]));
        });
  }

  Iterable<Widget> _buildObjectMarkers(MapTransformer transformer, List<LatLng> list, Color color, double iconSize, MapObjectType objectType) {
    String icon = Graphics.getMapObjectIcon(objectType, _level);
    if (HelperMap.isActiveE(objectType.index)) {
      final positions = list.map(transformer.toOffset).toList();
      return positions.map(
        (offset) => _buildObjectMarker(offset, icon, color, iconSize, objectType),
      );
    }
    return [];
  }

  Widget _buildObjectMarker(Offset offset, String icon, Color color, double markerSize, MapObjectType objectType) {
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
          child: objectType == MapObjectType.hide && _level == 1
              ? const SizedBox.shrink()
              : Image.asset(
                  icon,
                  fit: BoxFit.fitWidth,
                  color: color,
                ));
    }
    return const SizedBox.shrink();
  }

  Iterable<Widget> _buildZones(MapTransformer transformer, int index) {
    if (HelperMap.isActive(index)) {
      Animal animal = HelperMap.getAnimals[index];
      return _buildZoneMarkers(transformer, HelperMap.getAnimalZones(animal.id, _level), index);
    } else {
      return [];
    }
  }

  Iterable<Widget> _buildZoneMarkers(MapTransformer transformer, List<MapObject> objects, int index) {
    return objects.map((object) {
      Offset offset = transformer.toOffset(object.coord);
      Color color = HelperMap.getColor(index);
      if (_settings.getMapZonesType && object.zone != 3 && _level == 3) color = Zone.colorForZone(object.zone);
      return _buildZoneMarker(offset, color, index);
    });
  }

  Widget _buildZoneMarker(Offset offset, Color color, int index) {
    double mx = 0;
    double my = 0;
    double size = _settings.getMapZonesStyle ? _circle : 10;
    if (!_settings.getMapZonesType && _level == 3) {
      mx = cos(((360 / HelperMap.getAnimals.length) / HelperMap.getAnimals.length) * index) * (7);
      my = sin(((360 / HelperMap.getAnimals.length) / HelperMap.getAnimals.length) * index) * (7);
    }
    double left = offset.dx - (size / 2) + mx;
    double right = offset.dx + (size / 2) - mx;
    double top = offset.dy - (size / 2) + my;
    double bottom = offset.dy + (size / 2) - my;
    if (_inView(left, top, right, bottom)) {
      if (_settings.getMapZonesStyle) {
        return Positioned(
            width: _circle,
            height: _circle,
            left: left,
            top: top,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: _circleBorder),
                borderRadius: BorderRadius.circular(_circle),
              ),
            ));
      } else {
        return Positioned(
            width: 10,
            height: 10,
            left: left,
            top: top,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 5),
                borderRadius: BorderRadius.circular(10),
              ),
            ));
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildMenu(Orientation orientation) {
    return _showInterface
        ? Stack(children: [
            Positioned(
                right: 200,
                bottom: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: WidgetButton(
                            icon: "assets/graphics/icons/back.svg",
                            color: Interface.accent,
                            background: Interface.primary,
                            onTap: () {
                              Navigator.pop(context);
                            })))),
            Positioned(
                right: 150,
                bottom: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: WidgetSwitch.withIcon(
                            activeIcon: "assets/graphics/icons/zone_feed.svg",
                            inactiveIcon: "assets/graphics/icons/zone_feed.svg",
                            activeColor: Interface.accent,
                            activeBackground: Interface.primary,
                            inactiveColor: Interface.alwaysDark,
                            inactiveBackground: Interface.alwaysLight,
                            isActive: _settings.getMapZonesType,
                            onTap: () {
                              setState(() {
                                _settings.changeMapZonesType();
                              });
                            })))),
            Positioned(
                right: 100,
                bottom: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: WidgetSwitch.withIcon(
                            activeIcon: "assets/graphics/icons/other.svg",
                            inactiveIcon: "assets/graphics/icons/other.svg",
                            activeColor: Interface.accent,
                            activeBackground: Interface.primary,
                            inactiveColor: Interface.alwaysDark,
                            inactiveBackground: Interface.alwaysLight,
                            isActive: _settings.getMapZonesStyle,
                            onTap: () {
                              setState(() {
                                _settings.changeMapZonesStyle();
                              });
                            })))),
            Positioned(
                right: 50,
                bottom: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: WidgetButton(
                            icon: "assets/graphics/icons/about.svg",
                            color: Interface.alwaysDark,
                            background: Interface.alwaysLight,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityMapInformation()));
                            })))),
            Positioned(
                right: 0,
                bottom: 0,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: WidgetButton.withIcon(
                            icon: "assets/graphics/icons/menu_open.svg",
                            color: Interface.alwaysDark,
                            background: Interface.alwaysLight,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityMapLayers(name: _reserve.en, callback: _reload)));
                            })))),
            orientation == Orientation.portrait
                ? Positioned(
                    left: 0,
                    top: 0,
                    child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          width: _screenWidth,
                          color: Interface.shadow.withOpacity(0.3),
                          padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                          child: _buildAnimalList(),
                        )))
                : Positioned(
                    left: 0,
                    top: 0,
                    child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          height: _screenHeight,
                          color: Interface.shadow.withOpacity(0.3),
                          padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                          child: _buildAnimalList(),
                        )))
          ])
        : Container();
  }

  Widget _buildAnimalList() {
    List<Widget> widgets = [];
    for (int i = 0; i < HelperMap.getNames.length; i++) {
      if (HelperMap.isActive(i)) {
        String name = HelperMap.getNames[i];
        int o = HelperMap.getAnimalZones(HelperMap.getAnimal(i).id, 3).length;
        int p = ((o * 100) / _recommendedNumber).round();
        p = p > 100 ? 100 : p;
        widgets.add(Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          _settings.getMapZonesAccuracy
              ? Container(
                  width: 35,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 5),
                  child: AutoSizeText("$p%",
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: HelperMap.getColor(i),
                        fontSize: Interface.s14,
                        fontWeight: FontWeight.w400,
                      )))
              : Container(),
          Expanded(
              child: AutoSizeText(name,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: HelperMap.getColor(i),
                    fontSize: Interface.s14,
                    fontWeight: FontWeight.w400,
                  )))
        ]));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Interface.colorMapBackground,
      ),
      body: _buildStack(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getScreenSize();
    return _buildWidgets();
  }
}
