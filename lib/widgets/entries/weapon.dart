// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_weapon.dart';
import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/entries/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryWeapon extends StatefulWidget {
  final int index;
  final Weapon weapon;
  final Function callback;

  const EntryWeapon({
    Key? key,
    required this.index,
    required this.weapon,
    required this.callback,
  }) : super(key: key);

  @override
  EntryWeaponState createState() => EntryWeaponState();
}

class EntryWeaponState extends State<EntryWeapon> {
  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityWeaponInfo(weaponId: widget.weapon.id)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
            child: EntryItem(
                text: widget.weapon.getName(context.locale),
                itemIcon: Graphics.getWeaponIcon(widget.weapon.id),
                tags: [
                  WidgetTag.medium(
                    icon: "assets/graphics/icons/dlc.svg",
                    color: Interface.accent,
                    background: Interface.primary,
                    margin: const EdgeInsets.only(right: 5),
                    isVisible: widget.weapon.isFromDlc,
                  ),
                  WidgetTag.medium(
                    text: "${widget.weapon.min} - ${widget.weapon.max}",
                    color: Interface.dark,
                    background: Interface.tag,
                    margin: const EdgeInsets.only(right: 5),
                  ),
                  WidgetTag.medium(
                    text: widget.weapon.id == 21 ? "1/2" : widget.weapon.mag.toString(),
                    icon: "assets/graphics/icons/weapon_mag.svg",
                    color: Interface.dark,
                    background: Interface.tag,
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
