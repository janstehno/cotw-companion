import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/missions.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterMissions extends ActivityFilter<Mission> {
  const ActivityFilterMissions({
    super.key,
    required FilterMissions super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterMissionsState();
}

class ActivityFilterMissionsState extends ActivityFilterState<Mission> {
  List<Widget> _listMissionType() {
    return [
      WidgetTitleIcon(
        tr("TYPE"),
        icon: Assets.graphics.icons.missions,
      ),
      WidgetFilterPickerText(
        filter: widget.filter,
        filterKey: FilterKey.missionType,
        bitKeys: MissionType.values,
        labels: [
          tr("MISSION_MAIN"),
          tr("MISSION_SIDE"),
        ],
      ),
    ];
  }

  List<Widget> _listMissionDifficulty() {
    return [
      WidgetTitleIcon(
        tr("DIFFICULTY"),
        icon: Assets.graphics.icons.stats,
      ),
      WidgetFilterPickerText(
        filter: widget.filter,
        filterKey: FilterKey.missionDifficulty,
        bitKeys: MissionDifficulty.values,
        labels: [
          tr("DIFFICULTY_EASY"),
          tr("DIFFICULTY_MEDIOCRE"),
          tr("DIFFICULTY_HARD"),
          tr("DIFFICULTY_VERY_HARD"),
        ],
        colors: const [
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: const [
          Interface.green,
          Interface.yellow,
          Interface.orange,
          Interface.red,
        ],
      ),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listMissionType(),
        ..._listMissionDifficulty(),
      ];
}
