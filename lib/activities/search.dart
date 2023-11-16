// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/info_ammo.dart';
import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/activities/info_caller.dart';
import 'package:cotwcompanion/activities/info_fur.dart';
import 'package:cotwcompanion/activities/info_reserve.dart';
import 'package:cotwcompanion/activities/info_weapon.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/item_search.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivitySearch extends StatefulWidget {
  const ActivitySearch({Key? key}) : super(key: key);

  @override
  ActivitySearchState createState() => ActivitySearchState();
}

class ActivitySearchState extends State<ActivitySearch> {
  final TextEditingController _controller = TextEditingController();
  final List<Reserve> _reserves = [];
  final List<Animal> _animals = [];
  final List<Fur> _furs = [];
  final List<Weapon> _weapons = [];
  final List<Ammo> _ammo = [];
  final List<Caller> _callers = [];

  int _itemIndex = -1;
  int _itemLimit = 5;

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
      _itemIndex = -1;
      _itemLimit = _controller.text.length * 2;
      _reserves.clear();
      _animals.clear();
      _furs.clear();
      _weapons.clear();
      _ammo.clear();
      _callers.clear();
      _reserves.addAll(HelperFilter.filterReserves(_controller.text, context));
      _animals.addAll(HelperFilter.filterAnimals(_controller.text, context));
      _furs.addAll(HelperFilter.filterFurs(_controller.text, context));
      _weapons.addAll(HelperFilter.filterWeapons(_controller.text, context));
      _ammo.addAll(HelperFilter.filterAmmo(_controller.text, context));
      _callers.addAll(HelperFilter.filterCallers(_controller.text, context));
    });
  }

  Widget _buildList() {
    _filter();
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reserves.length < _itemLimit ? _reserves.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/reserve.svg",
                text: _reserves[index].getName(context.locale),
                activity: ActivityReserveInfo(reserveId: _reserves[index].id),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _animals.length < _itemLimit ? _animals.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/wildlife.svg",
                text: _animals[index].getName(context.locale),
                activity: ActivityAnimalInfo(animalId: _animals[index].id),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _furs.length < _itemLimit ? _furs.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/fur.svg",
                text: _furs[index].getName(context.locale),
                activity: ActivityFurInfo(furId: _furs[index].id),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _weapons.length < _itemLimit ? _weapons.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/weapon.svg",
                text: _weapons[index].getName(context.locale),
                activity: ActivityWeaponInfo(weaponId: _weapons[index].id),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _ammo.length < _itemLimit ? _ammo.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/harvest_correct_ammo.svg",
                text: _ammo[index].getName(context.locale),
                activity: ActivityAmmoInfo(ammoId: _ammo[index].id),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _callers.length < _itemLimit ? _callers.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/caller.svg",
                text: _callers[index].getName(context.locale),
                activity: ActivityCallerInfo(callerId: _callers[index].id),
                callback: _focus,
              );
            }),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("search"),
        context: context,
      ),
      searchController: _controller,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
