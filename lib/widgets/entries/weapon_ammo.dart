// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/entries/ammo_statistics.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryWeaponAmmo extends StatefulWidget {
  final int index, ammoId;

  const EntryWeaponAmmo({
    Key? key,
    this.index = 0,
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
    _imperialUnits = Provider.of<Settings>(context, listen: false).getImperialUnits;
    super.initState();
  }

  Widget _buildAmmoTitle() {
    return Row(children: [
      Expanded(
          child: WidgetTitleSmall(
        primaryText: _ammo.getName(context.locale),
      )),
      Container(
          height: 50,
          color: Interface.light,
          padding: const EdgeInsets.only(right: 25),
          alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            _ammo.price == 0 || _ammo.price == -1
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(right: 2.5),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/money.svg",
                      width: 10,
                      height: 10,
                      colorFilter: ColorFilter.mode(
                        Interface.disabled,
                        BlendMode.srcIn,
                      ),
                    )),
            AutoSizeText(
              _ammo.price == 0
                  ? tr('free')
                  : _ammo.price == -1
                      ? tr('none')
                      : "${_ammo.price}",
              maxLines: 1,
              textAlign: TextAlign.start,
              style: Interface.s12w300n(Interface.disabled),
            )
          ])),
    ]);
  }

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      _buildAmmoTitle(),
      EntryAmmoStatistics(
        ammo: _ammo,
        imperialUnits: _imperialUnits,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
