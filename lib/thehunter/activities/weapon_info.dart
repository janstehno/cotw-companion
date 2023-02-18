// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/weapon_info/weapon_ammo.dart';
import 'package:cotwcompanion/thehunter/builders/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityWeaponInfo extends StatefulWidget {
  final int weaponID;

  const ActivityWeaponInfo({Key? key, required this.weaponID}) : super(key: key);

  @override
  ActivityWeaponInfoState createState() => ActivityWeaponInfoState();
}

class ActivityWeaponInfoState extends State<ActivityWeaponInfo> {
  late final Weapon _weapon;

  @override
  void initState() {
    _weapon = JSONHelper.getWeapon(widget.weaponID);
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(children: [
      WidgetContainer(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(tr('weapon_type'),
                      maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
          Text(_weapon.getTypeAsString(), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
        ]),
        Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(tr('weapon_magazine'),
                          maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
              Text(_weapon.getID == 21 ? "1/2" : _weapon.getMag.toString(),
                  style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
            ]))
      ]))
    ]);
  }

  Widget _buildAmmo() {
    return Column(children: [WidgetTitle.sub(text: tr('weapon_ammo')), BuilderWeaponAmmo(weaponID: _weapon.getID)]);
  }

  Widget _buildAnimals() {
    return Column(children: [WidgetTitle.sub(text: tr('recommended_animals')), BuilderWeaponAnimals(weaponID: _weapon.getID)]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          height: 150,
          text: _weapon.getName(context.locale),
          maxLines: _weapon.getName(context.locale).split(" ").length == 1 ? 1 : 2,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize40,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildStatistics(), _buildAmmo(), _buildAnimals()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
