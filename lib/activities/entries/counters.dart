// Copyright (c) 2023 Jan Stehno';

import 'package:cotwcompanion/activities/edit/counters.dart';
import 'package:cotwcompanion/activities/entries/entries_reorderable.dart';
import 'package:cotwcompanion/activities/help/counters.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/counter.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:flutter/material.dart';

class ActivityCounters extends ActivityEntriesReorderable {
  final Enumerator enumerator;

  ActivityCounters({
    super.key,
    required this.enumerator,
  }) : super(name: enumerator.name);

  @override
  ActivityCountersState createState() => ActivityCountersState();
}

class ActivityCountersState extends ActivityEntriesReorderableState {
  late final Enumerator _enumerator;

  @override
  void initState() {
    _enumerator = (widget as ActivityCounters).enumerator;
    super.initState();
  }

  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(_enumerator.counters);
    });
  }

  @override
  void removeAll() {
    setState(() {
      HelperEnumerator.removeAllCounters(_enumerator.id);
      filter();
    });
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      HelperEnumerator.changeIndexOfCounters(_enumerator.id, oldIndex, newIndex);
      filter();
    });
  }

  @override
  Widget buildEntry(int index, item) {
    return EntryCounter(
      key: Key(index.toString()),
      index: index,
      counter: item,
      enumerator: _enumerator,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditCounters(enumerator: _enumerator, callback: filter)));
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
