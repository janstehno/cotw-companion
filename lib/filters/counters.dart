import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/material.dart';

class FilterCounters extends Filter<Counter> {
  @override
  List<Counter> filter(List<Counter> originalList, String searchText, [BuildContext? context]) {
    return originalList.sorted(Counter.sortByOrder);
  }
}
