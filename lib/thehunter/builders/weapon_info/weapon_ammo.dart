// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/ammo.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/widgets/weapon_ammo.dart';
import 'package:flutter/material.dart';

class BuilderWeaponAmmo extends StatefulWidget {
  final int weaponID;

  const BuilderWeaponAmmo({Key? key, required this.weaponID}) : super(key: key);

  @override
  BuilderWeaponAmmoState createState() => BuilderWeaponAmmoState();
}

class BuilderWeaponAmmoState extends State<BuilderWeaponAmmo> {
  late final List<Ammo> _ammo = [];

  _getAmmo() {
    _ammo.clear();
    for (IDtoID iti in JSONHelper.weaponsAmmo) {
      if (iti.getFirstID == widget.weaponID) {
        for (Ammo a in JSONHelper.ammo) {
          if (a.getID == iti.getSecondID) {
            _ammo.add(a);
            break;
          }
        }
      }
    }
    _ammo.sort((a, b) => a.getMin.compareTo(b.getMin));
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _ammo.length,
        itemBuilder: (context, index) {
          int ammoID = _ammo[index].getID;
          return EntryWeaponAmmo(ammoID: ammoID, index: index);
        });
  }

  @override
  Widget build(BuildContext context) {
    _getAmmo();
    return _buildWidgets();
  }
}
