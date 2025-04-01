import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/cupertino.dart';

class FilterEnumerators extends Filter<Enumerator> {
  @override
  List<Enumerator> filter(List<Enumerator> originalList, String searchText, [BuildContext? context]) {
    List<Enumerator> enumerators = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      enumerators = originalList.where((enumerator) {
        final matchSearch = searchText.isEmpty || enumerator.name.toLowerCase().contains(searchText.toLowerCase());

        return matchSearch;
      }).toList();
    }

    return enumerators.sorted(Enumerator.sortByOrder);
  }
}
