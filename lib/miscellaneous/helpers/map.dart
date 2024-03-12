// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/map_zone.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

class HelperMap {
  final HelperLogger _logger = HelperLogger.loadingMap();

  final List<Animal> _animals = [];
  final List<String> _names = [];
  final List<LatLng> _outposts = [];
  final List<LatLng> _lookouts = [];
  final List<LatLng> _hides = [];
  final Map<String, dynamic> _zones = {};

  final int _reserveId;

  final List<bool> _activeE = [
    false, //OUTPOSTS
    false, //LOOKOUTS
    false, //HIDES
  ];
  final List<Color> _colorsE = [
    Interface.dark, //OUTPOSTS
    Interface.dark, //LOOKOUTS
    Interface.dark, //HIDES
  ];
  final List<bool> _active = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  final List<Color> _colors = [
    const Color(0xFF7C4DFF),
    const Color(0xFFAB47BC),
    const Color(0xFFE91E63),
    const Color(0xFFF44336),
    const Color(0xFFFF5722),
    const Color(0xFFFF9800),
    const Color(0xFFFFC107),
    const Color(0xFFFFEB3B),
    const Color(0xFFCDDC39),
    const Color(0xFF8BC34A),
    const Color(0xFF4CAF50),
    const Color(0xFF009688),
    const Color(0xFF00BCD4),
    const Color(0xFF03A9F4),
    const Color(0xFF2196F3),
    const Color(0xFF3D5AFE),
    const Color(0xFF607D8B),
    const Color(0xFF9E9E9E),
    const Color(0xFF8D6E63)
  ];

  HelperMap({
    required reserveId,
  }) : _reserveId = reserveId;

  int get reserveId => _reserveId;

  List<Animal> get animals => _animals;

  List<String> get names => _names;

  List<LatLng> get outposts => _outposts;

  List<LatLng> get lookouts => _lookouts;

  List<LatLng> get hides => _hides;

  Animal getAnimal(int index) => _animals.elementAt(index);

  String getName(int index) => _names.elementAt(index);

  bool isActive(int index) => _active.elementAt(index);

  bool isActiveE(int index) => _activeE.elementAt(index);

  Color getColor(int index) => _colors.elementAt(index);

  Color getColorE(int index) => _colorsE.elementAt(index);

  bool getOpacity(int index) => isActive(index);

  bool getOpacityE(int index) => isActiveE(index);

  List<MapObject> getAnimalZones(int animalId) {
    List<MapObject> result = [];
    for (List<dynamic> object in _zones[animalId.toString()].cast()) {
      double x = object[0];
      double y = object[1];
      int zone = object.length > 2 ? object[2] : 3;
      result.add(MapObject(x: x, y: y, zone: zone));
    }
    return result;
  }

  void activate(int index) {
    _active[index] = !(_active.elementAt(index));
  }

  void activateE(int index) {
    _activeE[index] = !(_activeE.elementAt(index));
  }

  void activateAll() {
    if (isEverythingActive()) {
      for (int index = 0; index < _active.length; index++) {
        _active[index] = false;
      }
    } else {
      for (int index = 0; index < _active.length; index++) {
        _active[index] = true;
      }
    }
  }

  bool isEverythingActive() {
    for (bool b in _active) {
      if (!b) return false;
    }
    return true;
  }

  bool isAnimalLayerActive() => _active.contains(true);

  void clearMap() {
    _animals.clear();
    _names.clear();
    _lookouts.clear();
    _outposts.clear();
    _hides.clear();
    _zones.clear();
    for (int index = 0; index < _activeE.length; index++) {
      _activeE[index] = false;
    }
    for (int index = 0; index < _active.length; index++) {
      _active[index] = false;
    }
  }

  void addAnimal(Animal animal) {
    _animals.add(animal);
  }

  void addNames(Locale locale) {
    _animals.sort((a, b) => a.getNameBasedOnReserve(locale, _reserveId).compareTo(b.getNameBasedOnReserve(locale, reserveId)));
    for (Animal a in _animals) {
      _names.add(a.getNameBasedOnReserve(locale, _reserveId));
    }
  }

  Future<Map<String, dynamic>> readMapObjects(String reserve) async {
    try {
      final data = await HelperJSON.getData("map/$reserve");
      final Map<String, dynamic> mapObjects = Map.castFrom(json.decode(data));
      _logger.t("${mapObjects.length} map objects loaded");
      return mapObjects;
    } catch (e) {
      _logger.w("Map objects not loaded");
      return {};
    }
  }

  void addObjects(dynamic objects) {
    for (int i = 0; i <= 3; i++) {
      String index = i.toString();
      if (i != 3) {
        List<LatLng> result = [];
        for (dynamic object in objects[index]) {
          result.add(MapObject.toLatLng(object[0], object[1]));
        }
        switch (i) {
          case 0:
            _outposts.addAll(result);
            break;
          case 1:
            _lookouts.addAll(result);
            break;
          case 2:
            _hides.addAll(result);
            break;
        }
      } else {
        _zones.addAll(objects[index]);
      }
    }
  }
}
