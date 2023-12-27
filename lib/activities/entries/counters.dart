// Copyright (c) 2023 Jan Stehno';

import 'package:cotwcompanion/activities/edit/counters.dart';
import 'package:cotwcompanion/activities/entries/entries_reorderable.dart';
import 'package:cotwcompanion/activities/help/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/counter.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:flutter/material.dart';

class ActivityCounters extends ActivityEntriesReorderable {
  final int enumeratorId;

  ActivityCounters({
    super.key,
    required this.enumeratorId,
  }) : super(name: HelperEnumerator.getEnumerator(enumeratorId).name);

  @override
  ActivityCountersState createState() => ActivityCountersState();
}

class ActivityCountersState extends ActivityEntriesReorderableState {
  late final int _enumeratorId;

  @override
  void initState() {
    _enumeratorId = (widget as ActivityCounters).enumeratorId;
    super.initState();
  }

  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperEnumerator.counters(_enumeratorId));
    });
  }

  @override
  void removeAll() {
    setState(() {
      HelperEnumerator.removeAllCounters(_enumeratorId);
      filter();
    });
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      HelperEnumerator.changeIndexOfCounters(_enumeratorId, oldIndex, newIndex);
      filter();
    });
  }

  @override
  Widget buildEntry(int index, dynamic item) {
    return EntryCounter(
      key: Key(index.toString()),
      index: index,
      counter: item,
      enumerator: HelperEnumerator.getEnumerator(_enumeratorId),
      callback: filter,
      context: context,
    );
  }

  @override
  List<EntryMenuBarItem> buildMenuBarItems() {
    return [
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/about.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                focus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityHelpCounters()));
              });
            }),
      ),
      EntryMenuBarItem(
          barButton: WidgetButtonIcon(
              icon: "assets/graphics/icons/remove_bin.svg",
              color: Interface.alwaysDark,
              background: Interface.red,
              onTap: () {
                setState(() {
                  focus();
                  yesNoOpened = true;
                });
              })),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/plus.svg",
            onTap: () {
              focus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditCounters(enumeratorId: _enumeratorId, callback: filter)));
            }),
      ),
    ];
  }

  @override
  WidgetAppBar buildAppBar() {
    return WidgetAppBar(
      text: widget.name,
      context: context,
    );
  }
}
