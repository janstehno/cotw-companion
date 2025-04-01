import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:flutter/cupertino.dart';

abstract class Filter<T> {
  @protected
  Map<FilterKey, num> get defaultFilters => {};

  @protected
  Map<FilterKey, FilterOperation> get defaultOperations => {};

  @protected
  Map<FilterKey, num> _filters = {};

  Map<FilterKey, num> get filters => _filters;

  @protected
  Map<FilterKey, FilterOperation> _operations = {};

  List<MapEntry<SortKey, bool>> sortingKeys = [];

  Filter() {
    if (defaultFilters.isNotEmpty && _filters.isEmpty) _filters = _deepCopyFilters(defaultFilters);
    if (defaultOperations.isNotEmpty && _operations.isEmpty) _operations = _deepCopyFilters(defaultOperations);
  }

  void save() async {
    HelperFilter.writeFile();
  }

  List<T> filter(List<T> originalList, String searchText, [BuildContext? context]) => originalList;

  bool isEligible(FilterKey key, List<bool> conditions) {
    switch (_operations[key]) {
      case FilterOperation.not:
        return conditions.every((c) => !c);
      case FilterOperation.or:
        return conditions.any((c) => c);
      case FilterOperation.and:
        return conditions.every((c) => c);
      default:
        return true;
    }
  }

  void reset() {
    _filters = _deepCopyFilters(defaultFilters);
    _operations = _deepCopyFilters(defaultOperations);
  }

  bool isActive() {
    for (FilterKey key in defaultFilters.keys) {
      if (defaultFilters[key] != filters[key]) return true;
    }
    return false;
  }

  void toggle(FilterKey key, int bit) {
    if (filters.containsKey(key)) filters[key] = ((filters[key] ?? 0) as int) ^ (1 << bit);
  }

  void setValue(FilterKey key, num value) {
    if (filters.containsKey(key)) filters[key] = value;
  }

  num defaultValueOf(FilterKey key) {
    if (defaultFilters.containsKey(key)) return defaultFilters[key]!;
    throw UnimplementedError();
  }

  num valueOf(FilterKey key) {
    if (filters.containsKey(key)) return filters[key]!;
    throw UnimplementedError();
  }

  void switchOperation(FilterKey key) {
    FilterOperation actualOperation = operationOf(key);
    List<FilterOperation> operations = FilterOperation.values;
    FilterOperation newOperation = operations.elementAt((operations.indexOf(actualOperation) + 1) % operations.length);
    setOperation(key, newOperation);
  }

  void setOperation(FilterKey key, FilterOperation operation) {
    if (_operations.containsKey(key)) _operations[key] = operation;
  }

  FilterOperation operationOf(FilterKey key) {
    if (_operations.containsKey(key)) return _operations[key]!;
    throw UnimplementedError();
  }

  bool isEnabled(FilterKey key, int bit) {
    if (filters.containsKey(key)) return ((filters[key] ?? 0) as int) & (1 << bit) != 0;
    return false;
  }

  Color indicatorColor(FilterKey key, int bit) {
    return isEnabled(key, bit) ? Interface.primary : Interface.disabled;
  }

  void enable(FilterKey key, int bit) {
    if (filters.containsKey(key)) filters[key] = ((filters[key] ?? 0) as int) | (1 << bit);
  }

  void disable(FilterKey key, int bit) {
    if (filters.containsKey(key)) filters[key] = ((filters[key] ?? 0) as int) & ~(1 << bit);
  }

  void sortBy(SortKey key) {
    MapEntry<SortKey, bool>? sort = sortingKeys.firstWhereOrNull((e) => e.key == key);
    if (sort != null && sort.value) {
      sortingKeys[sortingKeys.indexOf(sort)] = MapEntry(sort.key, !sort.value);
    } else if (sort != null && !sort.value) {
      sortingKeys.removeAt(sortingKeys.indexOf(sort));
    } else {
      sortingKeys.add(MapEntry(key, true));
    }
  }

  bool isSortedBy(SortKey key) {
    return sortingKeys.firstWhereOrNull((e) => e.key == key) != null;
  }

  int? sortIndex(SortKey key) {
    MapEntry<SortKey, bool>? sort = sortingKeys.firstWhereOrNull((e) => e.key == key);
    if (sort != null) return sortingKeys.indexOf(sort);
    return null;
  }

  bool isAscended(SortKey key) {
    MapEntry<SortKey, bool>? sort = sortingKeys.firstWhereOrNull((e) => e.key == key);
    return sort != null && sort.value;
  }

  void resetSort() {
    sortingKeys.clear();
  }

  compareItems(T a, T b, SortKey key, bool ascending, [BuildContext? context]) => 0;

  Map<K, V> _deepCopyFilters<K, V>(Map<K, V> original) {
    return Map.from(original.map((key, value) {
      if (value is Map) return MapEntry(key, _deepCopyFilters(value));
      return MapEntry(key, value);
    }));
  }
}
