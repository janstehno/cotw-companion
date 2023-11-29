// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/entries/mission.dart';
import 'package:cotwcompanion/widgets/filters/picker_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserveMissions extends ListItems {
  final int reserveId;

  const ListReserveMissions({
    super.key,
    required this.reserveId,
  }) : super(name: "missions");

  @override
  ListReserveMissionsState createState() => ListReserveMissionsState();
}

class ListReserveMissionsState extends ListItemsState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterMissions(controller.text, context));
      List<dynamic> basedOnReserve = [];
      basedOnReserve = items.where((mission) => mission.reserveId == (widget as ListReserveMissions).reserveId).toList();
      items.clear();
      items.addAll(basedOnReserve);
    });
  }

  @override
  bool isFilterChanged() => HelperFilter.missionFiltersChanged();

  @override
  List<Widget> buildFilters() {
    return [
      FilterPickerText(
        text: tr("type"),
        icon: "assets/graphics/icons/missions.svg",
        labels: [
          tr("mission_main"),
          tr("mission_side"),
        ],
        filterKey: FilterKey.missionType,
      ),
      FilterPickerText(
        text: tr("difficulty"),
        icon: "assets/graphics/icons/stats.svg",
        labels: [
          tr("difficulty_easy"),
          tr("difficulty_mediocre"),
          tr("difficulty_hard"),
          tr("difficulty_very_hard"),
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
        filterKey: FilterKey.missionDifficulty,
      ),
    ];
  }

  @override
  EntryMission buildItemEntry(int index) {
    return EntryMission(
      index: index,
      mission: items.elementAt(index),
      callback: focus,
    );
  }
}
