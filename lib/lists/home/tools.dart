import 'package:cotwcompanion/activities/entries/loadouts.dart';
import 'package:cotwcompanion/activities/entries/logs.dart';
import 'package:cotwcompanion/activities/need_zones.dart';
import 'package:cotwcompanion/builders/enumerators.dart';
import 'package:cotwcompanion/builders/planner.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/lists/home/items.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListTools extends ListItems {
  const ListTools({
    super.key,
  }) : super("TOOLS");

  @override
  State<StatefulWidget> createState() => ListToolsState();
}

class ListToolsState extends ListItemsState {
  @override
  List<List<dynamic>> get items => [
        [tr("ANIMAL_NEED_ZONES"), Assets.graphics.icons.needZones, const ActivityNeedZones()],
        [tr("TROPHY_LODGE"), Assets.graphics.icons.trophyLodge, const ActivityLogs(trophyLodge: true)],
        [tr("LOGBOOK"), Assets.graphics.icons.catchBook, const ActivityLogs(trophyLodge: false)],
        [tr("LOADOUTS"), Assets.graphics.icons.loadout, const ActivityLoadouts()],
        [tr("COUNTERS"), Assets.graphics.icons.number, const BuilderEnumerators()],
        [tr("PLANNER"), Assets.graphics.icons.planner, const BuilderPlanner()],
      ];
}
