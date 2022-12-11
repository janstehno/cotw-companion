// Copyright (c) 2022 Jan Stehno

import 'dart:convert';
import 'dart:io';

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/model/loadout.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class LoadoutHelper {
  static late Loadout _lastRemovedLoadout;

  static final List<Loadout> _loadouts = [];
  static final Loadout defaultLoadout = Loadout(id: -1, name: "None", weapons: [], callers: []);

  static Loadout activeLoadout = defaultLoadout;
  static int min = 9;
  static int max = 1;

  static List<Loadout> get loadouts => _loadouts;

  static int get loadoutMin => min;

  static int get loadoutMax => max;

  static bool get isLoadoutActivated => activeLoadout.getID > -1;

  static _reIndex() {
    _loadouts.sort((a, b) => a.getName.compareTo(b.getName));
    for (Loadout loadout in _loadouts) {
      loadout.setID(_loadouts.indexOf(loadout));
    }
  }

  static _addLoadouts(List<Loadout> loadouts) {
    _loadouts.clear();
    for (Loadout l in loadouts) {
      l.setWeapons(knownWeapons(l));
      l.setCallers(knownCallers(l));
      _loadouts.add(l);
    }
  }

  static List<int> knownWeapons(Loadout l) {
    List<int> result = [];
    for (int w in l.getWeapons) {
      if (w > 0 && w <= JSONHelper.ammo.length) result.add(w);
    }
    return result;
  }

  static List<int> knownCallers(Loadout l) {
    List<int> result = [];
    for (int c in l.getCallers) {
      if (c > 0 && c <= JSONHelper.callers.length) result.add(c);
    }
    return result;
  }

  static useLoadout(int i) {
    if (_loadouts.isNotEmpty && i > -1) {
      activeLoadout = _loadouts[i];
    } else {
      activeLoadout = defaultLoadout;
    }
    _loadoutMinMax();
  }

  static bool isActive(int loadoutID) {
    return loadoutID == activeLoadout.getID;
  }

  static _loadoutMinMax() {
    min = 9;
    max = 1;
    if (activeLoadout.getWeapons.isNotEmpty) {
      for (Weapon w in JSONHelper.weaponsInfo) {
        for (int i in activeLoadout.getWeapons) {
          if (w.getAmmoID == i) {
            if (min > w.getMin) min = w.getMin;
            if (max < w.getMax) max = w.getMax;
          }
        }
      }
    }
  }

  static bool containsCallerForAnimal(int animalID) {
    if (activeLoadout.getWeapons.isEmpty) return false;
    for (IDtoID iti in JSONHelper.animalsCallers) {
      if (iti.getFirstID == animalID) {
        for (int c in activeLoadout.getCallers) {
          if (c == iti.getSecondID) return true;
        }
      }
    }
    return false;
  }

  static setLoadouts(List<Loadout> loadouts) {
    _addLoadouts(loadouts);
    _reIndex();
  }

  static addLoadout(Loadout loadout) {
    _loadouts.add(loadout);
    _reIndex();
    _writeFile();
  }

  static editLoadout(Loadout loadout) {
    _loadouts[loadout.getID] = loadout;
    _writeFile();
  }

  static undoRemove() {
    addLoadout(_lastRemovedLoadout);
    _reIndex();
  }

  static removeLoadoutOnIndex(int i) {
    _lastRemovedLoadout = _loadouts.elementAt(i);
    _loadouts.removeAt(i);
    if (_loadouts.isEmpty || activeLoadout.getID == i) {
      useLoadout(-1);
    }
    _reIndex();
    _writeFile();
  }

  static Future<bool> saveFile() async {
    final output = await getExternalStorageDirectory();
    if (output != null) {
      String content = _parseLoadoutsToJsonString();
      if (content == "[]") return false;
      RegExp pathToDownloads = RegExp(r'.+0/');
      final path = '${pathToDownloads.stringMatch(output.path).toString()}Download';
      final fileName = "${dateTime(DateTime.now())}-saved-loadouts-cotwcompanion.json";
      final file = File('$path/$fileName');
      file.writeAsString(content);
      return true;
    }
    return false;
  }

  static Future<bool> loadFile() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    } catch (e) {
      return false;
    }
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        File file = File(filePath);
        final data = await readExternalFile(file);
        List<dynamic> list = [];
        try {
          list = json.decode(data) as List<dynamic>;
        } catch (e) {
          return false;
        }
        List<Loadout> loadouts = [];
        loadouts = list.map((e) => Loadout.fromJson(e)).toList();
        if (loadouts.isNotEmpty) {
          _addLoadouts(loadouts);
          _reIndex();
          _writeFile();
          FilePicker.platform.clearTemporaryFiles();
          return true;
        }
      }
    }
    return false;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/loadouts.json');
  }

  static Future<String> readExternalFile(File f) async {
    try {
      final file = f;
      final String contents;
      await file.exists() ? contents = await file.readAsString() : contents = "[]";
      if (contents.startsWith("[") && contents.endsWith("]")) return contents;
      return "[]";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Loadout>> readLoadouts() async {
    final data = await LoadoutHelper._readFile();
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Loadout.fromJson(e)).toList();
  }

  static Future<String> _readFile() async {
    try {
      final file = await _localFile;
      final String contents;
      await file.exists() ? contents = await file.readAsString() : contents = "[]";
      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<File> _writeFile() async {
    String content = _parseLoadoutsToJsonString();
    final file = await _localFile;
    return file.writeAsString(content);
  }

  static String _parseLoadoutsToJsonString() {
    String parsed = "[";
    for (int i = 0; i < _loadouts.length; i++) {
      parsed += _loadouts[i].toJson();
      if (i != _loadouts.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }

  static String dateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month > 9 ? dateTime.month.toString() : "0${dateTime.month}";
    String day = dateTime.day > 9 ? dateTime.day.toString() : "0${dateTime.day}";
    String hour = dateTime.hour > 9 ? dateTime.hour.toString() : "0${dateTime.hour}";
    String minute = dateTime.minute > 9 ? dateTime.minute.toString() : "0${dateTime.minute}";
    return "$year-$month-$day-$hour-$minute";
  }
}
