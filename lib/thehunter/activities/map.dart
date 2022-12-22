// Copyright (c) 2022 Jan Stehno

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_map.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/map_layers.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityMap extends StatefulWidget {
  final int reserveID;

  const ActivityMap({Key? key, required this.reserveID}) : super(key: key);

  @override
  ActivityMapState createState() => ActivityMapState();
}

class ActivityMapState extends State<ActivityMap> {
  late final Reserve _reserve;

  late Settings _settings;
  late double _screenHeight, _screenWidth;

  double _opacity = 1;
  bool _showZoneType = false;
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

  _getScreenSizes() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    _screenHeight = _screenHeight - padding.top - padding.bottom;
  }

  Widget _buildStack() {
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
          color: const Color(Values.colorMapBackground),
          child: Stack(children: [
            GestureDetector(
                onTap: () {
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
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: orientation == Orientation.portrait ? Axis.horizontal : Axis.vertical,
                          child: SizedBox(
                              height: orientation == Orientation.portrait ? _screenHeight : _screenWidth,
                              width: orientation == Orientation.portrait ? _screenHeight : _screenWidth,
                              child: Stack(children: [
                                Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: orientation == Orientation.portrait ? _screenHeight : _screenWidth,
                                        width: orientation == Orientation.portrait ? _screenHeight : _screenWidth,
                                        child: orientation == Orientation.portrait
                                            ? _buildMapLayers(BoxFit.fitWidth)
                                            : _buildMapLayers(BoxFit.fitWidth)))
                              ]))))
                ])),
            _showInterface
                ? Positioned(
                    right: 165,
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
                    right: 110,
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
                                icon: "assets/graphics/icons/zone_feed.svg",
                                size: 40,
                                isActive: _showZoneType,
                                noInactiveOpacity: true,
                                onTap: () {
                                  setState(() {
                                    _showZoneType = !_showZoneType;
                                  });
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
                                child: _buildAnimalLayerNames())))
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
                                child: _buildAnimalLayerNames())))
                : Container()
          ]));
    });
  }

  Widget _buildAnimalLayerNames() {
    List<Widget> widgets = [];
    for (int i = 0; i < HelperMap.getNames.length; i++) {
      if (HelperMap.isActive(i)) {
        widgets.add(SizedBox(
            height: 15,
            child: AutoSizeText(HelperMap.getNames[i],
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(HelperMap.getColor(i)), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _buildMapLayers(BoxFit fit) {
    String reserve = _reserve.getNameEN().replaceAll(" ", "").toLowerCase();
    return Stack(fit: StackFit.expand, children: [
      Image.asset("assets/graphics/maps/$reserve/fields.png",
          alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapFields).withOpacity(HelperMap.getOpacityE(3))),
      Image.asset("assets/graphics/maps/$reserve/roads.png", alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapRoads)),
      Image.asset("assets/graphics/maps/$reserve/water.png", alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapWater)),
      Image.asset("assets/graphics/maps/$reserve/outposts.png",
          alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapOLH).withOpacity(HelperMap.getOpacityE(0))),
      Image.asset("assets/graphics/maps/$reserve/lookouts.png",
          alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapOLH).withOpacity(HelperMap.getOpacityE(1))),
      Image.asset("assets/graphics/maps/$reserve/hides.png", alignment: Alignment.center, fit: fit, color: const Color(Values.colorMapOLH).withOpacity(HelperMap.getOpacityE(2))),
      for (int s = 0; s < HelperMap.getAnimals.length; s++) _buildAnimalLayers(HelperMap.getAnimal(s), s, reserve, fit, false),
      for (int s = 0; s < HelperMap.getAnimals.length; s++) _buildAnimalLayers(HelperMap.getAnimal(s), s, reserve, fit, true)
    ]);
  }

  Widget _buildAnimalLayers(Animal a, int i, String r, BoxFit fit, bool circular) {
    String suffix = circular ? "_c.png" : ".png";
    return Opacity(
        opacity: HelperMap.getOpacity(i),
        child: AnimatedOpacity(
            opacity: circular && _showCircularZones
                ? 1
                : !circular && !_showCircularZones
                    ? 1
                    : 0,
            duration: const Duration(milliseconds: 200),
            child: Image.asset("assets/graphics/maps/$r/${a.getNameENBasedOnReserve(widget.reserveID).replaceAll(" ", "").toLowerCase()}$suffix",
                alignment: Alignment.center,
                fit: fit,
                color: circular
                    ? Color(HelperMap.getColor(i))
                    : _showZoneType
                        ? null
                        : Color(HelperMap.getColor(i)))));
  }

  Widget _buildWidgets() {
    return Scaffold(appBar: AppBar(toolbarHeight: 0, backgroundColor: const Color(Values.colorMapBackground)), body: _buildStack());
  }

  @override
  Widget build(BuildContext context) {
    _getScreenSizes();
    return _buildWidgets();
  }
}
