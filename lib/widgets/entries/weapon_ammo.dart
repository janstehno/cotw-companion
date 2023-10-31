// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/entries/ammo_statistics.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:cotwcompanion/widgets/title_small_price.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryWeaponAmmo extends StatefulWidget {
  final int index, ammoId;

  const EntryWeaponAmmo({
    Key? key,
    required this.index,
    required this.ammoId,
  }) : super(key: key);

  @override
  EntryWeaponAmmoState createState() => EntryWeaponAmmoState();
}

class EntryWeaponAmmoState extends State<EntryWeaponAmmo> {
  late final Ammo _ammo;
  late final bool _imperialUnits;

  @override
  void initState() {
    _ammo = HelperJSON.getAmmo(widget.ammoId);
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    super.initState();
  }

  Widget _buildAmmoTitle() {
    return Row(children: [
      Expanded(
        child: WidgetTitleSmall(
          primaryText: _ammo.getName(context.locale),
        ),
      ),
      WidgetTitleSmallPrice(
        primaryText: _ammo.price.toString(),
      ),
    ]);
  }

  Widget _buildWidgets() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildAmmoTitle(),
        EntryAmmoStatistics(
          ammo: _ammo,
          imperialUnits: _imperialUnits,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
