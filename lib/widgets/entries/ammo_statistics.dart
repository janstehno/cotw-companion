// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryAmmoStatistics extends StatelessWidget {
  final Ammo ammo;
  final bool imperialUnits;

  const EntryAmmoStatistics({
    Key? key,
    required this.ammo,
    required this.imperialUnits,
  }) : super(key: key);

  Widget _buildAmmoDetail(bool leftToRight, String icon, String text) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
              : const SizedBox.shrink()
        ]));
  }

  Widget _buildWidgets() {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildAmmoDetail(true, "min_max", ammo.classRange), _buildAmmoDetail(false, "weapon_penetration", ammo.penetration.toString())]),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildAmmoDetail(true, "range", ammo.getRange(imperialUnits)), _buildAmmoDetail(false, "weapon_expansion", ammo.expansion.toString())])
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
