import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/home/translatables.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/parts/mission/mission.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserveMissions extends ListTranslatable {
  final Reserve _reserve;

  const ListReserveMissions(
    Reserve reserve, {
    super.key,
  })  : _reserve = reserve,
        super("MISSIONS");

  Reserve get reserve => _reserve;

  @override
  ListReserveMissionsState createState() => ListReserveMissionsState();
}

class ListReserveMissionsState extends ListTranslatableState<Mission> {
  @override
  List<Mission> get items => HelperFilter.filterMissions(controller.text).where((mission) {
        return mission.reserveId == (widget as ListReserveMissions).reserve.id;
      }).sorted(Mission.sortByName);

  @override
  bool isFilterChanged() => HelperFilter.missionFiltersChanged();

  @override
  List<Widget> listFilter() {
    return [
      WidgetFilterPickerText(
        FilterKey.missionType,
        text: tr("TYPE"),
        icon: Assets.graphics.icons.missions,
        labels: [
          tr("MISSION_MAIN"),
          tr("MISSION_SIDE"),
        ],
      ),
      WidgetFilterPickerText(
        FilterKey.missionDifficulty,
        text: tr("DIFFICULTY"),
        icon: Assets.graphics.icons.stats,
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
  WidgetMission buildEntry(item) {
    return WidgetMission(
      item,
      i: items.indexOf(item),
      onTap: focus,
    );
  }
}
