// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/loadouts.dart';
import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/entries/loadouts/loadout.dart';
import 'package:cotwcompanion/widgets/entries/menubar_item.dart';
import 'package:cotwcompanion/widgets/filters/range_set.dart';
import 'package:cotwcompanion/widgets/searchbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityLoadouts extends ActivityEntries {
  const ActivityLoadouts({
    super.key,
  }) : super(name: "loadouts");

  @override
  ActivityLoadoutsState createState() => ActivityLoadoutsState();
}

class ActivityLoadoutsState extends ActivityEntriesState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterLoadouts(controller.text, context));
    });
  }

  @override
  void removeAll() {
    setState(() {
      HelperLoadout.removeAll();
      filter();
    });
  }

  @override
  Future<bool> fileLoaded() async => await HelperLoadout.importFile();

  @override
  Future<bool> fileSaved() async => await HelperLoadout.exportFile();

  @override
  Widget buildEntry(int index, dynamic item) {
    return EntryLoadout(
      index: index,
      loadout: item,
      callback: filter,
      context: context,
    );
  }

  @override
  List<EntryMenuBarItem> buildMenuBarItems() {
    return [
      buildFileOptions(),
      EntryMenuBarItem(
        barButton: WidgetButtonIcon(
            icon: "assets/graphics/icons/plus.svg",
            onTap: () {
              focus();
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityEditLoadouts(callback: filter)));
            }),
      ),
    ];
  }

  @override
  List<Widget> buildFilters() {
    return [
      FilterRangeSet(
        icon: "assets/graphics/icons/loadout.svg",
        text: tr("weapon ammo"),
        decimal: false,
        filterKeyLower: FilterKey.loadoutsAmmoMin,
        filterKeyUpper: FilterKey.loadoutsAmmoMax,
      ),
      FilterRangeSet(
        icon: "assets/graphics/icons/caller.svg",
        text: tr("callers"),
        decimal: false,
        filterKeyLower: FilterKey.loadoutsCallersMin,
        filterKeyUpper: FilterKey.loadoutsCallersMax,
      ),
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
      filterChanged: HelperFilter.loadoutFiltersChanged(),
      onFilter: buildFilter,
    );
  }
}
