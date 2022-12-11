// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/weapon_info.dart';
import 'package:cotwcompanion/thehunter/model/weapon.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_name_image.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_part_tags_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EntryWeapon extends StatefulWidget {
  final Weapon weapon;
  final int index;
  final Function callback;

  const EntryWeapon({Key? key, required this.weapon, required this.index, required this.callback}) : super(key: key);

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
            MaterialPageRoute(builder: (context) => ActivityWeaponInfo(weaponID: widget.weapon.getID)),
          );
        },
        child: Container(
            color: widget.index % 2 == 0 ? Color(Values.colorEven) : Color(Values.colorOdd),
            child: WidgetContainer(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  EntryPartNameImage(text: widget.weapon.getName(context.locale), icon: Graphics.getWeaponIcon(widget.weapon.getID)),
                  EntryPartTagsButton(tags: [
                    WidgetTag.medium(
                    margin: const EdgeInsets.only(right: 5),
                    color: Values.colorAccent,
                    background: Values.colorPrimary,
                    icon: "assets/graphics/icons/dlc.svg",
                    size: 20,
                    visible: widget.weapon.getDlc),
                    WidgetTag.medium(
                    text: widget.weapon.getID == 21 ? "1/2" : widget.weapon.getMag.toString(),
                    icon: "assets/graphics/icons/weapon_mag.svg",
                    color: Values.colorDark,
                    background: Values.colorTag)
              ])
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
