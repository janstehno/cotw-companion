// Copyright (c) 2022 Jan Stehno

import 'dart:convert';
import 'dart:io';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
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

  static List<Log> get logs => _logs;

  static List<Log> get corruptedLogs => _corruptedLogs;

  static void _reIndex() {
    _logs.sort((a, b) => b.dateForCompare.compareTo(a.dateForCompare));
    for (Log l in _logs) {
      if (l.reserveId <= -1) l.setLodge = 1;
      l.setId = _logs.indexOf(l);
    }
    for (Log l in _corruptedLogs) {
      if (l.reserveId <= -1) l.setLodge = 1;
      l.setId = _corruptedLogs.indexOf(l);
    }
  }

  static void _reName() {
    for (Log l in _logs) {
      Animal a = HelperJSON.getAnimal(l.animalId);
      //FOR SORTING & FILTERING
      if (l.reserveId == -1) {
        l.setAnimalName = a.getName(_context.locale);
      } else {
        l.setAnimalName = a.getNameBasedOnReserve(_context.locale, l.reserveId);
      }
    }
  }

  static void _addLogs(List<Log> logs) {
    _logs.clear();
    _corruptedLogs.clear();
    for (Log l in logs) {
      l.setCorrupted = true;
      _corruptedLogs.add(l);
      if (!_dateReg.hasMatch(l.date)) continue;
      if (l.animalId <= 0 || l.animalId > HelperJSON.animals.length) continue;
      if (l.reserveId == 0 || l.reserveId > HelperJSON.reserves.length) continue;
      if (l.furId <= 0 || l.furId == 45 || l.furId == 46 || (l.furId >= 74 && l.furId <= 99) || l.furId > 100) continue;
      if (l.trophy < 0 || l.trophy > 9999.999) continue;
      if (l.weight < 0 || l.weight > 9999.999) continue;
      l.setCorrupted = false;
      _corruptedLogs.removeLast();
      _logs.add(l);
    }
  }

  static void setLogs(List<Log> logs, BuildContext context) {
    _context = context;
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

  static void removeLogOnIndex(int i) {
    _lastRemovedLog = _logs.elementAt(i);
    _logs.removeAt(i);
    _reIndex();
    _writeFile();
  }

  static void removeLogs() {
    _logs.clear();
    _corruptedLogs.clear();
    _reIndex();
    _writeFile();
  }

  static void moveLogToLodge(int i) {
    bool lodge = _logs[i].isInLodge ? false : true;
    _logs[i].setLodge = lodge ? 1 : 0;
    _writeFile();
  }

  static Future<bool> saveFile() async {
    final output = await getExternalStorageDirectory();
    if (output != null) {
      String content = _parseLogsToJsonString();
      if (content == "[]") return false;
      RegExp pathToDownloads = RegExp(r'.+0/');
      final path = '${pathToDownloads.stringMatch(output.path).toString()}Download';
      final fileName = "${getDate(DateTime.now())}-saved-logbook-cotwcompanion.json";
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
    for (int i = 0; i < _logs.length; i++) {
      parsed += _logs[i].toJson();
      if (i != _logs.length - 1) {
        parsed += ",";
      } else if (_corruptedLogs.isNotEmpty) {
        parsed += ",";
      }
    }
    for (int i = 0; i < _corruptedLogs.length; i++) {
      parsed += _corruptedLogs[i].toJson();
      if (i != _corruptedLogs.length - 1) {
        parsed += ",";
      }
    }
    parsed += "]";
    return parsed;
  }

  static String getDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month > 9 ? dateTime.month.toString() : "0${dateTime.month}";
    String day = dateTime.day > 9 ? dateTime.day.toString() : "0${dateTime.day}";
    String hour = dateTime.hour > 9 ? dateTime.hour.toString() : "0${dateTime.hour}";
    String minute = dateTime.minute > 9 ? dateTime.minute.toString() : "0${dateTime.minute}";
    return "$year-$month-$day-$hour-$minute";
  }

  static String getDateFormatted(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    return "$day.$month.$year  $hour:$minute";
  }
}
