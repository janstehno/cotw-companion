import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class FilterLogs extends Filter<Log> {
  @override
  Map<FilterKey, num> get defaultFilters => {
        FilterKey.logsView: 0x3,
        FilterKey.logsViewEntry: 2,
        FilterKey.logsTrophyScoreMin: 0.0,
        FilterKey.logsTrophyScoreMax: double.maxFinite,
        FilterKey.logsTrophyRating: 0x3F,
        FilterKey.logsFurRarity: 0x1F,
        FilterKey.logsGender: 0x3,
      };

  @override
  List<Log> filter(List<Log> originalList, String searchText, [BuildContext? context]) {
    assert(context != null);

    List<Log> logs = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      logs = originalList.where((log) {
        final matchSearch = searchText.isEmpty ||
            searchText.toLowerCase().split("|").every((str) {
              final not = str.contains("!");
              final s = str.replaceAll("!", "");
              final matchByReserveName = log.reserve != null && log.reserve!.name.toLowerCase().contains(s);
              final matchByAnimalName =
                  log.animal!.getNameByReserve(context!.locale, log.reserve).toLowerCase().contains(s);
              final matchByFurName = log.animalFur!.furName.toLowerCase().contains(s);
              final condition = matchByReserveName || matchByAnimalName || matchByFurName;
              return not ? !(condition) : condition;
            });
        final matchTrophyLodge = log.isInLodge && isEnabled(FilterKey.logsView, LogsView.trophyLodge.index);
        final matchTrophyScore =
            log.trophy >= valueOf(FilterKey.logsTrophyScoreMin) && log.trophy <= valueOf(FilterKey.logsTrophyScoreMax);
        final matchTrophyRating = isEnabled(FilterKey.logsTrophyRating, log.trophyRating);
        final matchFurRarity = isEnabled(FilterKey.logsFurRarity, log.animalFur!.rarity.index);
        final matchGender = isEnabled(FilterKey.logsGender, log.isMale ? Gender.male.index : Gender.female.index);

        return matchSearch &&
            matchTrophyLodge &&
            matchTrophyScore &&
            matchTrophyRating &&
            matchFurRarity &&
            matchGender;
      }).toList();
    }

    if (sortingKeys.isEmpty) return logs.sorted(Log.sortByDate);

    return logs.sorted((a, b) {
      for (MapEntry<SortKey, bool> s in sortingKeys) {
        int compare = compareItems(a, b, s.key, s.value, context);
        if (compare != 0) return compare;
      }
      return 0;
    });
  }

  @override
  int compareItems(Log a, Log b, SortKey key, bool ascending, [BuildContext? context]) {
    assert(context != null);

    int comparison;
    switch (key) {
      case SortKey.az:
        comparison = b.animal!
            .getNameByReserve(context!.locale, b.reserve)
            .compareTo(a.animal!.getNameByReserve(context.locale, a.reserve));
        break;
      case SortKey.date:
        comparison = b.dateTime.compareTo(a.dateTime);
        break;
      case SortKey.trophyScore:
        comparison = b.trophy.compareTo(a.trophy);
        break;
      case SortKey.trophyRating:
        comparison = b.trophyRating.compareTo(a.trophyRating);
        break;
      case SortKey.furRarity:
        comparison = b.animalFur!.rarity.index.compareTo(a.animalFur!.rarity.index);
        break;
      case SortKey.gender:
        comparison = (b.isMale ? 1 : 0).compareTo(a.isMale ? 1 : 0);
        break;
    }
    return ascending ? -comparison : comparison;
  }
}
