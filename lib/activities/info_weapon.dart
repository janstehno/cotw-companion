// Copyright (c) 2022 - 2023 Jan Stehno

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
import 'package:flutter_svg/flutter_svg.dart';

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

  Widget _buildWeaponDetail(bool leftToRight, String icon, String text) {
    return Container(
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
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w600,
                      ))),
          SvgPicture.asset(
            icon,
            width: 18,
            height: 18,
            color: Interface.dark,
          ),
          leftToRight
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(text,
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s22,
                        fontWeight: FontWeight.w600,
                      )))
              : Container()
        ]));
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(tr('price'),
                              maxLines: 1,
                              style: TextStyle(
                                color: Interface.dark,
                                fontSize: Interface.s20,
                                fontWeight: FontWeight.w400,
                              )))),
                  Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    _weapon.price == 0 || _weapon.price == -1
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(right: 2.5),
                            padding: const EdgeInsets.only(top: 1.15),
                            child: SvgPicture.asset(
                              "assets/graphics/icons/money.svg",
                              width: 14,
                              height: 14,
                              color: Interface.dark,
                            )),
                    AutoSizeText(
                        _weapon.price == 0
                            ? tr('free')
                            : _weapon.price == -1
                                ? tr('none')
                                : "${_weapon.price}",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Interface.dark,
                          fontSize: Interface.s24,
                          fontWeight: FontWeight.w600,
                        ))
                  ])
                ])),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            ]),
            Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    _buildWeaponDetail(true, "assets/graphics/icons/weapon_accuracy.svg", _weapon.accuracy == -1 ? tr('none') : _weapon.accuracy.toString()),
                    _buildWeaponDetail(false, "assets/graphics/icons/weapon_recoil.svg", _weapon.recoil == -1 ? tr('none') : _weapon.recoil.toString())
                  ]),
                  Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    _buildWeaponDetail(true, "assets/graphics/icons/weapon_reload.svg", _weapon.reload == -1 ? tr('none') : _weapon.reload.toString()),
                    _buildWeaponDetail(false, "assets/graphics/icons/weapon_hipshot.svg", _weapon.hipshot == -1 ? tr('none') : _weapon.hipshot.toString())
                  ])
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
