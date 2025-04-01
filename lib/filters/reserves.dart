import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:flutter/cupertino.dart';

class FilterReserves extends Filter<Reserve> {
  @override
  List<Reserve> filter(List<Reserve> originalList, String searchText, [BuildContext? context]) {
    List<Reserve> reserves = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      reserves = originalList.where((reserve) {
        final matchSearch = searchText.isEmpty || reserve.name.toLowerCase().contains(searchText.toLowerCase());

        return matchSearch;
      }).toList();
    }

    return reserves.sorted(Reserve.sortById);
  }
}
