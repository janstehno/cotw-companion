// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/enumerators.dart';
import 'package:cotwcompanion/activities/loadouts.dart';
import 'package:cotwcompanion/activities/logs.dart';
import 'package:cotwcompanion/activities/need_zones.dart';
import 'package:cotwcompanion/activities/planner.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/menu.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListTools extends StatefulWidget {
  const ListTools({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListToolsState();
}

class ListToolsState extends State<ListTools> {
  final List<List<dynamic>> _items = [
    ["animal_need_zones", "need_zones", const ActivityNeedZones()],
    ["trophy_lodge", "trophy_lodge", const ActivityLogs(trophyLodge: true)],
    ["logbook", "catch_book", const ActivityLogs(trophyLodge: false)],
    ["loadouts", "loadout", const ActivityLoadouts()],
    ["counters", "number", const ActivityEnumerators()],
    ["planner", "planner", const ActivityPlanner()],
  ];

  Widget _buildItem(int index, String text, String icon, Widget activity) {
    return EntryMenu(
      text: tr(text),
      icon: "assets/graphics/icons/$icon.svg",
      background: Utils.background(index),
      onMenuTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => activity));
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          List<dynamic> item = _items.elementAt(index);
          return _buildItem(
            index,
            item[0],
            item[1],
            item[2],
          );
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("tools"),
        context: context,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
