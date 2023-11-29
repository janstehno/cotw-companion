// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/entries/ammo_statistics.dart';
import 'package:cotwcompanion/widgets/entries/parameter.dart';
import 'package:cotwcompanion/widgets/price.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryWeaponAmmo extends StatefulWidget {
  final Ammo ammo;

  const EntryWeaponAmmo({
    Key? key,
    required this.ammo,
  }) : super(key: key);

  @override
  EntryWeaponAmmoState createState() => EntryWeaponAmmoState();
}

class EntryWeaponAmmoState extends State<EntryWeaponAmmo> {
  late final bool _imperialUnits;

  @override
  void initState() {
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    super.initState();
  }

  Widget _buildRequirements() {
    return widget.ammo.hasRequirements
        ? Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: EntryParameter(
              text: tr("requirement_score"),
              value: widget.ammo.score,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: EntryParameterPrice(price: widget.ammo.price),
        ),
        _buildRequirements(),
        EntryAmmoStatistics(
          ammo: widget.ammo,
          imperialUnits: _imperialUnits,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
