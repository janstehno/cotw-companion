import 'package:cotwcompanion/activities/entries/entries.dart';
import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/activities/modify/add/loadouts.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/loadout.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/filter/range_set.dart';
import 'package:cotwcompanion/widgets/parts/loadouts/loadout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityLoadouts extends ActivityEntries {
  const ActivityLoadouts({
    super.key,
  }) : super("LOADOUTS");

  @override
  ActivityLoadoutsState createState() => ActivityLoadoutsState();
}

class ActivityLoadoutsState extends ActivityEntriesState<Loadout> {
  @override
  List<Loadout> initialItems() {
    return HelperLoadout.loadouts;
  }

  @override
  List<Loadout> filteredItems() {
    return HelperFilter.filterLoadouts(items, controller.text);
  }

  @override
  void removeAll() {
    setState(() {
      HelperLoadout.removeAll();
      filter();
    });
  }

  @override
  Future<bool> fileLoaded() async {
    bool imported = await HelperLoadout.importFile();
    if (imported) filter();
    return imported;
  }

  @override
  Future<bool> fileSaved() async => await HelperLoadout.exportFile();

  @override
  Widget buildEntry(int i, dynamic item) {
    return EntryLoadout(
      i,
      loadout: item,
      context: context,
      callback: filter,
    );
  }

  @override
  List<WidgetMenuBarItem> listMenuBarItems() {
    return [
      buildMenuFileOptions(),
      buildMenuAdd(
        ActivityAddLoadouts(
          onSuccess: filter,
        ),
      ),
    ];
  }

  @override
  List<Widget> listFilters() {
    return [
      WidgetFilterRangeSet(
        FilterKey.loadoutsAmmoMin,
        FilterKey.loadoutsAmmoMax,
        icon: Assets.graphics.icons.loadout,
        text: tr("WEAPON_AMMO"),
        decimal: false,
      ),
      WidgetFilterRangeSet(
        FilterKey.loadoutsCallersMin,
        FilterKey.loadoutsCallersMax,
        icon: Assets.graphics.icons.caller,
        text: tr("CALLERS"),
        decimal: false,
      ),
    ];
  }

  @override
  void buildFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityFilter(filters: listFilters(), filter: filter)),
    );
  }

  @override
  WidgetSearchBar? buildSearchBar() {
    return WidgetSearchBar(
      controller: controller,
      filterChanged: HelperFilter.loadoutFiltersChanged(),
      onFilterTap: buildFilter,
    );
  }
}
