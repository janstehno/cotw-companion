import 'package:cotwcompanion/lists/ammo_info/ammo_weapons.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/weapon/ammo.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailAmmo extends StatelessWidget {
  final Ammo _ammo;

  const ActivityDetailAmmo(
    Ammo ammo, {
    super.key,
  }) : _ammo = ammo;

  List<Widget> _listWeapons() {
    return [
      WidgetTitle(tr("WEAPONS")),
      WidgetPadding.a30(child: ListAmmoWeapons(_ammo)),
    ];
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("RECOMMENDED_ANIMALS")),
      ..._ammo.levels.map((e) => ListWeaponAnimals(level: e)),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _ammo.name,
        context: context,
      ),
      children: [
        WidgetWeaponAmmo(_ammo),
        ..._listWeapons(),
        ..._listAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
