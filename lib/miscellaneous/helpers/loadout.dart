// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';

class HelperLoadout {
  static late Loadout _lastRemovedItem;

  static final List<Loadout> _loadouts = [];
  static final Loadout _defaultLoadout = Loadout(id: -1, name: "Default");

  static Loadout _activeLoadout = _defaultLoadout;

  static int _min = 9;
  static int _max = 1;

  static List<Loadout> get loadouts => _loadouts;

  static Loadout get activeLoadout => _activeLoadout;

  static bool get isLoadoutActivated => _activeLoadout.id > -1;

  static int get loadoutMin => _min;

  static int get loadoutMax => _max;

  static void _reIndex() {
    _loadouts.sort((a, b) => a.name.compareTo(b.name));
    for (Loadout loadout in _loadouts) {
      loadout.setId = _loadouts.indexOf(loadout);
    }
  }

  static void addItems(List<Loadout> loadouts) {
    _loadouts.clear();
    for (Loadout loadout in loadouts) {
      loadout.setAmmo = knownAmmo(loadout);
      loadout.setCallers = knownCallers(loadout);
      _loadouts.add(loadout);
    }
  }

  static List<int> knownAmmo(Loadout loadout) {
    List<int> result = [];
    for (int ammo in loadout.ammo) {
      if (ammo > 0 && ammo <= HelperJSON.ammo.length) result.add(ammo);
    }
    return result;
  }

  static List<int> knownCallers(Loadout loadout) {
    List<int> result = [];
    for (int caller in loadout.callers) {
      if (caller > 0 && caller <= HelperJSON.callers.length) result.add(caller);
    }
    return result;
  }

  static void useLoadout(int loadoutId) {
    if (_loadouts.isNotEmpty && loadoutId > -1) {
      _activeLoadout = _loadouts[loadoutId];
    } else {
      _activeLoadout = _defaultLoadout;
    }
    _loadoutMinMax();
  }

  static bool isActive(int loadoutId) {
    return loadoutId == _activeLoadout.id;
  }

  static void _loadoutMinMax() {
    _min = 9;
    _max = 1;
    if (_activeLoadout.ammo.isNotEmpty) {
      Ammo ammo;
      for (int index in _activeLoadout.ammo) {
        ammo = HelperJSON.getAmmo(index);
        if (_min > ammo.min) _min = ammo.min;
        if (_max < ammo.max) _max = ammo.max;
      }
    }
  }

  static bool containsCallerForAnimal(int animalId) {
    for (IdtoId iti in HelperJSON.animalsCallers) {
      if (iti.firstId == animalId) {
        for (int index in _activeLoadout.callers) {
          if (index == iti.secondId) return true;
        }
      }
    }
    return false;
  }

  static void setItems(List<Loadout> loadouts) {
    addItems(loadouts);
    _reIndex();
  }

  static void addItem(Loadout loadout) {
    _loadouts.add(loadout);
    _reIndex();
    writeFile();
  }

  static void editItem(Loadout loadout) {
    _loadouts[loadout.id] = loadout;
    writeFile();
  }

  static void undoRemove() {
    addItem(_lastRemovedItem);
    _reIndex();
  }

  static void removeItemOnIndex(int index) {
    _lastRemovedItem = _loadouts.elementAt(index);
    _loadouts.removeAt(index);
    if (_loadouts.isEmpty || _activeLoadout.id == index) {
      useLoadout(-1);
    }
    _reIndex();
    writeFile();
  }

  static void removeAll() {
    _loadouts.clear();
    _reIndex();
    writeFile();
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateToString(DateTime.now())}-saved-loadouts-cotwcompanion.json";
    final String content = HelperJSON.listToJson(_loadouts);
    return await Utils.exportFile(content, name);
  }

  static Future<bool> importFile() async {
    return Utils.importFile((content) {
      List<dynamic> data = [];
      try {
        data = json.decode(content) as List<dynamic>;
      } catch (e) {
        return false;
      }
      List<Loadout> loadouts = [];
      try {
        loadouts = data.map((e) => Loadout.fromJson(e)).toList();
      } catch (e) {
        return false;
      }
      if (loadouts.isNotEmpty) {
        addItems(loadouts);
        _reIndex();
        writeFile();
        return true;
      }
      return false;
    });
  }

  static void writeFile() async {
    final String content = parseToJson();
    Utils.writeFile(content, "loadouts");
  }

  static Future<List<Loadout>> readFile() async {
    final data = await Utils.readFile("loadouts");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Loadout.fromJson(e)).toList();
  }

  static parseToJson() {
    return HelperJSON.listToJson(_loadouts);
  }
}
