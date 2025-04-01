import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/logs.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/filter/picker_icon.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/filter/range_set.dart';
import 'package:cotwcompanion/widgets/filter/sorter.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterLogs extends ActivityFilter<Log> {
  const ActivityFilterLogs({
    super.key,
    required FilterLogs super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterLogsState();
}

class ActivityFilterLogsState extends ActivityFilterState<Log> {
  List<Widget> _listInterface() {
    return [
      WidgetTitleIcon(
        tr("INTERFACE"),
        icon: Assets.graphics.icons.fullscreen,
      ),
      WidgetFilterPickerIcon(
        filter: widget.filter,
        filterKey: FilterKey.logsView,
        bitKeys: [
          LogsView.trophyLodge,
          LogsView.date,
        ],
        labels: [
          Assets.graphics.icons.trophyLodge,
          Assets.graphics.icons.sortDate,
        ],
      ),
    ];
  }

  List<Widget> _listTrophyScore() {
    return [
      WidgetTitleIcon(
        tr("ANIMAL_TROPHY"),
        icon: Assets.graphics.icons.stats,
      ),
      WidgetFilterRangeSet(
        filter: widget.filter,
        filterKeyLower: FilterKey.logsTrophyScoreMin,
        filterKeyUpper: FilterKey.logsTrophyScoreMax,
        decimal: true,
      ),
    ];
  }

  List<Widget> _listTrophyRating() {
    return [
      WidgetTitleIcon(
        tr("TROPHY_RATING"),
        icon: Assets.graphics.icons.trophyDiamond,
      ),
      WidgetFilterPickerIcon(
        filter: widget.filter,
        filterKey: FilterKey.logsTrophyRating,
        bitKeys: [
          TrophyRating.none,
          TrophyRating.bronze,
          TrophyRating.silver,
          TrophyRating.gold,
          TrophyRating.diamond,
          TrophyRating.greatOne,
        ],
        labels: [
          Assets.graphics.icons.trophyNone,
          Assets.graphics.icons.trophyBronze,
          Assets.graphics.icons.trophySilver,
          Assets.graphics.icons.trophyGold,
          Assets.graphics.icons.trophyDiamond,
          Assets.graphics.icons.trophyGreatOne,
        ],
        colors: [
          Interface.light,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.light,
        ],
        backgrounds: [
          Interface.trophyNone,
          Interface.trophyBronze,
          Interface.trophySilver,
          Interface.trophyGold,
          Interface.trophyDiamond,
          Interface.trophyGreatOne,
        ],
      ),
    ];
  }

  List<Widget> _listFurRarity() {
    return [
      WidgetTitleIcon(
        tr("FUR_RARITY"),
        icon: Assets.graphics.icons.fur,
      ),
      WidgetFilterPickerText(
        filter: widget.filter,
        filterKey: FilterKey.logsFurRarity,
        bitKeys: [
          FurRarity.common,
          FurRarity.uncommon,
          FurRarity.rare,
          FurRarity.mission,
          FurRarity.greatOne,
        ],
        labels: [
          tr("RARITY_COMMON"),
          tr("RARITY_UNCOMMON"),
          tr("RARITY_RARE"),
          tr("RARITY_MISSION"),
          tr("FUR:GREAT_ONE"),
        ],
        colors: [
          Interface.light,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: [
          Interface.rarityCommon,
          Interface.rarityUncommon,
          Interface.rarityRare,
          Interface.rarityMission,
          Interface.rarityGreatOne,
        ],
      ),
    ];
  }

  List<Widget> _listGender() {
    return [
      WidgetTitleIcon(
        tr("ANIMAL_GENDER"),
        icon: Assets.graphics.icons.fur,
      ),
      WidgetFilterPickerIcon(
        filter: widget.filter,
        filterKey: FilterKey.logsGender,
        bitKeys: [
          Gender.male,
          Gender.female,
        ],
        labels: [
          Assets.graphics.icons.genderMale,
          Assets.graphics.icons.genderFemale,
        ],
        colors: const [
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: const [
          Interface.genderMale,
          Interface.genderFemale,
        ],
      ),
    ];
  }

  List<Widget> _listSortOptions() {
    return [
      WidgetTitleIcon(
        tr("SORT"),
        icon: Assets.graphics.icons.sort,
      ),
      WidgetFilterSorter(
        filter: widget.filter,
        sortKeys: [
          SortKey.az,
          SortKey.date,
          SortKey.trophyScore,
          SortKey.trophyRating,
          SortKey.furRarity,
          SortKey.gender,
        ],
        icons: [
          Assets.graphics.icons.sortAz,
          Assets.graphics.icons.sortDate,
          Assets.graphics.icons.sortTrophyScore,
          Assets.graphics.icons.trophyDiamond,
          Assets.graphics.icons.fur,
          Assets.graphics.icons.gender,
        ],
      ),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listInterface(),
        ..._listTrophyScore(),
        ..._listTrophyRating(),
        ..._listFurRarity(),
        ..._listGender(),
        ..._listSortOptions(),
      ];
}
