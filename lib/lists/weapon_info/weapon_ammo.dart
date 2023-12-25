// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/entries/weapon/ammo.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeaponAmmo extends StatefulWidget {
  final int weaponId;

  const ListWeaponAmmo({
    Key? key,
    required this.weaponId,
  }) : super(key: key);

  @override
  ListWeaponAmmoState createState() => ListWeaponAmmoState();
}

class ListWeaponAmmoState extends State<ListWeaponAmmo> {
  late final List<dynamic> _ammo = [];

  void _getWeapon() {
    _ammo.addAll(HelperJSON.getWeapon(widget.weaponId).ammo);
  }

  Widget _buildWidgets() {
    _getWeapon();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _ammo.length,
        itemBuilder: (context, index) {
          Ammo ammo = HelperJSON.getAmmo(_ammo[index]);
          return Column(
            children: [
              WidgetTitleSmall(
                primaryText: ammo.getName(context.locale),
              ),
              EntryWeaponAmmo(
                ammo: ammo,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
