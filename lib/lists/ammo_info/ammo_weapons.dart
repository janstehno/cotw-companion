import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:flutter/material.dart';

class ListAmmoWeapons extends StatelessWidget {
  final Ammo _ammo;

  const ListAmmoWeapons(
    Ammo ammo, {
    super.key,
  }) : _ammo = ammo;

  List<Weapon> get _weapons => HelperJSON.getAmmoWeapons(_ammo.id).sorted(Weapon.sortByTypeName);

  Widget _buildWeapon(Weapon weapon) {
    return WidgetTextIndicator(
      weapon.name,
      indicatorColor: Interface.primary,
      isShown: weapon.isFromDlc,
    );
  }

  List<Widget> _listWeapons() {
    return _weapons.map((e) => _buildWeapon(e)).toList();
  }

  Widget _buildWidgets() {
    return Column(children: _listWeapons());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
