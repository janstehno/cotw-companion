// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_ammo.dart';
import 'package:cotwcompanion/lists/weapon_info/weapon_animals.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    text,
                    style: Interface.s16w300n(Interface.dark),
                  )),
          SvgPicture.asset(
            icon,
            width: 18,
            height: 18,
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
              : const SizedBox.shrink()
        ]));
  }

  Widget _buildStatistics() {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        tr('weapon_type'),
                        maxLines: 1,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              Text(
                _weapon.getTypeAsString(),
                style: Interface.s18w500n(Interface.dark),
              )
            ]),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(
                            tr('price'),
                            maxLines: 1,
                            style: Interface.s16w300n(Interface.dark),
                          ))),
                  Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    _weapon.price == 0 || _weapon.price == -1
                        ? const SizedBox.shrink()
                        : Container(
                            margin: const EdgeInsets.only(right: 2.5),
                            child: SvgPicture.asset(
                              "assets/graphics/icons/money.svg",
                              width: 15,
                              height: 15,
                              colorFilter: ColorFilter.mode(
                                Interface.dark,
                                BlendMode.srcIn,
                              ),
                            )),
                    AutoSizeText(
                      _weapon.price == 0
                          ? tr('free')
                          : _weapon.price == -1
                              ? tr('none')
                              : "${_weapon.price}",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: Interface.s18w500n(Interface.dark),
                    )
                  ])
                ])),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        tr('weapon_magazine'),
                        maxLines: 1,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              Text(
                _weapon.id == 21 ? "1/2" : _weapon.mag.toString(),
                style: Interface.s18w500n(Interface.dark),
              )
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
      WidgetTitleBig(
        primaryText: tr('weapon_ammo'),
      ),
      ListWeaponAmmo(weaponId: _weapon.id),
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('recommended_animals'),
      ),
      ListWeaponAnimals(
        min: _weapon.min,
        max: _weapon.max,
      ),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _weapon.getName(context.locale),
          maxLines: _weapon.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
          _buildAmmo(),
          _buildAnimals(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
