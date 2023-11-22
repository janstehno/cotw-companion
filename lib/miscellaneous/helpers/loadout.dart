// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:convert';
import 'dart:io';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HelperLoadout {
  static late Loadout _lastRemovedLoadout;

  static final List<Loadout> _loadouts = [];
  static final Loadout _defaultLoadout = Loadout(id: -1, name: "Default");

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

  static void removeLoadoutOnIndex(int index) {
    _lastRemovedLoadout = _loadouts.elementAt(index);
    _loadouts.removeAt(index);
    if (_loadouts.isEmpty || _activeLoadout.id == index) {
      useLoadout(-1);
    }
    _reIndex();
    _writeFile();
  }

  static Future<bool> saveFile() async {
    PermissionStatus status = PermissionStatus.granted;
    if (Platform.isAndroid) {
      AndroidDeviceInfo device = await DeviceInfoPlugin().androidInfo;
      if (int.parse(device.version.release) < 13) {
        status = await Permission.storage.request();
      }
    }
    if (status.isGranted) {
      final String? path = await FilePicker.platform.getDirectoryPath();
      if (path == null) {
        return false;
      }
      final String content = _parseLoadoutsToJsonString();
      if (content == "[]") {
        return false;
      }
      final String name = "${Log.dateToString(DateTime.now())}-saved-loadouts-cotwcompanion.json";
      try {
        final File file = File("$path/$name");
        await file.writeAsString(content);
      } on Exception {
        return false;
      }
      return true;
    }
    return false;
  }

  static Future<bool> loadFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["json"],
    );
    if (result == null) {
      return false;
    }
    final String? filePath = result.files.first.path;
    if (filePath == null) {
      return false;
    }
    final File file = File(filePath);
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
      return true;
    }
    return false;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/loadouts.json");
  }

  static Future<String> readExternalFile(File file) async {
    try {
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
    for (int index = 0; index < _loadouts.length; index++) {
      parsed += _loadouts[index].toJson();
      if (index != _loadouts.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }
}
