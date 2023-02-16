// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/ammo.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EntryWeaponAmmo extends StatefulWidget {
  final int ammoID;
  final int index;

  const EntryWeaponAmmo({Key? key, required this.ammoID, required this.index}) : super(key: key);

  @override
  EntryWeaponAmmoState createState() => EntryWeaponAmmoState();
}

class EntryWeaponAmmoState extends State<EntryWeaponAmmo> {
  late final Ammo _ammo;

  late bool _units;

  @override
  void initState() {
    _ammo = JSONHelper.getAmmo(widget.ammoID);
    _units = Provider.of<Settings>(context, listen: false).getImperialUnits;
    super.initState();
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
                  child: Text(text, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400))),
          SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
            color: Color(Values.colorDark),
          ),
          leftToRight
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(text, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400)))
              : Container()
        ]));
  }

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      WidgetTitle.detail(text: _ammo.getName(context.locale)),
      WidgetContainer(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildAmmoDetail(true, "assets/graphics/icons/min_max.svg", _ammo.getMinMax),
              _buildAmmoDetail(false, "assets/graphics/icons/weapon_penetration.svg", _ammo.getPenetration.toString())
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildAmmoDetail(true, "assets/graphics/icons/range.svg", _ammo.getRange(_units)),
              _buildAmmoDetail(false, "assets/graphics/icons/weapon_expansion.svg", _ammo.getExpansion.toString())
            ])
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
