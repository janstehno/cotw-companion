// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/info_weapon.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
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
  List<WidgetTag> _buildTags() {
    List<WidgetTag> tags = [];
    if (widget.weapon.isFromDlc) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/dlc.svg",
        color: Interface.accent,
        background: Interface.primary,
      ));
    }
    tags.addAll([
      WidgetTag.big(
        value: widget.weapon.min == widget.weapon.max ? "${widget.weapon.min}" : "${widget.weapon.min} - ${widget.weapon.max}",
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: "assets/graphics/icons/weapon_mag.svg",
        value: widget.weapon.id == 21 ? "1/2" : widget.weapon.mag.toString(),
        color: Interface.dark,
        background: Interface.tag,
      )
    ]);
    return tags;
  }

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
              tags: _buildTags(),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
