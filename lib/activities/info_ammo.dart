// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/lists/ammo_info/ammo_weapons.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/ammo_statistics.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:cotwcompanion/widgets/title_small_price.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityAmmoInfo extends StatefulWidget {
  final int ammoId;

  const ActivityAmmoInfo({
    Key? key,
    required this.ammoId,
  }) : super(key: key);

  @override
  ActivityAmmoInfoState createState() => ActivityAmmoInfoState();
}

class ActivityAmmoInfoState extends State<ActivityAmmoInfo> {
  late final Ammo _ammo;
  late final bool _imperialUnits;

  @override
  void initState() {
    _ammo = HelperJSON.getAmmo(widget.ammoId);
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    super.initState();
  }

  Widget _buildAmmoPrice() {
    return Row(children: [
      Expanded(
        child: WidgetTitleSmall(
          primaryText: tr("price"),
        ),
      ),
      WidgetTitleSmallPrice(
        primaryText: _ammo.price.toString(),
      ),
    ]);
  }

  Widget _buildStatistics() {
    return Column(
      children: [
        EntryAmmoStatistics(
          ammo: _ammo,
          imperialUnits: _imperialUnits,
        ),
        _buildAmmoPrice(),
      ],
    );
  }

  Widget _buildWeapons() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("weapons"),
      ),
      ListAmmoWeapons(ammoId: _ammo.id),
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("recommended_animals"),
      ),
      ListWeaponAnimals(
        min: _ammo.min,
        max: _ammo.max,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _ammo.getName(context.locale),
          maxLines: _ammo.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
          _buildWeapons(),
          _buildAnimals(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
