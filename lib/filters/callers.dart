import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:flutter/cupertino.dart';

class FilterCallers extends Filter<Caller> {
  @override
  List<Caller> filter(List<Caller> originalList, String searchText, [BuildContext? context]) {
    List<Caller> callers = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      callers = originalList.where((caller) {
        final matchSearch = searchText.isEmpty || caller.name.toLowerCase().contains(searchText.toLowerCase());

        return matchSearch;
      }).toList();
    }

    return callers.sorted(Caller.sortByName);
  }
}
