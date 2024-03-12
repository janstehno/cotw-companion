// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperLog {
  static final HelperLogger _logger = HelperLogger.loadingLogs();

  static late Log _lastRemovedLog;

  static late BuildContext _context;

  static final List<Log> _logs = [];
  static final List<Log> _corruptedLogs = [];

  static final RegExp _dateReg = RegExp(
      r'^(20(1[789]|2[0123456789])|2030)-((0?2-(0?[1-9]|[12][0-9]))|(0?[469]|11)-(0?[1-9]|[12][0-9]|30)|(0?[13578]|1[02])-(0?[1-9]|[12][0-9]|3[01]))-(0?0-|0?[1-9]-|1[0-9]-|2[0-3]-)(0?0|0?[1-9]|[1-5][0-9])(-0?0|-0?[1-9]|-[1-5][0-9])?$',
      unicode: true);

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

  static void reName() {
    for (Log log in _logs) {
      Animal animal = HelperJSON.getAnimal(log.animalId);
      //FOR SORTING & FILTERING
      if (log.reserveId == -1) {
        log.setAnimalName = animal.getNameByLocale(_context.locale);
      } else {
        log.setAnimalName = animal.getNameBasedOnReserve(_context.locale, log.reserveId);
      }
    }
  }

  static void addLogs(List<Log> logs) {
    _logs.clear();
    _corruptedLogs.clear();
    for (Log log in logs) {
      log.setCorrupted = true;
      _corruptedLogs.add(log);
      if (!_dateReg.hasMatch(log.date)) continue;
      if (log.animalId <= 0 || log.animalId > HelperJSON.animals.length) continue;
      if (log.reserveId <= -2 || log.reserveId == 0 || log.reserveId > HelperJSON.reserves.length) continue;
      if (log.furId <= 0 || (log.furId >= HelperJSON.furs.length && log.furId < Values.greatOneId) || log.furId > Values.greatOneId) {
        continue;
      }
      if (log.trophy < 0 || log.trophy > 9999.999) continue;
      if (log.weight < 0 || log.weight > 9999.999) continue;
      log.setCorrupted = false;
      _corruptedLogs.removeLast();
      _logs.add(log);
    }
  }

  static void setLogs(List<Log> logs, BuildContext context) {
    _logger.i("Initializing logs in HelperLog...");
    _context = context;
    addLogs(logs);
    _reIndex();
    _logger.t("Logs initialized");
  }

  static void addLog(Log log) {
    _logs.add(log);
    reName();
    writeFile();
  }

  static void editLog(Log log) {
    _logs[log.id] = log;
    reName();
    writeFile();
  }

  static void undoRemove() {
    addLog(_lastRemovedLog);
  }

  static void removeLogOnIndex(int index) {
    _lastRemovedLog = _logs.elementAt(index);
    _logs.removeAt(index);
    writeFile();
  }

  static void removeAll() {
    _logs.clear();
    _corruptedLogs.clear();
    writeFile();
  }

  static void moveLogToLodge(int logId) {
    bool lodge = _logs[logId].isInLodge ? false : true;
    _logs[logId].setLodge = lodge ? 1 : 0;
    writeFile();
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateToString(DateTime.now())}-saved-logbook-cotwcompanion.json";
    final String content = parseToJson();
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
      List<Log> logs = [];
      try {
        logs = data.map((e) => Log.fromJson(e)).toList();
      } catch (e) {
        return false;
      }
      if (logs.isNotEmpty) {
        addLogs(logs);
        _reIndex();
        writeFile();
        return true;
      }
      return false;
    });
  }

  static void writeFile() {
    final String content = parseToJson();
    Utils.writeFile(content, Values.logbook);
  }

  static Future<List<Log>> readFile() async {
    try {
      final data = await Utils.readFile(Values.logbook);
      final list = json.decode(data) as List<dynamic>;
      final List<Log> logs = list.map((e) => Log.fromJson(e)).toList();
      _logger.t("${logs.length} logs loaded");
      return logs;
    } catch (e) {
      _logger.t("Logs not loaded");
      rethrow;
    }
  }

  static String parseToJson() {
    String parsed = HelperJSON.listToJson(_logs);
    if (_corruptedLogs.isNotEmpty) {
      parsed.replaceFirst("]", ",");
    }
    for (int index = 0; index < _corruptedLogs.length; index++) {
      parsed += _corruptedLogs.elementAt(index).toString();
      if (index != _corruptedLogs.length - 1) {
        parsed += ",";
      }
    }
    if (_corruptedLogs.isNotEmpty) {
      parsed += "]";
    }
    return parsed;
  }
}
