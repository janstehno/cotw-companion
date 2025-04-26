import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/entries/entries_reorderable.dart';
import 'package:cotwcompanion/activities/modify/add/counters.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/parts/enumerators/counter.dart';
import 'package:flutter/material.dart';

class ActivityCounters extends ActivityEntriesReorderable {
  final HelperEnumerator _helperEnumerator;
  final Enumerator _enumerator;

  ActivityCounters({
    super.key,
    required HelperEnumerator helperEnumerator,
    required Enumerator enumerator,
  })  : _helperEnumerator = helperEnumerator,
        _enumerator = enumerator,
        super(enumerator.name, helpUrl: "https://github.com/janstehno/cotw-companion/wiki/Counters");

  HelperEnumerator get helperEnumerator => _helperEnumerator;

  Enumerator get enumerator => _enumerator;

  @override
  ActivityCountersState createState() => ActivityCountersState();
}

class ActivityCountersState extends ActivityEntriesReorderableState<Counter> {
  late final HelperEnumerator _helperEnumerator;

  @override
  void initState() {
    _helperEnumerator = (widget as ActivityCounters).helperEnumerator;
    filter = HelperFilter.filterCounters;
    super.initState();
  }

  @override
  List<Counter> initialItems() {
    return (widget as ActivityCounters).enumerator.counters.sorted(Counter.sortByOrder);
  }

  @override
  void removeAll() {
    _helperEnumerator.removeAllCounters((widget as ActivityCounters).enumerator);
    filterItems();
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    _helperEnumerator.changeOrderOfCounters((widget as ActivityCounters).enumerator, oldIndex, newIndex);
    filterItems();
  }

  @override
  Widget buildEntry(int i, dynamic item) {
    return WidgetCounter(
      i,
      key: Key(i.toString()),
      counter: item,
      enumerator: (widget as ActivityCounters).enumerator,
      helperEnumerator: _helperEnumerator,
      context: context,
      callback: filterItems,
    );
  }

  @override
  List<WidgetMenuBarItem> listMenuBarItems() {
    return [
      buildMenuDelete(),
      buildMenuAdd(
        ActivityAddCounters(
          helperEnumerator: (widget as ActivityCounters).helperEnumerator,
          enumerator: (widget as ActivityCounters).enumerator,
          onSuccess: filterItems,
        ),
      ),
    ];
  }

  @override
  WidgetSearchBar? buildSearchBar() => null;

  @override
  WidgetAppBar buildAppBar() {
    return WidgetAppBar(
      widget.title,
      context: context,
    );
  }
}
