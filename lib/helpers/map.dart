import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/model/map/map_location.dart';
import 'package:cotwcompanion/model/map/map_zone.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperMap {
  final HelperLogger _logger = HelperLogger.loadingMap();

  final Map<int, Set<MapZone>> _zones = {};
  final Set<MapLocation> _outposts = {};
  final Set<MapLocation> _lookouts = {};
  final Set<MapLocation> _hides = {};

  final Reserve _reserve;

  final List<bool> _activeEnvironment = [
    false,
    false,
    false,
  ];
  final List<Color> _colorsEnvironment = [
    Interface.dark,
    Interface.dark,
    Interface.dark,
  ];
  final List<bool> _activeAnimals = [
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
  final List<Color> _colorsAnimals = [
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
    required reserve,
  }) : _reserve = reserve;

  Reserve get reserve => _reserve;

  Set<MapLocation> get outposts => _outposts;

  Set<MapLocation> get lookouts => _lookouts;

  Set<MapLocation> get hides => _hides;

  Map<int, Set<MapZone>> get zones => _zones;

  List<int> zonesKeys(BuildContext context) {
    return _zones.keys.sorted(
      (a, b) => getAnimal(a)!
          .getNameByReserve(context.locale, reserve)
          .compareTo(getAnimal(b)!.getNameByReserve(context.locale, reserve)),
    );
  }

  Animal? getAnimal(int key) => HelperJSON.getAnimal(key);

  bool isAnimalActive(int i) => _activeAnimals.elementAt(i);

  bool isEnvironmentActive(MapLocationType mapLocation) {
    switch (mapLocation) {
      case MapLocationType.outpost:
        return _activeEnvironment.elementAt(0);
      case MapLocationType.lookout:
        return _activeEnvironment.elementAt(1);
      case MapLocationType.hide:
        return _activeEnvironment.elementAt(2);
      default:
        return false;
    }
  }

  Color getAnimalColor(int i) => _colorsAnimals.elementAt(i);

  Color getEnvironmentColor(int i) => _colorsEnvironment.elementAt(i);

  void activateAnimal(int i) => _activeAnimals[i] = !(_activeAnimals.elementAt(i));

  void activateEnvironment(MapLocationType mapLocation) {
    switch (mapLocation) {
      case MapLocationType.outpost:
        _activeEnvironment[0] = !(_activeEnvironment.elementAt(0));
      case MapLocationType.lookout:
        _activeEnvironment[1] = !(_activeEnvironment.elementAt(1));
      case MapLocationType.hide:
        _activeEnvironment[2] = !(_activeEnvironment.elementAt(2));
      default:
        return;
    }
  }

  void activateAllAnimals() {
    if (isEveryAnimalActive) {
      for (int i = 0; i < _activeAnimals.length; i++) {
        _activeAnimals[i] = false;
      }
    } else {
      for (int i = 0; i < _activeAnimals.length; i++) {
        _activeAnimals[i] = true;
      }
    }
  }

  bool get isEveryAnimalActive => !_activeAnimals.contains(false);

  bool get isAnyAnimalActive => _activeAnimals.contains(true);

  bool showClustered(Settings settings, int level) {
    return settings.mapPerformanceMode && level != 3;
  }

  bool showZoneStyle(Settings settings, int level) {
    return settings.mapPerformanceMode && settings.mapZonesStyle && level != 3;
  }

  bool showZoneType(Settings settings, int level) {
    return settings.mapZonesType && (!settings.mapPerformanceMode || (settings.mapPerformanceMode && level == 3));
  }

  bool showZoneStyleButton(Settings settings, int level) {
    return settings.mapPerformanceMode && level != 3;
  }

  bool showZoneTypeButton(Settings settings, int level) {
    return !settings.mapPerformanceMode || (settings.mapPerformanceMode && level == 3);
  }

  Future<Map<String, dynamic>> readMapObjects(String? asset) async {
    if (asset == null) return {};
    try {
      final data = await HelperJSON.getData(asset);
      final Map<String, dynamic> mapObjects = Map.castFrom(json.decode(data));
      _logger.t("${mapObjects.length} maps objects loaded");
      return mapObjects;
    } catch (e) {
      _logger.w("Map objects not loaded");
      return {};
    }
  }

  void _addOutposts(Map<String, dynamic> objects) {
    _outposts.clear();
    dynamic outposts = objects["0"] ?? [];
    for (List<dynamic> object in outposts) {
      _outposts.add(MapLocation(x: object[0], y: object[1]));
    }
  }

  void _addLookouts(Map<String, dynamic> objects) {
    _lookouts.clear();
    dynamic lookouts = objects["1"] ?? [];
    for (List<dynamic> object in lookouts) {
      _lookouts.add(MapLocation(x: object[0], y: object[1]));
    }
  }

  void _addHides(Map<String, dynamic> objects) {
    _hides.clear();
    dynamic hides = objects["2"] ?? [];
    for (List<dynamic> object in hides) {
      _hides.add(MapLocation(x: object[0], y: object[1]));
    }
  }

  void _addAnimalZones(Map<String, dynamic> objects) {
    _zones.clear();
    dynamic animals = objects["3"] ?? {};
    for (String key in animals.keys) {
      Set<MapZone> zones = {};
      for (List<dynamic> object in animals[key]) {
        zones.add(MapZone(x: object[0], y: object[1], zone: object[2]));
      }
      _zones.putIfAbsent(int.parse(key), () => zones);
    }
  }

  void addObjects(Map<String, dynamic> objects) {
    _addOutposts(objects);
    _addLookouts(objects);
    _addHides(objects);
    _addAnimalZones(objects);
  }

  void resetActive() {
    for (bool e in _activeEnvironment) {
      _activeEnvironment[_activeEnvironment.indexOf(e)] = false;
    }
    for (bool e in _activeAnimals) {
      _activeAnimals[_activeAnimals.indexOf(e)] = false;
    }
  }
}
