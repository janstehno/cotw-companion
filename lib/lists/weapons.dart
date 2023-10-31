// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/weapon.dart';
import 'package:cotwcompanion/widgets/filters/range_auto.dart';
import 'package:cotwcompanion/widgets/filters/switch.dart';
import 'package:cotwcompanion/widgets/filters/value_set.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeapons extends StatefulWidget {
  const ListWeapons({
    Key? key,
  }) : super(key: key);

  @override
  ListWeaponsState createState() => ListWeaponsState();
}

class ListWeaponsState extends State<ListWeapons> {
  final TextEditingController _controller = TextEditingController();
  final List<Weapon> _weapons = [];

  @override
  void initState() {
    _controller.addListener(() => _filter());
    super.initState();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _filter() {
    setState(() {
      _weapons.clear();
      _weapons.addAll(HelperFilter.filterWeapons(_controller.text, context));
    });
  }

  List<Widget> _buildFilters() {
    return [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/other.svg",
        text: tr('weapon_type'),
      ),
      FilterSwitch(
        text: tr('weapons_rifles'),
        filterKey: FilterKey.weaponsRifles,
      ),
      FilterSwitch(
        text: tr('weapons_shotguns'),
        filterKey: FilterKey.weaponsShotguns,
      ),
      FilterSwitch(
        text: tr('weapons_handguns'),
        filterKey: FilterKey.weaponsHandguns,
      ),
      FilterSwitch(
        text: tr('weapons_bows_crossbows'),
        filterKey: FilterKey.weaponsBows,
      ),
      FilterValueSet(
        text: tr('animal_class'),
        icon: "assets/graphics/icons/level.svg",
        decimal: false,
        min: 1,
        max: 9,
        defaultValue: 0,
        filterKey: FilterKey.weaponsAnimalClass,
      ),
      FilterRangeAuto(
        text: tr('animal_class'),
        icon: "assets/graphics/icons/min_max.svg",
        min: 1,
        max: 9,
        filterKeyLower: FilterKey.weaponsClassMin,
        filterKeyUpper: FilterKey.weaponsClassMax,
      ),
      FilterRangeAuto(
        text: tr('weapon_magazine'),
        icon: "assets/graphics/icons/weapon_mag.svg",
        min: 1,
        max: 15,
        filterKeyLower: FilterKey.weaponsMagMin,
        filterKeyUpper: FilterKey.weaponsMagMax,
      ),
    ];
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: _buildFilters(), filter: _filter)));
  }

  Widget _buildList() {
    _filter();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _weapons.length,
        itemBuilder: (context, index) {
          return EntryWeapon(index: index, weapon: _weapons[index], callback: _focus);
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr('weapons'),
        context: context,
      ),
      searchController: _controller,
      filter: _buildFilter,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
