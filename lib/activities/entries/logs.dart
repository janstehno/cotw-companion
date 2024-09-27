import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/activities/help/logs.dart';
import 'package:cotwcompanion/activities/modify/add/logs.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/helpers/log.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/logs/stats.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/filter/picker_icon.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/filter/range_set.dart';
import 'package:cotwcompanion/widgets/filter/sorter.dart';
import 'package:cotwcompanion/widgets/parts/logs/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityLogs extends ActivityEntries {
  final bool _trophyLodge;

  const ActivityLogs({
    super.key,
    required bool trophyLodge,
  })  : _trophyLodge = trophyLodge,
        super(trophyLodge ? "TROPHY_LODGE" : "LOGBOOK");

  bool get trophyLodge => _trophyLodge;

  @override
  ActivityLogsState createState() => ActivityLogsState();
}

class ActivityLogsState extends ActivityEntriesState<Log> {
  late final Settings _settings;

  bool _viewOptionsOpened = false;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  @override
  List<Log> initialItems() {
    return HelperLog.logs;
  }

  @override
  List<Log> filteredItems() {
    List<Log> filtered = HelperFilter.filterLogs(items, controller.text, context);
    if (!(widget as ActivityLogs).trophyLodge && !_settings.trophyLodgeEntry) {
      filtered.removeWhere((e) => e.isInLodge);
    }
    if ((widget as ActivityLogs).trophyLodge) {
      filtered.removeWhere((e) => !e.isInLodge);
    }
    return filtered;
  }

  @override
  void removeAll() {
    HelperLog.removeAll();
    filter();
  }

  @override
  Future<bool> fileLoaded() async {
    bool imported = await HelperLog.importFile();
    if (imported) filter();
    return imported;
  }

  @override
  Future<bool> fileSaved() async => await HelperLog.exportFile();

  @override
  Widget buildEntry(int i, dynamic item) {
    return WidgetLog(
      i,
      log: item,
      trophyLodge: (widget as ActivityLogs).trophyLodge,
      context: context,
      callback: filter,
    );
  }

  @override
  void showFileOptions() {
    setState(() {
      focus();
      fileOptionsOpened = !fileOptionsOpened;
      _viewOptionsOpened = false;
    });
  }

