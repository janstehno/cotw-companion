import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/model/translatable/multimount.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class FilterMultimounts extends Filter<Multimount> {
  @override
  List<Multimount> filter(List<Multimount> originalList, String searchText, [BuildContext? context]) {
    assert(context != null);

    List<Multimount> multimounts = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      multimounts = originalList.where((multimount) {
        final matchSearch = searchText.isEmpty || multimount.name.toLowerCase().contains(searchText.toLowerCase());
        final matchSearchAnimal = searchText.isEmpty ||
            multimount.animals.any(
                (a) => a.animal!.getNameByLocale(context!.locale).toLowerCase().contains(searchText.toLowerCase()));

        return matchSearch || matchSearchAnimal;
      }).toList();
    }

    return multimounts.sorted(Multimount.sortByName);
  }
}
