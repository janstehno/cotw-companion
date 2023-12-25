// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/entries/weapon/weapon.dart';
import 'package:cotwcompanion/widgets/filters/range_auto.dart';
import 'package:cotwcompanion/widgets/filters/switch.dart';
import 'package:cotwcompanion/widgets/filters/value_set.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeapons extends ListItems {
  const ListWeapons({
    super.key,
  }) : super(name: "weapons");

  @override
  ListWeaponsState createState() => ListWeaponsState();
}

class ListWeaponsState extends ListItemsState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterWeapons(controller.text, context));
    });
  }

  @override
  bool isFilterChanged() => HelperFilter.weaponFiltersChanged();

  @override
  List<Widget> buildFilters() {
    return [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/other.svg",
        text: tr("type"),
      ),
      FilterSwitch(
        text: tr("weapons_rifles"),
        filterKey: FilterKey.weaponsRifles,
      ),
      FilterSwitch(
        text: tr("weapons_shotguns"),
        filterKey: FilterKey.weaponsShotguns,
      ),
      FilterSwitch(
        text: tr("weapons_handguns"),
        filterKey: FilterKey.weaponsHandguns,
      ),
      FilterSwitch(
        text: tr("weapons_bows_crossbows"),
        filterKey: FilterKey.weaponsBows,
      ),
      FilterValueSet(
        text: tr("animal_class"),
        icon: "assets/graphics/icons/level.svg",
        decimal: false,
        defaultValue: 0,
        filterKey: FilterKey.weaponsAnimalClass,
        filterKeyLower: FilterKey.weaponsClassMin,
        filterKeyUpper: FilterKey.weaponsClassMax,
      ),
      FilterRangeAuto(
        text: tr("animal_class"),
        icon: "assets/graphics/icons/min_max.svg",
        filterKeyLower: FilterKey.weaponsClassMin,
        filterKeyUpper: FilterKey.weaponsClassMax,
      ),
      FilterRangeAuto(
        text: tr("weapon_magazine"),
        icon: "assets/graphics/icons/weapon_mag.svg",
        filterKeyLower: FilterKey.weaponsMagMin,
        filterKeyUpper: FilterKey.weaponsMagMax,
      ),
    ];
  }

  @override
  EntryWeapon buildItemEntry(int index) {
    return EntryWeapon(
      index: index,
      weapon: items.elementAt(index),
      callback: focus,
    );
  }
}
