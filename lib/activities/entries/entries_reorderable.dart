import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/model/exportable/exportable.dart';
import 'package:flutter/material.dart';

abstract class ActivityEntriesReorderable extends ActivityEntries {
  const ActivityEntriesReorderable(
    super.title, {
    super.key,
  });
}

abstract class ActivityEntriesReorderableState<I extends Exportable> extends ActivityEntriesState<I> {
  void onReorder(int oldIndex, int newIndex) {}

  @override
  Widget buildItems(List<Widget> widgets) {
    return ReorderableListView.builder(
      key: GlobalKey(),
      itemCount: filteredItems.length,
      itemBuilder: (context, i) {
        return widgets.elementAt(i);
      },
      onReorder: (int oldIndex, int newIndex) {
        onReorder(oldIndex, newIndex);
      },
    );
  }
}
