// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/enumerator.dart';

class HelperEnumerator {
  static late Enumerator _lastRemovedEnumerator;
  static late Counter _lastRemovedCounter;

  static final List<Enumerator> _enumerators = [];

  static List<Enumerator> get enumerators => _enumerators;

  static void _reSort() {
    _enumerators.sort((a, b) => a.id.compareTo(b.id));
    for (Enumerator enumerator in _enumerators) {
      enumerator.sortCounters();
    }
    writeFile();
  }

  static void setEnumerators(List<Enumerator> enumerators) {
    _enumerators.clear();
    _enumerators.addAll(enumerators);
    _reSort();
    writeFile();
  }

  static void addEnumerator(Enumerator enumerator) {
    _enumerators.add(enumerator);
    _reSort();
    writeFile();
  }

  static void addCounter(int enumeratorId, Counter counter) {
    _enumerators.elementAt(enumeratorId).addCounter(counter);
    _reSort();
    writeFile();
  }

  static void changeIndexOfEnumerators(int enumeratorId, int newEnumeratorId) {
    _enumerators.insert(newEnumeratorId, _enumerators.elementAt(enumeratorId));
    int oldId = newEnumeratorId > enumeratorId ? enumeratorId : enumeratorId + 1;
    _enumerators.removeAt(oldId);
    for (Enumerator enumerator in _enumerators) {
      enumerator.setId = _enumerators.indexOf(enumerator);
    }
    _reSort();
    writeFile();
  }

  static void changeIndexOfCounters(int enumeratorId, int counterId, int newCounterId) {
    List<dynamic> counters = _enumerators.elementAt(enumeratorId).counters;
    counters.insert(newCounterId, counters.elementAt(counterId));
    int oldId = newCounterId > counterId ? counterId : counterId + 1;
    counters.removeAt(oldId);
    for (Counter counter in counters) {
      counter.setId = counters.indexOf(counter);
    }
    _reSort();
    writeFile();
  }

  static void undoRemoveEnumerator() {
    addEnumerator(_lastRemovedEnumerator);
    _reSort();
  }

  static void undoRemoveCounter(int enumeratorId) {
    addCounter(enumeratorId, _lastRemovedCounter);
    _reSort();
  }

  static void removeEnumeratorOnIndex(int enumeratorId) {
    _lastRemovedEnumerator = _enumerators.elementAt(enumeratorId);
    _enumerators.removeAt(enumeratorId);
    _reSort();
    writeFile();
  }

  static void removeCounterOnIndex(int enumeratorId, int counterId) {
    _lastRemovedCounter = _enumerators.elementAt(enumeratorId).counterOnIndex(counterId);
    _enumerators.elementAt(enumeratorId).removeCounterOnIndex(counterId);
    _reSort();
    writeFile();
  }

  static editEnumerator(Enumerator enumerator) {
    _enumerators[enumerator.id] = enumerator;
    writeFile();
  }

  static editCounter(int enumeratorId, Counter counter) {
    _enumerators.elementAt(enumeratorId).counters[counter.id] = counter;
    writeFile();
  }

  static void removeAllEnumerators() {
    _enumerators.clear();
    _reSort();
    writeFile();
  }

  static void removeAllCounters(int enumeratorId) {
    _enumerators.elementAt(enumeratorId).removeAllCounters();
    _reSort();
    writeFile();
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateToString(DateTime.now())}-saved-counters-cotwcompanion.json";
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

  static void writeFile() {
    final String content = parseToJson();
    Utils.writeFile(content, "enumerators");
  }

  static Future<List<Enumerator>> readFile() async {
    final data = await Utils.readFile("enumerators");
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Enumerator.fromJson(e)).toList();
  }

  static String parseToJson() {
    return HelperJSON.listToJson(_enumerators);
  }
}
