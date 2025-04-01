import 'package:cotwcompanion/activities/detail/ammo.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/activities/detail/fur.dart';
import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/activities/detail/reserve.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/filters/search.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/items/item_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivitySearch extends StatefulWidget {
  const ActivitySearch({
    super.key,
  });

  @override
  ActivitySearchState createState() => ActivitySearchState();
}

class ActivitySearchState extends State<ActivitySearch> {
  final TextEditingController _controller = TextEditingController();
  final FilterSearch _filter = FilterSearch();

  int _itemIndex = 0;
  int _itemLimit = 0;

  @override
  void initState() {
    _controller.addListener(() => _filterItems());
    super.initState();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void _filterItems() {
    setState(() {
      _itemIndex = 0;
      _itemLimit = 1;
    });
  }

  Widget _buildReserve(Reserve reserve) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.reserve,
      text: reserve.name,
      activity: ActivityDetailReserve(reserve),
      onTap: _focus,
    );
  }

  List<Widget> _listReserves() {
    List<Translatable> reserves = _filter.filterReserves(_controller.text);
    return reserves.map((e) => _buildReserve(e as Reserve)).take(_itemLimit).toList();
  }

  Widget _buildAnimal(Animal animal) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.wildlife,
      text: animal.getNameByLocale(context.locale),
      activity: ActivityDetailAnimal(animal),
      onTap: _focus,
    );
  }

  List<Widget> _listAnimals() {
    List<Translatable> animals = _filter.filterAnimals(_controller.text);
    return animals.map((e) => _buildAnimal(e as Animal)).take(_itemLimit).toList();
  }

  Widget _buildFur(Fur fur) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.fur,
      text: fur.name,
      activity: ActivityDetailFur(fur),
      onTap: _focus,
    );
  }

  List<Widget> _listFurs() {
    List<Translatable> furs = _filter.filterFurs(_controller.text);
    return furs
        .skipWhile((e) => (e as Fur).isMission || e.isGreatOne)
        .map((e) => _buildFur(e as Fur))
        .take(_itemLimit)
        .toList();
  }

  Widget _buildWeapon(Weapon weapon) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.weapon,
      text: weapon.name,
      activity: ActivityDetailWeapon(weapon),
      onTap: _focus,
    );
  }

  List<Widget> _listWeapons() {
    List<Translatable> weapons = _filter.filterWeapons(_controller.text);
    return weapons.map((e) => _buildWeapon(e as Weapon)).take(_itemLimit).toList();
  }

  Widget _buildAmmo(Ammo ammo) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.harvestCorrectAmmo,
      text: ammo.name,
      activity: ActivityDetailAmmo(ammo),
      onTap: _focus,
    );
  }

  List<Widget> _listAmmo() {
    List<Translatable> ammo = _filter.filterAmmo(_controller.text);
    return ammo.map((e) => _buildAmmo(e as Ammo)).take(_itemLimit).toList();
  }

  Widget _buildCaller(Caller caller) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.caller,
      text: caller.name,
      activity: ActivityDetailCaller(caller),
      onTap: _focus,
    );
  }

  List<Widget> _listCallers() {
    List<Translatable> callers = _filter.filterCallers(_controller.text);
    return callers.map((e) => _buildCaller(e as Caller)).take(_itemLimit).toList();
  }

  Widget _buildMission(Mission mission) {
    return WidgetItemSearch(
      _itemIndex++,
      icon: Assets.graphics.icons.missions,
      text: mission.name,
      subtext: mission.person,
      activity: ActivityDetailMission(mission),
      onTap: _focus,
    );
  }

  List<Widget> _listMissions() {
    List<Translatable> missions = _filter.filterMissions(_controller.text);
    return missions.map((e) => _buildMission(e as Mission)).take(_itemLimit).toList();
  }

  List<Widget> _listFiltered() {
    return [
      ..._listReserves(),
      ..._listAnimals(),
      ..._listFurs(),
      ..._listWeapons(),
      ..._listAmmo(),
      ..._listCallers(),
      ..._listMissions(),
    ];
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("SEARCH"),
        context: context,
      ),
      searchController: _controller,
      children: _listFiltered(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
