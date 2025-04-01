import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:flutter/cupertino.dart';

class FilterMissions extends Filter<Mission> {
  @override
  Map<FilterKey, int> get defaultFilters => {
        FilterKey.missionType: 0x3,
        FilterKey.missionDifficulty: 0xF,
      };

  @override
  List<Mission> filter(List<Mission> originalList, String searchText, [BuildContext? context]) {
    assert(context != null);

    List<Mission> missions = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      missions = originalList.where((mission) {
        final matchSearch = searchText.isEmpty || mission.name.toLowerCase().contains(searchText.toLowerCase());
        final matchMissionType = isEnabled(FilterKey.missionType, mission.type.index);
        final matchMissionDifficulty = isEnabled(FilterKey.missionDifficulty, mission.difficulty.index);

        return matchSearch && matchMissionType && matchMissionDifficulty;
      }).toList();
    }

    return missions.sorted(Mission.sortByName);
  }
}