  void showViewOptions() {
    setState(() {
      focus();
      _viewOptionsOpened = !_viewOptionsOpened;
      fileOptionsOpened = false;
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => ListLogsStats(filtered, trophyLodge: (widget as ActivityLogs).trophyLodge),
          ),
        );
      },
    );
  }

  Widget _buildViewOptions() {
    return WidgetButtonIcon(
      Assets.graphics.icons.fullscreen,
      color: Interface.light,
      background: Interface.dark,
      onTap: () {
        setState(() {
          focus();
          showViewOptions();
        });
      },
    );
  }

  Widget _buildViewOptionsCompact() {
    return WidgetButtonIcon(
      Graphics.getLogViewIcon(_settings.compactLogbook),
      color: Interface.light,
      background: Interface.dark,
      onTap: () {
        setState(() {
          focus();
          _settings.changeCompactLogbook();
        });
      },
    );
  }

  Widget _buildViewOptionsDate() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.sortDate,
      color: Interface.light,
      background: Interface.dark,
      isActive: _settings.entryDate,
      onTap: () {
        setState(() {
          focus();
          _settings.changeEntryDate();
        });
      },
    );
  }

  Widget _buildViewOptionsTrophyLodge() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.trophyLodge,
      color: Interface.light,
      background: Interface.dark,
      isActive: _settings.trophyLodgeEntry,
      onTap: () {
        setState(() {
          focus();
          _settings.changeTrophyLodgeEntry();
          filter();
        });
      },
    );
  }

  WidgetMenuBarItem _buildMenuViewOptions() {
    return WidgetMenuBarItem(
      barButton: _buildViewOptions(),
      subButtons: [
        _buildViewOptionsCompact(),
        _buildViewOptionsDate(),
        if (!(widget as ActivityLogs).trophyLodge) _buildViewOptionsTrophyLodge(),
      ],
      height: menuHeight,
      menuOpened: _viewOptionsOpened,
    );
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

  @override
  List<WidgetMenuBarItem> listMenuBarItems() {
    return [
      buildMenuHelp(const ActivityHelpLogs()),
      _buildMenuStats(),
      buildMenuFileOptions(),
      _buildMenuViewOptions(),
      _buildMenuSeparator(),
      buildMenuAdd(
        ActivityAddLogs(trophyLodgeOnly: (widget as ActivityLogs).trophyLodge, onSuccess: filter),
      ),
    ];
  }

  @override
  List<Widget> listFilters() {
    return [
      WidgetFilterRangeSet(
        FilterKey.logsTrophyScoreMin,
        FilterKey.logsTrophyScoreMax,
        icon: Assets.graphics.icons.stats,
        text: tr("ANIMAL_TROPHY"),
        decimal: true,
      ),
      WidgetFilterPickerIcon(
        FilterKey.logsTrophyRating,
        icon: Assets.graphics.icons.trophyDiamond,
        text: tr("TROPHY_RATING"),
        labels: [
          Assets.graphics.icons.trophyNone,
          Assets.graphics.icons.trophyBronze,
          Assets.graphics.icons.trophySilver,
          Assets.graphics.icons.trophyGold,
          Assets.graphics.icons.trophyDiamond,
          Assets.graphics.icons.trophyGreatOne,
        ],
        colors: [
          Interface.light,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.light,
        ],
        backgrounds: [
          Interface.trophyNone,
          Interface.trophyBronze,
          Interface.trophySilver,
          Interface.trophyGold,
          Interface.trophyDiamond,
          Interface.trophyGreatOne,
        ],
      ),
      WidgetFilterPickerText(
        FilterKey.logsFurRarity,
        icon: Assets.graphics.icons.fur,
        text: tr("FUR_RARITY"),
        labels: [
          tr("RARITY_COMMON"),
          tr("RARITY_UNCOMMON"),
          tr("RARITY_RARE"),
          tr("RARITY_VERY_RARE"),
          tr("RARITY_MISSION"),
          HelperJSON.getFur(Values.greatOneId)!.name,
        ],
        colors: [
          Interface.light,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: [
          Interface.rarityCommon,
          Interface.rarityUncommon,
          Interface.rarityRare,
          Interface.rarityVeryRare,
          Interface.rarityMission,
          Interface.rarityGreatOne,
        ],
      ),
      WidgetFilterPickerIcon(
        FilterKey.logsGender,
        icon: Assets.graphics.icons.gender,
        text: tr("ANIMAL_GENDER"),
        labels: [
          Assets.graphics.icons.genderMale,
          Assets.graphics.icons.genderFemale,
        ],
        colors: const [
          Interface.alwaysDark,
          Interface.alwaysDark,
        ],
        backgrounds: const [
          Interface.genderMale,
          Interface.genderFemale,
        ],
      ),
      WidgetFilterSorter(
        FilterKey.logsSort,
        icon: Assets.graphics.icons.sort,
        text: tr("SORT"),
        icons: [
          Assets.graphics.icons.sortAz,
          Assets.graphics.icons.sortDate,
          Assets.graphics.icons.sortTrophyScore,
          Assets.graphics.icons.trophyDiamond,
          Assets.graphics.icons.fur,
          Assets.graphics.icons.gender,
        ],
        criteria: const [
          true,
          false,
          false,
          false,
          false,
          false,
        ],
        preferences: const [
          "NAME",
          "DATE",
          "TROPHY",
          "TROPHY_RATING",
          "FUR_RARITY",
          "GENDER",
        ],
      )
    ];
  }

  @override
  void buildFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityFilter(filters: listFilters(), filter: filter),
      ),
    );
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      filterChanged: HelperFilter.logFiltersChanged(),
      onFilterTap: buildFilter,
    );
  }
}
