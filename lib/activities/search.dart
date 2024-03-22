import 'package:cotwcompanion/activities/detail/ammo.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/activities/detail/fur.dart';
import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/activities/detail/reserve.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
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

  List<Reserve> get _reserves => HelperFilter.filterReserves(_controller.text);

  List<Animal> get _animals => HelperFilter.filterAnimals(_controller.text, context);

  List<Fur> get _furs => HelperFilter.filterFurs(_controller.text);

  List<Weapon> get _weapons => HelperFilter.filterWeapons(_controller.text);

  List<Ammo> get _ammo => HelperFilter.filterAmmo(_controller.text);

  List<Caller> get _callers => HelperFilter.filterCallers(_controller.text);

  List<Mission> get _missions => HelperFilter.filterMissions(_controller.text);

  int _itemIndex = 0;
  int _itemLimit = 0;

  @override
  void initState() {
    _controller.addListener(() => _filter());
    super.initState();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  void _filter() {
    setState(() {
      _itemIndex = 0;
      _itemLimit = _controller.text.length * 2;
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
    return _reserves.map((e) => _buildReserve(e)).take(_itemLimit).toList();
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
    return _animals.map((e) => _buildAnimal(e)).take(_itemLimit).toList();
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
    return _furs.skipWhile((e) => e.id == Values.greatOneId).map((e) => _buildFur(e)).take(_itemLimit).toList();
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
    return _weapons.map((e) => _buildWeapon(e)).take(_itemLimit).toList();
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
    return _ammo.map((e) => _buildAmmo(e)).take(_itemLimit).toList();
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
    return _callers.map((e) => _buildCaller(e)).take(_itemLimit).toList();
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
    return _missions.map((e) => _buildMission(e)).take(_itemLimit).toList();
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
