// Copyright (c) 2022 - 2023 Jan Stehno

import 'dart:convert';
import 'dart:io';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HelperLog {
  static late BuildContext _context;
  static late Log _lastRemovedLog;

  static final List<Log> _logs = [];
  static final List<Log> _corruptedLogs = [];
  static final RegExp _dateReg = RegExp(
      r'^(20(1[789]|2[0123456789])|2030)-((0?2-(0?[1-9]|[12][0-9]))|(0?[469]|11)-(0?[1-9]|[12][0-9]|30)|(0?[13578]|1[02])-(0?[1-9]|[12][0-9]|3[01]))-(0?0-|0?[1-9]-|1[0-9]-|2[0-3]-)(0?0|0?[1-9]|[1-5][0-9])(-0?0|-0?[1-9]|-[1-5][0-9])?$',
      unicode: true);

  static set context(BuildContext context) {
    _context = context;
  }

  static List<Log> get logs => _logs;

  static List<Log> get corruptedLogs => _corruptedLogs;

  static void _reIndex() {
    _logs.sort((a, b) => b.dateForCompare.compareTo(a.dateForCompare));
    for (Log log in _logs) {
      if (log.reserveId <= -1) log.setLodge = 1;
      log.setId = _logs.indexOf(log);
    }
    for (Log log in _corruptedLogs) {
      if (log.reserveId <= -1) log.setLodge = 1;
      log.setId = _corruptedLogs.indexOf(log);
    }
  }

  static void _reName() {
    for (Log log in _logs) {
      Animal animal = HelperJSON.getAnimal(log.animalId);
      //FOR SORTING & FILTERING
      if (log.reserveId == -1) {
        log.setAnimalName = animal.getName(_context.locale);
      } else {
        log.setAnimalName = animal.getNameBasedOnReserve(_context.locale, log.reserveId);
      }
    }
  }

  static void _addLogs(List<Log> logs) {
    _logs.clear();
    _corruptedLogs.clear();
    for (Log log in logs) {
      log.setCorrupted = true;
      _corruptedLogs.add(log);
      if (!_dateReg.hasMatch(log.date)) continue;
      if (log.animalId <= 0 || log.animalId > HelperJSON.animals.length) continue;
      if (log.reserveId <= -2 || log.reserveId == 0 || log.reserveId > HelperJSON.reserves.length) continue;
      if (log.furId <= 0 || (log.furId >= HelperJSON.furs.length && log.furId < Interface.greatOneId) || log.furId > Interface.greatOneId) {
        continue;
      }
      if (log.trophy < 0 || log.trophy > 9999.999) continue;
      if (log.weight < 0 || log.weight > 9999.999) continue;
      log.setCorrupted = false;
      _corruptedLogs.removeLast();
      _logs.add(log);
    }
  }

  static void setLogs(List<Log> logs) {
    _addLogs(logs);
    _reIndex();
    _reName();
  }

  static void addLog(Log log) {
    _logs.add(log);
    _reIndex();
    _reName();
    _writeFile();
  }

  static void editLog(Log log) {
    _logs[log.id] = log;
    _reName();
    _writeFile();
  }

  static void undoRemove() {
    addLog(_lastRemovedLog);
    _reIndex();
  }

  static void removeLogOnIndex(int index) {
    _lastRemovedLog = _logs.elementAt(index);
    _logs.removeAt(index);
    _reIndex();
    _writeFile();
  }

  static void removeLogs() {
    _logs.clear();
    _corruptedLogs.clear();
    _reIndex();
    _writeFile();
  }

  static void moveLogToLodge(int loadoutId) {
    bool lodge = _logs[loadoutId].isInLodge ? false : true;
    _logs[loadoutId].setLodge = lodge ? 1 : 0;
    _writeFile();
  }

  static Future<bool> saveFile() async {
    final output = await getExternalStorageDirectory();
    if (output != null) {
      String content = _parseLogsToJsonString();
      if (content == "[]") return false;
      RegExp pathToDownloads = RegExp(r'.+0/');
      final path = '${pathToDownloads.stringMatch(output.path).toString()}Download';
      final fileName = "${Log.dateToString(DateTime.now())}-saved-logbook-cotwcompanion.json";
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
        List<Log> logs = [];
        logs = list.map((e) => Log.fromJson(e)).toList();
        if (logs.isNotEmpty) {
          _addLogs(logs);
          _reIndex();
          _reName();
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
    return File('$path/logbook.json');
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

  static Future<List<Log>> readLogs() async {
    final data = await HelperLog._readFile();
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Log.fromJson(e)).toList();
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
    String content = _parseLogsToJsonString();
    final file = await _localFile;
    return file.writeAsString(content);
  }

  static String _parseLogsToJsonString() {
    String parsed = "[";
    for (int index = 0; index < _logs.length; index++) {
      parsed += _logs[index].toJson();
      if (index != _logs.length - 1) {
        parsed += ",";
      } else if (_corruptedLogs.isNotEmpty) {
        parsed += ",";
      }
    }
    for (int index = 0; index < _corruptedLogs.length; index++) {
      parsed += _corruptedLogs[index].toJson();
      if (index != _corruptedLogs.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }

  static int getTrophyRating(double trophy, int animalId, int furId, bool harvestCheckPassed) {
    Animal animal = HelperJSON.getAnimal(animalId);
    int decrease = harvestCheckPassed ? 0 : 1;
    if (furId == Interface.greatOneId) {
      return 5 - (decrease * 2);
    }
    if (trophy >= animal.diamond) {
      return 4 - decrease;
    } else if (trophy >= animal.gold) {
      return 3 - decrease;
    } else if (trophy >= animal.silver) {
      return 2 - decrease;
    } else if (trophy > 0) {
      return 1 - decrease;
    }
    return 0;
  }
}
