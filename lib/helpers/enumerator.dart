import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';

class HelperEnumerator {
  final HelperLogger _logger = HelperLogger.loadingEnumerators();
  final List<Enumerator> _enumerators = [];

  late Enumerator _lastRemovedEnumerator;
  late Counter _lastRemovedCounter;

  List<Enumerator> get enumerators => _enumerators;

  void setEnumerators(List<Enumerator> enumerators) {
    _logger.i("Initializing enumerators in HelperEnumerator...");
    _enumerators.clear();
    _enumerators.addAll(enumerators);
    _logger.t("Enumerators initialized");
  }

  Enumerator? getEnumerator(int order) {
    return _enumerators.firstWhereOrNull((e) => e.order == order);
  }

  Counter? getCounter(Enumerator? enumerator, int order) {
    return _enumerators.firstWhere((e) => e == enumerator).counters.firstWhereOrNull((e) => e.order == order);
  }

  void save([Enumerator? enumerator]) {
    if (enumerator != null) _enumerators.add(enumerator);
    _writeFile();
  }

  void changeOrderOfEnumerators(int oldOrder, int newOrder) {
    Enumerator? changedEnumerator = getEnumerator(oldOrder);
    if (oldOrder > newOrder) {
      List<Enumerator> affected = _enumerators.where((e) => e.order >= newOrder && e.order < oldOrder).toList();
      for (Enumerator e in affected) {
        e.setOrder(e.order + 1);
      }
    } else {
      List<Enumerator> affected = _enumerators.where((e) => e.order < newOrder && e.order > oldOrder).toList();
      for (Enumerator e in affected) {
        e.setOrder(e.order - 1);
      }
    }
    changedEnumerator!.setOrder(newOrder > oldOrder ? newOrder - 1 : newOrder);
    _writeFile();
  }

  void changeOrderOfCounters(Enumerator? enumerator, int oldOrder, int newOrder) {
    Counter? changedCounter = getCounter(enumerator, oldOrder);
    if (oldOrder > newOrder) {
      List<Counter> affected = enumerator!.counters.where((e) => e.order >= newOrder && e.order < oldOrder).toList();
      for (Counter e in affected) {
        e.setOrder(e.order + 1);
      }
    } else {
      List<Counter> affected = enumerator!.counters.where((e) => e.order < newOrder && e.order > oldOrder).toList();
      for (Counter e in affected) {
        e.setOrder(e.order - 1);
      }
    }
    changedCounter!.setOrder(newOrder > oldOrder ? newOrder - 1 : newOrder);
    _writeFile();
  }

  void undoRemoveEnumerator() {
    save(_lastRemovedEnumerator);
  }

  void undoRemoveCounter(Enumerator enumerator) {
    enumerator.addCounter(_lastRemovedCounter);
    _writeFile();
  }

  void removeEnumerator(Enumerator enumerator) {
    _lastRemovedEnumerator = enumerator;
    _enumerators.remove(enumerator);
    _writeFile();
  }

  void removeCounter(Enumerator enumerator, Counter counter) {
    _lastRemovedCounter = counter;
    enumerator.removeCounter(counter);
    _writeFile();
  }

  void removeAllEnumerators() {
    _enumerators.clear();
    _writeFile();
  }

  void removeAllCounters(Enumerator enumerator) {
    enumerator.removeAllCounters();
    _writeFile();
  }

  Future<bool> exportFile() async {
    final String name = "${Utils.dateTimeAs(DateStructure.json, DateTime.now())}-saved-counters-cotwcompanion.json";
    final String content = parseToJson();
    return await Utils.exportFile(content, name);
  }

  Future<bool> importFile() async {
    return Utils.importFile((content) {
      try {
        final list = json.decode(content) as List<dynamic>;
        final List<Enumerator> enumerators = list.map((e) => Enumerator.fromJson(e)).toList();
        if (enumerators.isNotEmpty) {
          setEnumerators(enumerators);
          save();
          return true;
        }
      } catch (e) {
        return false;
      }
    });
  }

  void _writeFile() async {
    final String content = parseToJson();
    Utils.writeFile(content, Values.enumerators);
  }

  Future<List<Enumerator>> readFile() async {
    try {
      final String? data = await Utils.readFile(Values.enumerators);
      final List<dynamic> list = json.decode(data ?? "[]") as List<dynamic>;
      final List<Enumerator> enumerators = list.map((e) => Enumerator.fromJson(e)).toList();
      _logger.t("${enumerators.length} enumerators loaded");
      return enumerators;
    } catch (e) {
      _logger.w("Enumerators not loaded");
      rethrow;
    }
  }

  String parseToJson() {
    return HelperJSON.listToJson(_enumerators);
  }
}
