import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/ammo.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/activities/detail/fur.dart';
import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/activities/detail/reserve.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/filters/search.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/parts/items/item_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetHomeSearch extends StatefulWidget {
  const WidgetHomeSearch({
    super.key,
  });

  @override
  WidgetHomeSearchState createState() => WidgetHomeSearchState();
}

class WidgetHomeSearchState extends State<WidgetHomeSearch> {
  final TextEditingController _controller = TextEditingController();
  final FilterSearch _filter = FilterSearch();

  int _itemLimit = 1;

  late Timer _timer;
  String _hintText = "";

  final List<String> _names = [
    ...HelperJSON.animals.map((a) => a.name),
    ...HelperJSON.weapons.map((a) => a.name),
    ...HelperJSON.furs.skipWhile((f) => f.isGreatOne || f.isMission).map((a) => a.name).shuffled().take(15),
    ...HelperJSON.reserves.map((a) => a.name),
    ...HelperJSON.callers.map((a) => a.name),
  ];

  int _hintIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  bool _hasFocus = false;

  @override
  void initState() {
    _controller.addListener(() => _onFocusChange());
    _names.shuffle();
    _startTypingAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _focus() {
    _hasFocus = false;
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = FocusScope.of(context).hasFocus;
      if (_hasFocus) {
        _itemLimit = (_controller.text.length * 1.5).round();
        _hintText = "";
        _timer.cancel();
      } else {
        _startTypingAnimation();
      }
    });
  }

  void _startTypingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      if (_hasFocus) return;

      setState(() {
        if (!_deleting) {
          if (_charIndex < _names[_hintIndex].length) {
            _hintText = _names[_hintIndex].substring(0, _charIndex + 1);
            _charIndex++;
          } else {
            _deleting = true;
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _hintText = "";
                _charIndex = 0;
                _hintIndex = (_hintIndex + 1) % _names.length;
                _deleting = false;
              });
            });
          }
        }
      });
    });
  }

  Widget _buildAnimal(Animal animal) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.wildlife,
      text: animal.getNameByLocale(context.locale),
      activity: ActivityDetailAnimal(animal),
      onTap: _focus,
    );
  }

  List<Widget> _listAnimals() {
    List<Translatable> animals =
        _filter.filterAnimals(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return animals.take(_itemLimit).map((e) => _buildAnimal(e as Animal)).toList();
  }

  Widget _buildReserve(Reserve reserve) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.reserve,
      text: reserve.name,
      activity: ActivityDetailReserve(reserve),
      onTap: _focus,
    );
  }

  List<Widget> _listReserves() {
    List<Translatable> reserves =
        _filter.filterReserves(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return reserves.take(_itemLimit).map((e) => _buildReserve(e as Reserve)).toList();
  }

  Widget _buildWeapon(Weapon weapon) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.weapon,
      text: weapon.name,
      activity: ActivityDetailWeapon(weapon),
      onTap: _focus,
    );
  }

  List<Widget> _listWeapons() {
    List<Translatable> weapons =
        _filter.filterWeapons(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return weapons.take(_itemLimit).map((e) => _buildWeapon(e as Weapon)).toList();
  }

  Widget _buildCaller(Caller caller) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.caller,
      text: caller.name,
      activity: ActivityDetailCaller(caller),
      onTap: _focus,
    );
  }

  List<Widget> _listCallers() {
    List<Translatable> callers =
        _filter.filterCallers(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return callers.take(_itemLimit).map((e) => _buildCaller(e as Caller)).toList();
  }

  Widget _buildFur(Fur fur) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.fur,
      text: fur.name,
      activity: ActivityDetailFur(fur),
      onTap: _focus,
    );
  }

  List<Widget> _listFurs() {
    List<Translatable> furs =
        _filter.filterFurs(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return furs
        .where((e) => !(e as Fur).isMission && !e.isGreatOne)
        .take(_itemLimit)
        .map((e) => _buildFur(e as Fur))
        .toList();
  }

  Widget _buildAmmo(Ammo ammo) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.harvestCorrectAmmo,
      text: ammo.name,
      activity: ActivityDetailAmmo(ammo),
      onTap: _focus,
    );
  }

  List<Widget> _listAmmo() {
    List<Translatable> ammo =
        _filter.filterAmmo(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return ammo.take(_itemLimit).map((e) => _buildAmmo(e as Ammo)).toList();
  }

  Widget _buildMission(Mission mission) {
    return WidgetItemSearch(
      icon: Assets.graphics.icons.missions,
      text: mission.name,
      activity: ActivityDetailMission(mission),
      onTap: _focus,
    );
  }

  List<Widget> _listMissions() {
    List<Translatable> missions =
        _filter.filterMissions(_controller.text).sorted((a, b) => a.name.length.compareTo(b.name.length));
    return missions.take(_itemLimit).map((e) => _buildMission(e as Mission)).toList();
  }

  List<Widget> _listFiltered() {
    return [
      ..._listAnimals(),
      ..._listReserves(),
      ..._listWeapons(),
      ..._listCallers(),
      ..._listFurs(),
      ..._listAmmo(),
      ..._listMissions(),
    ];
  }

  Widget _buildItems() {
    return WidgetScrollBar(
      child: ListView.builder(
        itemCount: _listFiltered().length,
        itemBuilder: (item, index) => _listFiltered().elementAt(index),
      ),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        WidgetSearchBar(controller: _controller, hintText: _hintText),
        Expanded(child: _buildItems()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
