// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/ammo_info/ammo_weapons.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/weapon/ammo.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailAmmo extends StatefulWidget {
  final Ammo ammo;

  const ActivityDetailAmmo({
    Key? key,
    required this.ammo,
  }) : super(key: key);

  @override
  ActivityDetailAmmoState createState() => ActivityDetailAmmoState();
}

class ActivityDetailAmmoState extends State<ActivityDetailAmmo> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildWeapons() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("weapons"),
      ),
      ListAmmoWeapons(ammoId: widget.ammo.id),
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("recommended_animals"),
      ),
      ListWeaponAnimals(
        min: widget.ammo.min,
        max: widget.ammo.max,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.ammo.getName(context.locale),
          maxLines: widget.ammo.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          EntryWeaponAmmo(ammo: widget.ammo),
          _buildWeapons(),
          _buildAnimals(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
