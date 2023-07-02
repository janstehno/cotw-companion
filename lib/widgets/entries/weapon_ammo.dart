// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryWeaponAmmo extends StatefulWidget {
  final int ammoId, index;

  const EntryWeaponAmmo({
    Key? key,
    required this.ammoId,
    required this.index,
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
          child: WidgetTitle.sub(
        text: _ammo.getName(context.locale),
        background: Interface.subSubTitleBackground,
      )),
      Container(
          height: 75,
          color: Interface.subSubTitleBackground,
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
                      color: Interface.disabled,
                    )),
            AutoSizeText(
                _ammo.price == 0
                    ? tr('free')
                    : _ammo.price == -1
                        ? tr('none')
                        : "${_ammo.price}",
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Interface.disabled,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ))
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
                  child: Text(text,
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w400,
                      ))),
          SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
            color: Interface.dark,
          ),
          leftToRight
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(text,
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w400,
                      )))
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
              _buildAmmoDetail(true, "assets/graphics/icons/min_max.svg", _ammo.classRange),
              _buildAmmoDetail(false, "assets/graphics/icons/weapon_penetration.svg", _ammo.penetration.toString())
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildAmmoDetail(true, "assets/graphics/icons/range.svg", _ammo.getRange(_imperialUnits)),
              _buildAmmoDetail(false, "assets/graphics/icons/weapon_expansion.svg", _ammo.expansion.toString())
            ])
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
