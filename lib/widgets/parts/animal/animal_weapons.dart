import 'package:cotwcompanion/lists/animal_info/animal_weapons.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimalWeapons extends StatelessWidget {
  final Animal _animal;

  const WidgetAnimalWeapons(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  List<Widget> _listSubWeapons(String subtitle, WeaponType weaponType) {
    return [
      WidgetSubtitle(subtitle),
      ListAnimalWeapons(
        _animal.level,
        weaponType: weaponType,
      ),
    ];
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        ..._listSubWeapons(tr("WEAPONS_RIFLES"), WeaponType.rifle),
        ..._listSubWeapons(tr("WEAPONS_SHOTGUNS"), WeaponType.shotgun),
        ..._listSubWeapons(tr("WEAPONS_HANDGUNS"), WeaponType.handgun),
        ..._listSubWeapons(tr("WEAPONS_BOWS_CROSSBOWS"), WeaponType.bow),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
