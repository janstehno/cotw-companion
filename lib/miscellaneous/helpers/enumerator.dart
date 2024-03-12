// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/enumerator.dart';

class HelperEnumerator {
  final HelperLogger _logger = HelperLogger.loadingEnumerators();

  late Enumerator _lastRemovedEnumerator;
  late Counter _lastRemovedCounter;

  final List<Enumerator> _enumerators = [];

  List<Enumerator> get enumerators => _enumerators;

  List<dynamic> counters(int enumeratorId) => _enumerators.elementAt(enumeratorId).counters;

  void _reSort() {
    _enumerators.sort((a, b) => a.id.compareTo(b.id));
    for (Enumerator enumerator in _enumerators) {
      enumerator.sortCounters();
    }
    writeFile();
  }

  void setEnumerators(List<Enumerator> enumerators) {
    _logger.i("Initializing enumerators in HelperEnumerator...");
    _enumerators.clear();
    _enumerators.addAll(enumerators);
    _reSort();
    writeFile();
    _logger.t("Enumerators initialized");
  }

  void addEnumerator(Enumerator enumerator) {
    _enumerators.add(enumerator);
    _reSort();
    writeFile();
  }

  void addCounter(int enumeratorId, Counter counter) {
    _enumerators.elementAt(enumeratorId).addCounter(counter);
    _reSort();
    writeFile();
  }

  Enumerator getEnumerator(int enumeratorId) {
    return _enumerators.elementAt(enumeratorId);
  }

  Counter getCounter(int enumeratorId, int counterId) {
    return getEnumerator(enumeratorId).counterOnIndex(counterId);
  }

  void changeIndexOfEnumerators(int enumeratorId, int newEnumeratorId) {
    _enumerators.insert(newEnumeratorId, _enumerators.elementAt(enumeratorId));
    int oldId = newEnumeratorId > enumeratorId ? enumeratorId : enumeratorId + 1;
    _enumerators.removeAt(oldId);
    for (Enumerator enumerator in _enumerators) {
      enumerator.setId = _enumerators.indexOf(enumerator);
    }
    _reSort();
    writeFile();
  }

  void changeIndexOfCounters(int enumeratorId, int counterId, int newCounterId) {
    counters(enumeratorId).insert(newCounterId, counters(enumeratorId).elementAt(counterId));
    int oldId = newCounterId > counterId ? counterId : counterId + 1;
    counters(enumeratorId).removeAt(oldId);
    for (Counter counter in counters(enumeratorId)) {
      counter.setId = counters(enumeratorId).indexOf(counter);
    }
    _reSort();
    writeFile();
  }

  void undoRemoveEnumerator() {
    addEnumerator(_lastRemovedEnumerator);
    _reSort();
  }

  void undoRemoveCounter(int enumeratorId) {
    addCounter(enumeratorId, _lastRemovedCounter);
    _reSort();
  }

  void removeEnumeratorOnIndex(int enumeratorId) {
    _lastRemovedEnumerator = _enumerators.elementAt(enumeratorId);
    _enumerators.removeAt(enumeratorId);
    _reSort();
    writeFile();
  }

  void removeCounterOnIndex(int enumeratorId, int counterId) {
    _lastRemovedCounter = _enumerators.elementAt(enumeratorId).counterOnIndex(counterId);
    _enumerators.elementAt(enumeratorId).removeCounterOnIndex(counterId);
    _reSort();
    writeFile();
  }

  editEnumerator(Enumerator enumerator) {
    _enumerators[enumerator.id] = enumerator;
    writeFile();
  }

  editCounter(int enumeratorId, Counter counter) {
    _enumerators.elementAt(enumeratorId).counters[counter.id] = counter;
    writeFile();
  }

  void removeAllEnumerators() {
    _enumerators.clear();
    _reSort();
    writeFile();
  }

  void removeAllCounters(int enumeratorId) {
    _enumerators.elementAt(enumeratorId).removeAllCounters();
    _reSort();
    writeFile();
  }

  Future<bool> exportFile() async {
    final String name = "${Utils.dateToString(DateTime.now())}-saved-counters-cotwcompanion.json";
    final String content = parseToJson();
    return await Utils.exportFile(content, name);
  }

  Future<bool> importFile() async {
    return Utils.importFile((content) {
      List<dynamic> data = [];
      try {
        data = json.decode(content) as List<dynamic>;
      } catch (e) {
        return false;
      }
      List<Enumerator> enumerators = [];
      try {
        enumerators = data.map((e) => Enumerator.fromJson(e)).toList();
      } catch (e) {
        return false;
      }
      if (enumerators.isNotEmpty) {
        setEnumerators(enumerators);
        _reSort();
        writeFile();
        return true;
      }
      return false;
    });
  }

  void writeFile() {
    final String content = parseToJson();
    Utils.writeFile(content, Values.enumerators);
  }

  Future<List<Enumerator>> readFile() async {
    try {
      final data = await Utils.readFile(Values.enumerators);
      final list = json.decode(data) as List<dynamic>;
      final List<Enumerator> enumerators = list.map((e) => Enumerator.fromJson(e)).toList();
      _logger.t("${enumerators.length} enumerators loaded");
      return enumerators;
    } catch (e) {
      _logger.t("Enumerators not loaded");
      rethrow;
    }
  }

  String parseToJson() {
    return HelperJSON.listToJson(_enumerators);
  }
}
