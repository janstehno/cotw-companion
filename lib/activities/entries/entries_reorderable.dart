// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:flutter/material.dart';

abstract class ActivityEntriesReorderable extends ActivityEntries {
  const ActivityEntriesReorderable({
    super.key,
    required super.name,
  });
}

abstract class ActivityEntriesReorderableState extends ActivityEntriesState {
  void onReorder(int oldIndex, int newIndex) {}

  @override
  Widget buildItems() {
    filter();
    return WidgetScrollbar(
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              key: GlobalKey(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                dynamic item = items.elementAt(index);
                return buildEntry(index, item);
              },
              onReorder: (int oldIndex, int newIndex) {
                onReorder(oldIndex, newIndex);
              },
            ),
          ),
          SizedBox(height: menuHeight),
        ],
      ),
    );
  }
}
