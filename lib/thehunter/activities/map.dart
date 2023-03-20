// Copyright (c) 2022 Jan Stehno

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_map.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_types.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/helpers/map_projection.dart';
import 'package:cotwcompanion/thehunter/activities/map_layers.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ActivityMap extends StatefulWidget {
  final int reserveID;

  const ActivityMap({Key? key, required this.reserveID}) : super(key: key);

  @override
  ActivityMapState createState() => ActivityMapState();
}

class ActivityMapState extends State<ActivityMap> {
  final MapController _mapController = MapController(location: const LatLng(0, 0), zoom: 1, projection: const COTWPROJCTN());
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
  bool _showCircularZones = false;
  bool _showInterface = true;

  @override
  void initState() {
    _reserve = JSONHelper.getReserve(widget.reserveID);
    _settings = Provider.of<Settings>(context, listen: false);
    _showCircularZones = _settings.getMapZonesStyle;
    super.initState();
  }

  _refresh() {
    setState(() {});
  }

  _getScreenSize() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
  }

  _getTileSize(Orientation orientation) {
    _tileSize = (orientation == Orientation.portrait ? _screenHeight : _screenWidth) / _minRowTiles;
  }

  double _clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;
    return x;
  }

  _values(double x) {
    if (x >= 1) {
      _level = 1;
      _circle = 200;
      _circleBorder = 2;
    }
    if (x > 1.667) {
      _level = 2;
      _circle = 150;
      _circleBorder = 3;
    }
    if (x > 2.334) {
      _level = 3;
      _circle = 10;
      _circleBorder = 5;
    }
  }

  bool _inView(double left, double top, double right, double bottom) {
    if ((right >= 0 && left <= _screenWidth) && (bottom >= 0 && top <= _screenHeight)) return true;
    return false;
  }

  _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
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
          color: const Color(Values.colorMapBackground),
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
              child: Stack(children: [_buildMap(orientation), _buildMenu(orientation)])));
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
                    return Image.asset(Graphics.getMapTile(widget.reserveID, x, y, z), fit: BoxFit.fitWidth);
                  }
                  return const SizedBox.shrink();
                }),
                Container(color: const Color(Values.colorMapBackground).withOpacity(0.5)),
                ..._buildObjectMarkers(transformer, HelperMap.getOutposts(), Graphics.getMapObjectIcon(MapObjectType.outpost, _level), Values.colorMapOLH, 15, 0),
                ..._buildObjectMarkers(transformer, HelperMap.getLookouts(), Graphics.getMapObjectIcon(MapObjectType.lookout, _level), Values.colorMapOLH, 15, 1),
                ..._buildObjectMarkers(transformer, HelperMap.getHides(), Graphics.getMapObjectIcon(MapObjectType.hide, _level), Values.colorMapOLH, 3, 2),
                for (int s = 0; s < HelperMap.getAnimals.length; s++) ..._buildZones(transformer, s)
              ]));
        });
  }

  Iterable<Widget> _buildObjectMarkers(MapTransformer transformer, List<LatLng> list, String icon, int color, int size, int type) {
    if (HelperMap.isActiveE(type)) {
      final positions = list.map(transformer.toOffset).toList();
      return positions.map(
        (pos) => _buildMarkerWidget(pos, icon, color, size, false, false, type),
      );
    }
    return [];
  }

  Iterable<Widget> _buildZoneMarkers(MapTransformer transformer, List<LatLng> list, String icon, int color, int size, int number) {
    final positions = list.map(transformer.toOffset).toList();
    return positions.map(
      (pos) => _buildMarkerWidget(pos, icon, color, size, true, _settings.getMapZonesStyle, number),
    );
  }

  Iterable<Widget> _buildZones(MapTransformer transformer, int s) {
    if (HelperMap.isActive(s)) {
      Animal a = HelperMap.getAnimals[s];
      String asset = Graphics.getAnimalMapIcon(a.getID);
      return _buildZoneMarkers(transformer, HelperMap.getAnimalZones(a.getID, _level), asset, HelperMap.getColor(s), 30, s);
    } else {
      return [];
    }
  }

  Widget _buildMarkerWidget(Offset pos, String icon, int color, int markerSize, bool zoneMarker, bool circular, int number) {
    double mx = 0, my = 0;
    double size = circular
        ? _circle
        : zoneMarker
            ? markerSize - (_mapController.zoom)
            : markerSize + (_mapController.zoom * 5);
    if (zoneMarker && _level == 3) {
      mx = cos(((360 / HelperMap.getAnimals.length) / HelperMap.getAnimals.length) * number) * (7);
      my = sin(((360 / HelperMap.getAnimals.length) / HelperMap.getAnimals.length) * number) * (7);
    }
    double left = pos.dx - (size / 2) + mx;
    double right = pos.dx + (size / 2) - mx;
    double top = pos.dy - (size / 2) + my;
    double bottom = pos.dy + (size / 2) - my;
    return _inView(left, top, right, bottom)
        ? zoneMarker && (circular || _level == 3)
            ? Positioned(
                width: _circle,
                height: _circle,
                left: left,
                top: top,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Color(color), width: _circleBorder), borderRadius: BorderRadius.circular(_circle)),
                ))
            : Positioned(
                width: size,
                height: size,
                left: left,
                top: top,
                child: zoneMarker
                    ? SimpleShadow(sigma: 5, opacity: 0.3, offset: const Offset(-0.1, -0.1), child: Image.asset(icon, width: size, height: size, color: Color(color)))
                    : number == 2 && _level == 1
                        ? const SizedBox.shrink()
                        : Image.asset(icon, fit: BoxFit.fitWidth, color: Color(color)))
        : const SizedBox.shrink();
  }

  Widget _buildMenu(Orientation orientation) {
    return Stack(children: [
      _showInterface
          ? Positioned(
              right: 110,
              bottom: 0,
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 20),
                      child: WidgetButton(
                          color: Values.colorAccent,
                          background: Values.colorPrimary,
                          icon: "assets/graphics/icons/back.svg",
                          size: 40,
                          onTap: () {
                            Navigator.pop(context);
                          }))))
          : Container(),
      _showInterface
          ? Positioned(
              right: 55,
              bottom: 0,
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 20),
                      child: WidgetSwitch(
                          activeColor: Values.colorAccent,
                          activeBackground: Values.colorPrimary,
                          inactiveColor: Values.colorAlwaysDark,
                          inactiveBackground: Values.colorAlwaysLight,
                          icon: "assets/graphics/icons/other.svg",
                          size: 40,
                          isActive: _settings.getMapZonesStyle,
                          noInactiveOpacity: true,
                          onTap: () {
                            setState(() {
                              _showCircularZones = !_showCircularZones;
                              _settings.changeMapZonesStyle();
                            });
                          }))))
          : Container(),
      _showInterface
          ? Positioned(
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 20),
                      child: WidgetButton(
                          background: Values.colorPrimary,
                          color: Values.colorAccent,
                          icon: "assets/graphics/icons/menu_open.svg",
                          size: 40,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityMapLayers(name: _reserve.getNameEN(), callback: _refresh)));
                          }))))
          : Container(),
      _showInterface
          ? orientation == Orientation.portrait
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                          width: _screenWidth,
                          color: Color(Values.colorShadow).withOpacity(0.3),
                          padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                          child: _buildAnimalList())))
              : Positioned(
                  left: 0,
                  top: 0,
                  child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                          height: _screenHeight,
                          color: Color(Values.colorShadow).withOpacity(0.3),
                          padding: HelperMap.isAnimalLayerActive() ? const EdgeInsets.all(15) : const EdgeInsets.all(0),
                          child: _buildAnimalList())))
          : Container()
    ]);
  }

  Widget _buildAnimalList() {
    List<Widget> widgets = [];
    for (int i = 0; i < HelperMap.getNames.length; i++) {
      if (HelperMap.isActive(i)) {
        String name = HelperMap.getNames[i];
        int o = HelperMap.getAnimalZones(HelperMap.getAnimal(i).getID, 3).length;
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
                      style: TextStyle(color: Color(HelperMap.getColor(i)), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
              : Container(),
          Expanded(
              child: AutoSizeText(name,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(HelperMap.getColor(i)), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
        ]));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _buildWidgets() {
    return Scaffold(appBar: AppBar(toolbarHeight: 0, backgroundColor: const Color(Values.colorMapBackground)), body: _buildStack());
  }

  @override
  Widget build(BuildContext context) {
    _getScreenSize();
    return _buildWidgets();
  }
}
