// Copyright (c) 2022 Jan Stehno

import 'dart:developer';

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/map_zone.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

class HelperMap {
  static final List<Animal> _animals = [];
  static final List<String> _names = [];
  static final List<LatLng> _outposts = [];
  static final List<LatLng> _lookouts = [];
  static final List<LatLng> _hides = [];
  static final Map<String, dynamic> _zones = {};

  static final List<bool> _activeE = [
    true, //OUTPOSTS
    false, //LOOKOUTS
    false, //HIdES
  ];
  static final List<Color> _colorsE = [
    Interface.dark, //OUTPOSTS
    Interface.dark, //LOOKOUTS
    Interface.dark, //HIdES
  ];
  static final List<bool> _active = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  static const List<Color> _colors = [
    Color(0xFF7C4DFF),
    Color(0xFFAB47BC),
    Color(0xFFE91E63),
    Color(0xFFF44336),
    Color(0xFFFF5722),
    Color(0xFFFF9800),
    Color(0xFFFFC107),
    Color(0xFFFFEB3B),
    Color(0xFFCDDC39),
    Color(0xFF8BC34A),
    Color(0xFF4CAF50),
    Color(0xFF009688),
    Color(0xFF00BCD4),
    Color(0xFF03A9F4),
    Color(0xFF2196F3),
    Color(0xFF3D5AFE),
    Color(0xFF607D8B),
    Color(0xFF9E9E9E),
    Color(0xFF8D6E63)
  ];

  static List<Animal> get getAnimals => _animals;

  static List<String> get getNames => _names;

  static List<LatLng> get getOutposts => _outposts;

  static List<LatLng> get getLookouts => _lookouts;

  static List<LatLng> get getHides => _hides;

  static Animal getAnimal(int index) => _animals[index];

  static String getName(int index) => _names[index];

  static bool isActive(int index) => _active[index];

  static bool isActiveE(int index) => _activeE[index];

  static Color getColor(int index) => _colors[index];

  static Color getColorE(int index) => _colorsE[index];

  static bool getOpacity(int index) => isActive(index);

  static bool getOpacityE(int index) => isActiveE(index);

  static List<MapObject> getAnimalZones(int animalId, int zoom) {
    List<MapObject> result = [];
    for (List<dynamic> object in _zones[animalId.toString()][zoom.toString()].cast()) {
      double x = object[0];
      double y = object[1];
      int zone = object.length > 2 ? object[2] : 3;
      result.add(MapObject(x: x, y: y, zone: zone));
    }
    return result;
  }

  static void activate(int index) {
    _active[index] = (!_active[index]);
  }

  static void activateE(int index) {
    _activeE[index] = (!_activeE[index]);
  }

  static void activateAll() {
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

  static bool isEverythingActive() {
    for (bool b in _active) {
      if (!b) return false;
    }
    return true;
  }

  static bool isAnimalLayerActive() => _active.contains(true);

  static void clearMap() {
    _animals.clear();
    _names.clear();
    _lookouts.clear();
    _outposts.clear();
    _hides.clear();
    _zones.clear();
    for (int i = 0; i < _activeE.length; i++) {
      _activeE[i] = (i == 0) ? true : false;
    }
    for (int i = 0; i < _active.length; i++) {
      _active[i] = false;
    }
  }

  static void addAnimal(Animal animal) {
    _animals.add(animal);
  }

  static void addNames(Locale locale, int reserveId) {
    _animals.sort((a, b) => a.getNameBasedOnReserve(locale, reserveId).compareTo(b.getNameBasedOnReserve(locale, reserveId)));
    for (Animal a in _animals) {
      _names.add(a.getNameBasedOnReserve(locale, reserveId));
    }
  }

  static void addObjects(dynamic objects) {
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
