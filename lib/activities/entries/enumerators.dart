import 'package:cotwcompanion/activities/entries/entries_reorderable.dart';
import 'package:cotwcompanion/activities/help/enumerators.dart';
import 'package:cotwcompanion/activities/modify/add/enumerators.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/parts/enumerators/enumerator.dart';
import 'package:flutter/material.dart';

class ActivityEnumerators extends ActivityEntriesReorderable {
  final HelperEnumerator _helperEnumerator;

  const ActivityEnumerators({
    super.key,
    required HelperEnumerator helperEnumerator,
  })  : _helperEnumerator = helperEnumerator,
        super("COUNTERS");

  HelperEnumerator get helperEnumerator => _helperEnumerator;

  @override
  ActivityEnumeratorsState createState() => ActivityEnumeratorsState();
}

class ActivityEnumeratorsState extends ActivityEntriesReorderableState<Enumerator> {
  late final HelperEnumerator _helperEnumerator;

  @override
  List<Enumerator> get items => HelperFilter.filterEnumerators(controller.text, _helperEnumerator.enumerators);

  @override
  void initState() {
    _helperEnumerator = (widget as ActivityEnumerators).helperEnumerator;
    super.initState();
  }

  @override
  void removeAll() {
    setState(() {
      _helperEnumerator.removeAllEnumerators();
      filter();
    });
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    _helperEnumerator.changeOrderOfEnumerators(oldIndex, newIndex);
    filter();
  }

  @override
  Future<bool> fileLoaded() async {
    bool imported = await _helperEnumerator.importFile();
    if (imported) filter();
    return imported;
  }

  @override
  Future<bool> fileSaved() async => await _helperEnumerator.exportFile();

  @override
  Widget buildEntry(int i, dynamic item) {
    return WidgetEnumerator(
      i,
      key: Key(i.toString()),
      enumerator: item,
      helperEnumerator: _helperEnumerator,
      context: context,
      callback: filter,
    );
  }

  @override
  List<WidgetMenuBarItem> listMenuBarItems() {
    return [
      buildMenuHelp(
        const ActivityHelpEnumerators(),
      ),
      buildMenuFileOptions(),
      buildMenuAdd(
        ActivityAddEnumerators(
          helperEnumerator: _helperEnumerator,
          onSuccess: filter,
        ),
      ),
    ];
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      onFilterTap: null,
    );
  }
}
