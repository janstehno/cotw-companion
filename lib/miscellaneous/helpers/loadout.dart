// Copyright (c) 2022 Jan Stehno

import 'dart:convert';
import 'dart:io';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class HelperLoadout {
  static late Loadout _lastRemovedLoadout;

  static final List<Loadout> _loadouts = [];
  static final Loadout _defaultLoadout = Loadout(id: -1, name: "Default", ammo: [], callers: []);

  static Loadout _activeLoadout = _defaultLoadout;

  static int _min = 9;
  static int _max = 1;

  static List<Loadout> get loadouts => _loadouts;

  static int get loadoutMin => _min;

  static int get loadoutMax => _max;

  static Loadout get activeLoadout => _activeLoadout;

  static bool get isLoadoutActivated => _activeLoadout.id > -1;

  static void _reIndex() {
    _loadouts.sort((a, b) => a.name.compareTo(b.name));
    for (Loadout loadout in _loadouts) {
      loadout.setId = _loadouts.indexOf(loadout);
    }
  }

  static void _addLoadouts(List<Loadout> loadouts) {
    _loadouts.clear();
    for (Loadout l in loadouts) {
      l.setAmmo = knownAmmo(l);
      l.setCallers = knownCallers(l);
      _loadouts.add(l);
    }
  }

  static List<int> knownAmmo(Loadout l) {
    List<int> result = [];
    for (int w in l.ammo) {
      if (w > 0 && w <= HelperJSON.ammo.length) result.add(w);
    }
    return result;
  }

  static List<int> knownCallers(Loadout l) {
    List<int> result = [];
    for (int c in l.callers) {
      if (c > 0 && c <= HelperJSON.callers.length) result.add(c);
    }
    return result;
  }

  static void useLoadout(int i) {
    if (_loadouts.isNotEmpty && i > -1) {
      _activeLoadout = _loadouts[i];
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
      Ammo a;
      for (int i in _activeLoadout.ammo) {
        a = HelperJSON.getAmmo(i);
        if (_min > a.min) _min = a.min;
        if (_max < a.max) _max = a.max;
      }
    }
  }

  static bool containsCallerForAnimal(int animalId) {
    if (_activeLoadout.ammo.isEmpty) return false;
    for (IdtoId iti in HelperJSON.animalsCallers) {
      if (iti.firstId == animalId) {
        for (int c in _activeLoadout.callers) {
          if (c == iti.secondId) return true;
        }
      }
    }
    return false;
  }

  static void setLoadouts(List<Loadout> loadouts) {
    _addLoadouts(loadouts);
    _reIndex();
  }

  static void addLoadout(Loadout loadout) {
    _loadouts.add(loadout);
    _reIndex();
    _writeFile();
  }

  static void editLoadout(Loadout loadout) {
    _loadouts[loadout.id] = loadout;
    _writeFile();
  }

  static void undoRemove() {
    addLoadout(_lastRemovedLoadout);
    _reIndex();
  }

  static void removeLoadoutOnIndex(int i) {
    _lastRemovedLoadout = _loadouts.elementAt(i);
    _loadouts.removeAt(i);
    if (_loadouts.isEmpty || _activeLoadout.id == i) {
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
    final data = await HelperLoadout._readFile();
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
