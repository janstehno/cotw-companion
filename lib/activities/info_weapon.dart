// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/weapon_info/weapon_ammo.dart';
import 'package:cotwcompanion/builders/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityWeaponInfo extends StatefulWidget {
  final int weaponId;

  const ActivityWeaponInfo({
    Key? key,
    required this.weaponId,
  }) : super(key: key);

  @override
  ActivityWeaponInfoState createState() => ActivityWeaponInfoState();
}

class ActivityWeaponInfoState extends State<ActivityWeaponInfo> {
  late final Weapon _weapon;

  @override
  void initState() {
    _weapon = HelperJSON.getWeapon(widget.weaponId);
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(tr('weapon_type'),
                          maxLines: 1,
                          style: TextStyle(
                            color: Interface.dark,
                            fontSize: Interface.s20,
                            fontWeight: FontWeight.w400,
                          )))),
              Text(_weapon.getTypeAsString(),
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s24,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(tr('weapon_magazine'),
                              maxLines: 1,
                              style: TextStyle(
                                color: Interface.dark,
                                fontSize: Interface.s20,
                                fontWeight: FontWeight.w400,
                              )))),
                  Text(_weapon.id == 21 ? "1/2" : _weapon.mag.toString(),
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w600,
                      ))
                ]))
          ]))
    ]);
  }

  Widget _buildAmmo() {
    return Column(children: [
      WidgetTitle(
        text: tr('weapon_ammo'),
      ),
      BuilderWeaponAmmo(weaponId: _weapon.id),
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitle(
        text: tr('recommended_animals'),
      ),
      BuilderWeaponAnimals(weaponId: _weapon.id),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
            height: 150,
            text: _weapon.getName(context.locale),
            maxLines: _weapon.getName(context.locale).split(" ").length == 1 ? 1 : 2,
            color: Interface.accent,
            background: Interface.primary,
            fontSize: Interface.s40,
            context: context),
        children: [
          _buildStatistics(),
          _buildAmmo(),
          _buildAnimals(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
