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
  final HelperEnumerator helperEnumerator;
  final int enumeratorId;

  ActivityCounters({
    super.key,
    required this.helperEnumerator,
    required this.enumeratorId,
  }) : super(name: helperEnumerator.getEnumerator(enumeratorId).name);

  @override
  ActivityCountersState createState() => ActivityCountersState();
}

class ActivityCountersState extends ActivityEntriesReorderableState {
  late final HelperEnumerator _helperEnumerator;
  late final int _enumeratorId;

  @override
  void initState() {
    _helperEnumerator = (widget as ActivityCounters).helperEnumerator;
    _enumeratorId = (widget as ActivityCounters).enumeratorId;
    super.initState();
  }

  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(_helperEnumerator.counters(_enumeratorId));
    });
  }

  @override
  void removeAll() {
    setState(() {
      _helperEnumerator.removeAllCounters(_enumeratorId);
      filter();
    });
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      _helperEnumerator.changeIndexOfCounters(_enumeratorId, oldIndex, newIndex);
      filter();
    });
  }

  @override
  Widget buildEntry(int index, dynamic item) {
    return EntryCounter(
      key: Key(index.toString()),
      index: index,
      counter: item,
      enumerator: _helperEnumerator.getEnumerator(_enumeratorId),
      callback: filter,
      helperEnumerator: _helperEnumerator,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActivityEditCounters(helperEnumerator: _helperEnumerator, enumeratorId: _enumeratorId, callback: filter)));
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
