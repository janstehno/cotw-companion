// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                ? Container()
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

  Widget _buildAmmoDetail(bool leftToRight, String icon, String text) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        height: 32.5,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          leftToRight
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    text,
                    style: Interface.s16w300n(Interface.dark),
                  )),
          SvgPicture.asset(
            "assets/graphics/icons/$icon.svg",
            width: 15,
            height: 15,
            colorFilter: ColorFilter.mode(
              Interface.dark,
              BlendMode.srcIn,
            ),
          ),
          leftToRight
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    style: Interface.s16w300n(Interface.dark),
                  ))
              : Container()
        ]));
  }

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      _buildAmmoTitle(),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildAmmoDetail(true, "min_max", _ammo.classRange),
              _buildAmmoDetail(false, "weapon_penetration", _ammo.penetration.toString())
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildAmmoDetail(true, "range", _ammo.getRange(_imperialUnits)),
              _buildAmmoDetail(false, "weapon_expansion", _ammo.expansion.toString())
            ])
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
