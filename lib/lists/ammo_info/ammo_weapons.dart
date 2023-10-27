// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListAmmoWeapons extends StatefulWidget {
  final int ammoId;

  const ListAmmoWeapons({
    Key? key,
    required this.ammoId,
  }) : super(key: key);

  @override
  ListAmmoWeaponsState createState() => ListAmmoWeaponsState();
}

class ListAmmoWeaponsState extends State<ListAmmoWeapons> {
  late final List<Weapon> _weapons = [];

  @override
  void initState() {
    _getWeapons();
    super.initState();
  }

  void _getWeapons() {
    for (IdtoId iti in HelperJSON.weaponsAmmo) {
      if (iti.secondId == widget.ammoId) {
        _weapons.add(HelperJSON.getWeapon(iti.firstId));
      }
    }
  }

  Widget _buildWidgets() {
    return Container(
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _weapons.length,
            itemBuilder: (context, index) {
              return WidgetTextDlc(
                text: _weapons[index].getName(context.locale),
                dlc: _weapons[index].isFromDlc,
              );
            }));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
