import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/animals.dart';
import 'package:cotwcompanion/filters/callers.dart';
import 'package:cotwcompanion/filters/counters.dart';
import 'package:cotwcompanion/filters/enumerators.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/filters/logs.dart';
import 'package:cotwcompanion/filters/multimounts.dart';
import 'package:cotwcompanion/filters/reserves.dart';
import 'package:cotwcompanion/filters/weapons.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/logger.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';

class HelperFilter {
  static final HelperLogger _logger = HelperLogger.loadingFilter();

  static final FilterReserves filterReserves = FilterReserves();
  static final FilterAnimals filterAnimals = FilterAnimals();
  static final FilterWeapons filterWeapons = FilterWeapons();
  static final FilterCallers filterCallers = FilterCallers();
  static final FilterHuntingPass filterHuntingPass = FilterHuntingPass();
  static final FilterLogs filterLogs = FilterLogs();
  static final FilterEnumerators filterEnumerators = FilterEnumerators();
  static final Filter<Counter> filterCounters = FilterCounters();
  static final Filter<Multimount> filterMultimounts = FilterMultimounts();

  static void setFilters(Map<String, dynamic> filters) {
    _logger.i("Initializing filters in HelperFilter...");
    for (final e in filters.entries) {
      _setValues(e.value, FilterType.values.firstWhere((v) => v.name == e.key));
    }
    _logger.t("Filters initialized");
  }

  static void _setValues(Map<String, dynamic> loadedFilter, FilterType filter) {
    loadedFilter.forEach((key, value) {
      FilterKey? filterKey = FilterKey.values.firstWhereOrNull((e) => e.name == key);
      if (filterKey != null) {
        switch (filter) {
          case FilterType.reserves:
            filterReserves.setValue(filterKey, value);
            break;
          case FilterType.animals:
            filterAnimals.setValue(filterKey, value);
            break;
          case FilterType.weapons:
            filterWeapons.setValue(filterKey, value);
            break;
          case FilterType.callers:
            filterCallers.setValue(filterKey, value);
            break;
          case FilterType.huntingPass:
            filterHuntingPass.setValue(filterKey, value);
            break;
          case FilterType.logs:
            filterLogs.setValue(filterKey, value);
            break;
          case FilterType.enumerators:
            filterEnumerators.setValue(filterKey, value);
            break;
          case FilterType.counters:
            filterCounters.setValue(filterKey, value);
            break;
          case FilterType.multimounts:
            filterMultimounts.setValue(filterKey, value);
        }
      }
    });
  }

  static Future<Map<String, dynamic>> readFile() async {
    try {
      final String? data = await Utils.readFile(Values.filters);
      final Map<String, dynamic> list = json.decode(data ?? "{}") as Map<String, dynamic>;
      _logger.t("${list.length} filters loaded");
      return list;
    } catch (e) {
      _logger.w("Filters not loaded");
      rethrow;
    }
  }

  static void writeFile() async {
    final Map<String, Map<String, num>> filterData = {
      if (filterReserves.isActive()) FilterType.reserves.name: _filterToJson(filterReserves.filters),
      if (filterAnimals.isActive()) FilterType.animals.name: _filterToJson(filterAnimals.filters),
      if (filterWeapons.isActive()) FilterType.weapons.name: _filterToJson(filterWeapons.filters),
      if (filterCallers.isActive()) FilterType.callers.name: _filterToJson(filterCallers.filters),
      if (filterHuntingPass.isActive()) FilterType.huntingPass.name: _filterToJson(filterHuntingPass.filters),
      if (filterLogs.isActive()) FilterType.logs.name: _filterToJson(filterLogs.filters),
      if (filterEnumerators.isActive()) FilterType.enumerators.name: _filterToJson(filterEnumerators.filters),
      if (filterCounters.isActive()) FilterType.counters.name: _filterToJson(filterCounters.filters),
      if (filterMultimounts.isActive()) FilterType.multimounts.name: _filterToJson(filterMultimounts.filters),
    };

    final String content = json.encode(filterData);
    await Utils.writeFile(content, Values.filters);
  }

  static Map<String, num> _filterToJson(Map<FilterKey, num> filterMap) {
    return filterMap.map((key, value) => MapEntry(key.name, value));
  }
}
