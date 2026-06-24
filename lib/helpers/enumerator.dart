import 'dart:convert';

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

  int? _lastRemovedEnumeratorIndex;
  int? _lastRemovedCounterIndex;

  List<Enumerator> get enumerators => _enumerators;

  void setEnumerators(List<Enumerator> enumerators) {
    _logger.i("Initializing enumerators in HelperEnumerator...");
    _enumerators.clear();
    _enumerators.addAll(enumerators);

    _sortByOrder();

    _logger.t("Enumerators initialized");
  }

  Enumerator? getEnumerator(int index) {
    if (index < 0 || index >= _enumerators.length) return null;

    return _enumerators[index];
  }

  Counter? getCounter(Enumerator? enumerator, int index) {
    if (enumerator == null) return null;
    if (index < 0 || index >= enumerator.counters.length) return null;

    return enumerator.counters[index];
  }

  void save([Enumerator? enumerator]) {
    if (enumerator != null) _enumerators.add(enumerator);
    _writeFile();
  }

  void changeOrderOfEnumerators(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _enumerators.length) return;
    if (newIndex < 0 || newIndex > _enumerators.length) return;

    if (newIndex > oldIndex) newIndex--;

    final Enumerator item = _enumerators.removeAt(oldIndex);
    _enumerators.insert(newIndex, item);

    _writeFile();
  }

  void changeOrderOfCounters(Enumerator enumerator, int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= enumerator.counters.length) return;
    if (newIndex < 0 || newIndex > enumerator.counters.length) return;

    if (newIndex > oldIndex) newIndex--;

    final Counter item = enumerator.counters.removeAt(oldIndex);
    enumerator.counters.insert(newIndex, item);

    _writeFile();
  }

  void undoRemoveEnumerator() {
    if (_lastRemovedEnumeratorIndex == null) return;

    final int index = _lastRemovedEnumeratorIndex!.clamp(0, _enumerators.length);
    _enumerators.insert(index, _lastRemovedEnumerator);

    _writeFile();
  }

  void undoRemoveCounter(Enumerator enumerator) {
    if (_lastRemovedCounterIndex == null) return;

    final int index = _lastRemovedCounterIndex!.clamp(0, enumerator.counters.length);
    enumerator.counters.insert(index, _lastRemovedCounter);

    _writeFile();
  }

  void removeEnumerator(Enumerator enumerator) {
    final int index = _enumerators.indexOf(enumerator);
    if (index == -1) return;

    _lastRemovedEnumerator = enumerator;
    _lastRemovedEnumeratorIndex = index;

    _enumerators.removeAt(index);
    _writeFile();
  }

  void removeCounter(Enumerator enumerator, Counter counter) {
    final int index = enumerator.counters.indexOf(counter);
    if (index == -1) return;

    _lastRemovedCounter = counter;
    _lastRemovedCounterIndex = index;

    enumerator.counters.removeAt(index);
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
        return false;
      } catch (_) {
        return false;
      }
    });
  }

  void _sortByOrder() {
    _enumerators.sort((a, b) => a.order.compareTo(b.order));

    for (final enumerator in _enumerators) {
      enumerator.counters.sort(
        (a, b) => a.order.compareTo(b.order),
      );
    }
  }

  void _rebuildOrders() {
    for (int i = 0; i < _enumerators.length; i++) {
      _enumerators[i].setOrder(i);

      for (int j = 0; j < _enumerators[i].counters.length; j++) {
        _enumerators[i].counters[j].setOrder(j);
      }
    }
  }

  void _writeFile() {
    _rebuildOrders();

    final String content = parseToJson();
    Utils.writeFile(content, Values.enumerators);
  }

  Future<List<Enumerator>> readFile() async {
    try {
      final String? data = await Utils.readFile(Values.enumerators);
      final List<dynamic> list = json.decode(data ?? "[]") as List<dynamic>;
      final List<Enumerator> enumerators = list.map((e) => Enumerator.fromJson(e)).toList();

      enumerators.sort((a, b) => a.order.compareTo(b.order));

      for (final enumerator in enumerators) {
        enumerator.counters.sort((a, b) => a.order.compareTo(b.order));
      }

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
