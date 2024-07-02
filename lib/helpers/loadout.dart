import 'dart:convert';

import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';

class HelperLoadout {
  static final HelperLogger _logger = HelperLogger.loadingLoadouts();
  static final List<Loadout> _loadouts = [];

  static int _min = 9;
  static int _max = 1;

  static Loadout? _activeLoadout;
  static late Loadout? _lastRemovedLoadout;

  static List<Loadout> get loadouts => _loadouts;

  static Loadout? get activeLoadout => _activeLoadout;

  static bool get isLoadoutActivated => _activeLoadout != null;

  static bool isActive(Loadout loadout) => loadout == _activeLoadout;

  static void addLoadouts(List<Loadout> loadouts) {
    _loadouts.clear();
    _loadouts.addAll(loadouts);
  }

  static void useLoadout(Loadout? loadout) {
    if (_loadouts.isNotEmpty && loadout != null) {
      _activeLoadout = loadout;
      _loadoutMinMax();
    } else {
      _activeLoadout = null;
      _min = 1;
      _max = 9;
    }
  }

  static void _loadoutMinMax() {
    _min = 9;
    _max = 1;
    if (_activeLoadout!.ammo.isNotEmpty) {
      for (WeaponAmmo? weaponAmmo in _activeLoadout!.ammo) {
        Ammo ammo = HelperJSON.getAmmo(weaponAmmo!.ammoId)!;
        if (_min > ammo.min) _min = ammo.min;
        if (_max < ammo.max) _max = ammo.max;
      }
    }
  }

  static bool isAmmoEligible(Animal animal) => _min <= animal.level && animal.level <= _max;

  static bool isCallerEligible(Animal animal) {
    List<Caller> animalCallers = HelperJSON.getAnimalCallers(animal.id);

    for (Caller caller in _activeLoadout!.callers) {
      if (animalCallers.contains(caller)) return true;
    }
    return false;
  }

  static void setLoadouts(List<Loadout> loadouts) {
    _logger.i("Initializing loadouts in HelperLoadout...");
    addLoadouts(loadouts);
    _logger.t("Loadouts initialized");
  }

  static void save([Loadout? loadout]) {
    if (loadout != null) _loadouts.add(loadout);
    _writeFile();
  }

  static void undoRemove() {
    if (_lastRemovedLoadout != null) save(_lastRemovedLoadout!);
  }

  static void removeLoadout(Loadout? loadout) {
    _lastRemovedLoadout = loadout;
    _loadouts.remove(loadout);
    if (_loadouts.isEmpty || _activeLoadout == loadout) useLoadout(null);
    _writeFile();
  }

  static void removeAll() {
    _loadouts.clear();
    _writeFile();
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateTimeAs(DateStructure.json, DateTime.now())}-saved-loadouts-cotwcompanion.json";
    final String content = HelperJSON.listToJson(_loadouts);
    return await Utils.exportFile(content, name);
  }

  static Future<bool> importFile() async {
    return Utils.importFile((content) {
      try {
        final list = json.decode(content) as List<dynamic>;
        final List<Loadout> loadouts = list.map((e) => Loadout.fromJson(e)).toList();
        if (loadouts.isNotEmpty) {
          addLoadouts(loadouts);
          save();
          return true;
        }
      } catch (e) {
        return false;
      }
    });
  }

  static void _writeFile() async {
    final String content = parseToJson();
    Utils.writeFile(content, Values.loadouts);
  }

  static Future<List<Loadout>> readFile() async {
    try {
      final String? data = await Utils.readFile(Values.loadouts);
      final List<dynamic> list = json.decode(data ?? "[]") as List<dynamic>;
      final List<Loadout> loadouts = list.map((e) => Loadout.fromJson(e)).toList();
      _logger.t("${loadouts.length} loadouts loaded");
      return loadouts;
    } catch (e) {
      _logger.w("Loadouts not loaded");
      rethrow;
    }
  }

  static parseToJson() {
    return HelperJSON.listToJson(_loadouts);
  }
}
