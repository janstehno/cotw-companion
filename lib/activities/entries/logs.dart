// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/logs.dart';
import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/activities/help/logs.dart';
import 'package:cotwcompanion/lists/logs/stats.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/helpers/log.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/logs/log.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/filters/picker_icon.dart';
import 'package:cotwcompanion/widgets/filters/picker_text.dart';
import 'package:cotwcompanion/widgets/filters/range_set.dart';
import 'package:cotwcompanion/widgets/filters/sorter_icon.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityLogs extends ActivityEntries {
  final bool trophyLodge;

  const ActivityLogs({
    super.key,
    required this.trophyLodge,
  }) : super(name: trophyLodge ? "trophy_lodge" : "logbook");

  @override
  ActivityLogsState createState() => ActivityLogsState();
}

class ActivityLogsState extends ActivityEntriesState {
  late final Settings _settings;
  late final bool _trophyLodge;

  bool _viewOptionsOpened = false;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    _trophyLodge = (widget as ActivityLogs).trophyLodge;
    HelperLog.reName();
    super.initState();
  }

  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterLogs(controller.text, context));

      if (!_trophyLodge && !_settings.trophyLodgeEntry) {
        items.removeWhere((log) => log.isInLodge);
      }
      if (_trophyLodge) {
        items.removeWhere((log) => !log.isInLodge);
      }
    });
  }

  @override
  void removeAll() {
    setState(() {
      HelperLog.removeAll();
      filter();
    });
  }

  @override
  Future<bool> fileLoaded() async => await HelperLog.importFile();

  @override
  Future<bool> fileSaved() async => await HelperLog.exportFile();

  @override
  Widget buildEntry(int index, dynamic item) {
    return EntryLog(
      index: index,
      log: item,
      callback: filter,
      context: context,
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

  EntryMenuBarItem _buildViewOptions() {
    return EntryMenuBarItem(
      barButton: WidgetButtonIcon(
          icon: "assets/graphics/icons/fullscreen.svg",
          color: Interface.light,
          background: Interface.dark,
          onTap: () {
            setState(() {
              focus();
              showViewOptions();
            });
          }),
      menuButtons: [
        WidgetButtonIcon(
            icon: _settings.compactLogbook == 3
                ? "assets/graphics/icons/view_semi_compact.svg"
                : _settings.compactLogbook == 2
                    ? "assets/graphics/icons/view_compact.svg"
                    : "assets/graphics/icons/view_expanded.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                focus();
                _settings.changeCompactLogbook();
              });
            }),
        WidgetSwitchIcon(
            icon: "assets/graphics/icons/sort_date.svg",
            color: Interface.light,
            background: Interface.dark,
            isActive: _settings.entryDate,
            onTap: () {
              setState(() {
                focus();
                _settings.changeEntryDate();
              });
            }),
        _trophyLodge
            ? const SizedBox.shrink()
            : WidgetSwitchIcon(
                icon: "assets/graphics/icons/trophy_lodge.svg",
                color: Interface.light,
                background: Interface.dark,
                isActive: _settings.trophyLodgeEntry,
                onTap: () {
                  setState(() {
                    focus();
                    _settings.changeTrophyLodgeEntry();
                    filter();
                  });
                })
      ],
      menuHeight: menuHeight,
      menuOpened: _viewOptionsOpened,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityHelpLogs()));
              });
            }),
      ),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/stats.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              setState(() {
                focus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListLogsStats(logs: items, trophyLodge: _trophyLodge)));
              });
            }),
      ),
      buildFileOptions(),
      _buildViewOptions(),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/separator.svg",
            color: Interface.light,
            background: Interface.dark,
            onTap: () {
              addSeparator();
            }),
      ),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/plus.svg",
            onTap: () {
              focus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditLogs(fromTrophyLodge: _trophyLodge, callback: filter)));
            }),
      ),
    ];
  }

  @override
  List<Widget> buildFilters() {
    String assets = "assets/graphics/icons/";
    return [
      FilterRangeSet(
        icon: "${assets}stats.svg",
        text: tr("animal_trophy"),
        decimal: true,
        filterKeyLower: FilterKey.logsTrophyScoreMin,
        filterKeyUpper: FilterKey.logsTrophyScoreMax,
      ),
      FilterPickerIcon(
        icon: "${assets}trophy_diamond.svg",
        text: tr("trophy_rating"),
        filterKey: FilterKey.logsTrophyRating,
        labels: [
          "${assets}trophy_none.svg",
          "${assets}trophy_bronze.svg",
          "${assets}trophy_silver.svg",
          "${assets}trophy_gold.svg",
          "${assets}trophy_diamond.svg",
          "${assets}trophy_great_one.svg",
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
      FilterPickerText(
        icon: "${assets}fur.svg",
        text: tr("fur_rarity"),
        labels: [
          tr("rarity_common"),
          tr("rarity_uncommon"),
          tr("rarity_rare"),
          tr("rarity_very_rare"),
          tr("rarity_mission"),
          HelperJSON.getFur(Values.greatOneId).getName(context.locale),
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
        filterKey: FilterKey.logsFurRarity,
      ),
      FilterPickerIcon(
        icon: "${assets}gender.svg",
        text: tr("animal_gender"),
        filterKey: FilterKey.logsGender,
        labels: [
          "${assets}gender_male.svg",
          "${assets}gender_female.svg",
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
      FilterSorterIcon(
        icon: "${assets}sort.svg",
        text: tr("sort"),
        filterKey: FilterKey.logsSort,
        icons: [
          "${assets}sort_az.svg",
          "${assets}sort_date.svg",
          "${assets}sort_trophy_score.svg",
          "${assets}trophy_diamond.svg",
          "${assets}fur.svg",
          "${assets}gender.svg",
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: buildFilters(), filter: filter)));
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      filterChanged: HelperFilter.logFiltersChanged(),
      onFilter: buildFilter,
    );
  }
}
