import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/parts/weapon/ammo.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:flutter/material.dart';

class ListWeaponAmmo extends StatelessWidget {
  final Weapon _weapon;

  const ListWeaponAmmo(
    Weapon weapon, {
    super.key,
  }) : _weapon = weapon;

  List<Ammo> get _ammo => HelperJSON.getWeaponsAmmo(_weapon.id).sorted(Ammo.sortByName);

  Widget _buildAmmo(Ammo ammo) {
    return Column(
      children: [
        WidgetSubtitle(ammo.name),
        WidgetWeaponAmmo(ammo),
      ],
    );
  }

  List<Widget> _listAmmo() {
    return _ammo.map((e) => _buildAmmo(e)).toList();
  }

  Widget _buildWidgets() {
    return Column(children: _listAmmo());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
