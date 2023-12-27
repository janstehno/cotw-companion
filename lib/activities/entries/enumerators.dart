// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/enumerators.dart';
import 'package:cotwcompanion/activities/entries/entries_reorderable.dart';
import 'package:cotwcompanion/activities/help/enumerators.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/enumerators/enumerator.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class ActivityEnumerators extends ActivityEntriesReorderable {
  const ActivityEnumerators({
    super.key,
  }) : super(name: "counters");

  @override
  ActivityEnumeratorsState createState() => ActivityEnumeratorsState();
}

class ActivityEnumeratorsState extends ActivityEntriesReorderableState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterEnumerators(controller.text, context));
    });
  }

  @override
  void removeAll() {
    setState(() {
      HelperEnumerator.removeAllEnumerators();
      filter();
    });
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      HelperEnumerator.changeIndexOfEnumerators(oldIndex, newIndex);
      filter();
    });
  }

  @override
  Future<bool> fileLoaded() async => await HelperEnumerator.importFile();

  @override
  Future<bool> fileSaved() async => await HelperEnumerator.exportFile();

  @override
  Widget buildEntry(int index, dynamic item) {
    return EntryEnumerator(
      key: Key(index.toString()),
      index: index,
      enumerator: item,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityHelpEnumerators()));
              });
            }),
      ),
      buildFileOptions(),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/plus.svg",
            onTap: () {
              focus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditEnumerators(callback: filter)));
            }),
      ),
    ];
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      onFilter: null,
    );
  }
}
