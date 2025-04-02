import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/activities/filter/logs.dart';
import 'package:cotwcompanion/activities/help/logs.dart';
import 'package:cotwcompanion/activities/modify/add/logs.dart';
import 'package:cotwcompanion/filters/logs.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/logs/stats.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/parts/logs/log.dart';
import 'package:flutter/material.dart';

class ActivityLogs extends ActivityEntries {
  const ActivityLogs({
    super.key,
  }) : super("LOGBOOK");

  @override
  ActivityLogsState createState() => ActivityLogsState();
}

class ActivityLogsState extends ActivityEntriesState<Log> {
  @override
  void initState() {
    filter = HelperFilter.filterLogs;
    super.initState();
  }

  @override
  ActivityFilter<Log> get activityFilter => ActivityFilterLogs(
        filter: filter as FilterLogs,
        onConfirm: filterItems,
      );

  @override
  List<Log> initialItems() {
    return HelperLog.logs;
  }

  @override
  void removeAll() {
    HelperLog.removeAll();
    filterItems();
  }

  @override
  Future<bool> fileLoaded() async {
    bool imported = await HelperLog.importFile();
    if (imported) filterItems();
    return imported;
  }

  @override
  Future<bool> fileSaved() async => await HelperLog.exportFile();

  @override
  Widget buildEntry(int i, dynamic item) {
    return WidgetLog(
      i,
      log: item,
      context: context,
      callback: filterItems,
    );
  }

  @override
  void showFileOptions() {
    setState(() {
      focus();
      fileOptionsOpened = !fileOptionsOpened;
    });
  }

  void addSeparator() {
    String searchText = controller.text += "|";
    controller.setTextAndPosition(searchText);
  }

  void onTapStats() {
    setState(
      () {
        focus();
        Navigator.push(context, MaterialPageRoute(builder: (e) => ListLogsStats(filteredItems)));
      },
    );
  }

  void onViewChange() {
    setState(() {
      filter.setValue(FilterKey.logsViewEntry, (filter.valueOf(FilterKey.logsViewEntry) - 1) % 3);
    });
  }

  WidgetMenuBarItem _buildMenuStats() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.stats,
        color: Interface.light,
        background: Interface.dark,
        onTap: () => onTapStats(),
      ),
    );
  }

  WidgetMenuBarItem _buildMenuSeparator() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.separator,
        color: Interface.light,
        background: Interface.dark,
        onTap: () => addSeparator(),
      ),
    );
  }

  WidgetMenuBarItem _buildMenuEntryView() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.viewExpanded,
        color: Interface.light,
        background: Interface.dark,
        onTap: () => onViewChange(),
      ),
    );
  }

  @override
  List<WidgetMenuBarItem> listMenuBarItems() {
    return [
      buildMenuHelp(const ActivityHelpLogs()),
      _buildMenuStats(),
      buildMenuFileOptions(),
      _buildMenuEntryView(),
      _buildMenuSeparator(),
      buildMenuAdd(
        ActivityAddLogs(
          onSuccess: filterItems,
          context: context,
        ),
      ),
    ];
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      filterChanged: filter.isActive(),
      onFilterTap: buildFilter,
    );
  }
}
