import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:flutter/cupertino.dart';

class FilterSearch extends Filter<Translatable> {
  @override
  List<Translatable> filter(List<Translatable> originalList, String searchText, [BuildContext? context]) {
    List<Translatable> items = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      items = originalList.where((item) {
        final matchSearch = searchText.isEmpty || item.name.toLowerCase().contains(searchText.toLowerCase());

        return matchSearch;
      }).toList();
    }

    return searchText.isEmpty ? [] : items;
  }

  List<Translatable> filterReserves(String searchText) {
    return filter(HelperJSON.reserves, searchText);
  }

  List<Translatable> filterAnimals(String searchText) {
    return filter(HelperJSON.animals, searchText);
  }

  List<Translatable> filterWeapons(String searchText) {
    return filter(HelperJSON.weapons, searchText);
  }

  List<Translatable> filterCallers(String searchText) {
    return filter(HelperJSON.callers, searchText);
  }

  List<Translatable> filterAmmo(String searchText) {
    return filter(HelperJSON.ammo, searchText);
  }

  List<Translatable> filterFurs(String searchText) {
    return filter(HelperJSON.furs, searchText);
  }

  List<Translatable> filterMissions(String searchText) {
    return filter(HelperJSON.missions, searchText);
  }
}
