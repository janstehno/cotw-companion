// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryWeaponStatistics extends StatelessWidget {
  final Weapon weapon;

  final double height = 65;

  final double _iconSize = 15;

  const EntryWeaponStatistics({
    Key? key,
    required this.weapon,
  }) : super(key: key);

  Widget _buildWeaponDetail(bool leftToRight, String icon, String text) {
    return Container(
        alignment: Alignment.center,
        height: height / 2,
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
            "assets/graphics/icons/$icon.svg",
            width: _iconSize,
            height: _iconSize,
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

  Widget _buildWidgets() {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeaponDetail(true, "weapon_accuracy", weapon.accuracy == -1 ? tr('none') : weapon.accuracy.toString()),
                _buildWeaponDetail(false, "weapon_recoil", weapon.recoil == -1 ? tr('none') : weapon.recoil.toString())
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeaponDetail(true, "weapon_reload", weapon.reload == -1 ? tr('none') : weapon.reload.toString()),
                _buildWeaponDetail(false, "weapon_hipshot", weapon.hipshot == -1 ? tr('none') : weapon.hipshot.toString())
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
