// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/ammo.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/activities/detail/fur.dart';
import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/activities/detail/reserve.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/model/fur.dart';
import 'package:cotwcompanion/model/mission.dart';
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
  final List<Mission> _missions = [];

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
      _missions.clear();
      _reserves.addAll(HelperFilter.filterReserves(_controller.text, context));
      _animals.addAll(HelperFilter.filterAnimals(_controller.text, context));
      _furs.addAll(HelperFilter.filterFurs(_controller.text, context));
      _weapons.addAll(HelperFilter.filterWeapons(_controller.text, context));
      _ammo.addAll(HelperFilter.filterAmmo(_controller.text, context));
      _callers.addAll(HelperFilter.filterCallers(_controller.text, context));
      _missions.addAll(HelperFilter.filterMissions(_controller.text, context));
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
                text: _reserves.elementAt(index).getName(context.locale),
                activity: ActivityDetailReserve(reserve: _reserves[index]),
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
                text: _animals.elementAt(index).getNameByLocale(context.locale),
                activity: ActivityDetailAnimal(animalId: _animals.elementAt(index).id),
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
                text: _furs.elementAt(index).getName(context.locale),
                activity: ActivityDetailFur(fur: _furs[index]),
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
                text: _weapons.elementAt(index).getName(context.locale),
                activity: ActivityDetailWeapon(weapon: _weapons[index]),
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
                text: _ammo.elementAt(index).getName(context.locale),
                activity: ActivityDetailAmmo(ammo: _ammo[index]),
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
                text: _callers.elementAt(index).getName(context.locale),
                activity: ActivityDetailCaller(caller: _callers[index]),
                callback: _focus,
              );
            }),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _missions.length < _itemLimit ? _missions.length : _itemLimit,
            itemBuilder: (context, index) {
              _itemIndex++;
              return EntryFastSearch(
                index: _itemIndex,
                icon: "assets/graphics/icons/missions.svg",
                text: _missions.elementAt(index).getName(context.locale),
                subText: HelperJSON.getMissionGiver(_missions.elementAt(index).giverId).getName(context.locale),
                activity: ActivityDetailMission(mission: _missions[index]),
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
