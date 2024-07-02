import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';

class HelperLog {
  static final HelperLogger _logger = HelperLogger.loadingLogs();

  static final List<Log> _logs = [];
  static final List<Log> _corruptedLogs = [];

  static final RegExp _rxDate = RegExp(
      r'^(20(1[789]|2[0123456789])|2030)-((0?2-(0?[1-9]|[12][0-9]))|(0?[469]|11)-(0?[1-9]|[12][0-9]|30)|(0?[13578]|1[02])-(0?[1-9]|[12][0-9]|3[01]))-(0?0-|0?[1-9]-|1[0-9]-|2[0-3]-)(0?0|0?[1-9]|[1-5][0-9])(-0?0|-0?[1-9]|-[1-5][0-9])?$',
      unicode: true);

  static late Log _lastRemovedLog;

  static List<Log> get logs => _logs;

  static List<Log> get corruptedLogs => _corruptedLogs;

  static void _initLodge() {
    _logs.sort(Log.sortByDate);
    for (Log log in _logs) {
      if (log.reserve == null) log.setLodge = true;
    }
    for (Log log in _corruptedLogs) {
      if (log.reserve == null) log.setLodge = true;
    }
  }

  static void addLogs(List<Log> logs) {
    _logs.clear();
    _corruptedLogs.clear();
    for (Log log in logs) {
      log.setCorrupted = true;
      _corruptedLogs.add(log);
      if (!_rxDate.hasMatch(Utils.dateTimeAs(DateStructure.json, log.dateTime))) continue;
      if (log.animal == null) continue;
      if (log.reserve == null) log.setReserveId = -1;
      if (log.animalFur == null) continue;
      if (log.trophy < 0 || log.trophy > 9999.999) continue;
      if (log.weight < 0 || log.weight > 9999.999) continue;
      log.setCorrupted = false;
      _corruptedLogs.remove(log);
      _logs.add(log);
    }
  }

  static void setLogs(List<Log> logs) {
    _logger.i("Initializing logs in HelperLog...");
    addLogs(logs);
    _initLodge();
    _logger.t("Logs initialized");
  }

  static void save([Log? log]) {
    if (log != null) _logs.add(log);
    _writeFile();
  }

  static void undoRemove() {
    save(_lastRemovedLog);
  }

  static void removeLog(Log log) {
    _lastRemovedLog = log;
    _logs.remove(log);
    _writeFile();
  }

  static void removeAll() {
    _logs.clear();
    _corruptedLogs.clear();
    _writeFile();
  }

  static void moveLogToLodge(Log log) {
    bool lodge = log.isInLodge ? false : true;
    log.setLodge = lodge;
    _writeFile();
  }

  static Log? isMultimountAnimalInTrophyLodge(MultimountAnimal multimountAnimal, Set<Log> usedLogs) {
    try {
      Log? log = logs.firstWhereOrNull((e) =>
          e.isInLodge &&
          e.animal!.id == multimountAnimal.id &&
          e.isMale == multimountAnimal.isMale &&
          !usedLogs.contains(e));
      return log;
    } catch (e) {
      return null;
    }
  }

  static List<Log> get toParse {
    final List<Log> toParse = [];
    toParse.addAll(_logs);
    toParse.addAll(_corruptedLogs);
    return toParse;
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateTimeAs(DateStructure.json, DateTime.now())}-saved-logbook-cotwcompanion.json";
    final String content = HelperJSON.listToJson(toParse);
    return await Utils.exportFile(content, name);
  }

  static Future<bool> importFile() async {
    return Utils.importFile((content) {
      try {
        final data = json.decode(content) as List<dynamic>;
        final List<Log> logs = data.map((e) => Log.fromJson(e)).toList();
        if (logs.isNotEmpty) {
          addLogs(logs);
          save();
          return true;
        }
      } catch (e) {
        return false;
      }
    });
  }

  static void _writeFile() async {
    final String content = HelperJSON.listToJson(toParse);
    Utils.writeFile(content, Values.logbook);
  }

  static Future<List<Log>> readFile() async {
    try {
      final String? data = await Utils.readFile(Values.logbook);
      final List<dynamic> list = json.decode(data ?? "[]") as List<dynamic>;
      final List<Log> logs = list.map((e) => Log.fromJson(e)).toList();
      _logger.t("${logs.length} logs loaded");
      return logs;
    } catch (e) {
      _logger.w("Logs not loaded");
      rethrow;
    }
  }
}
