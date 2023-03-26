// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/widgets/entries/weapon_ammo.dart';
import 'package:flutter/material.dart';

class BuilderWeaponAmmo extends StatefulWidget {
  final int weaponId;

  const BuilderWeaponAmmo({
    Key? key,
    required this.weaponId,
  }) : super(key: key);

  @override
  BuilderWeaponAmmoState createState() => BuilderWeaponAmmoState();
}

class BuilderWeaponAmmoState extends State<BuilderWeaponAmmo> {
  late final List<dynamic> _ammo = [];

  @override
  void initState() {
    _getWeapon();
    super.initState();
  }

  void _getWeapon() {
    _ammo.addAll(HelperJSON.getWeapon(widget.weaponId).ammo);
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _ammo.length,
        itemBuilder: (context, index) {
          return EntryWeaponAmmo(
            ammoId: _ammo[index],
            index: index,
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
