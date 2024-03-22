import 'dart:core';

import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/detail/weapon.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/parts/items/item.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';

class WidgetWeapon extends StatelessWidget {
  final int _index;
  final Weapon _weapon;
  final Function _onTap;

  const WidgetWeapon(
    Weapon weapon, {
    super.key,
    required int i,
    required Function onTap,
  })  : _weapon = weapon,
        _index = i,
        _onTap = onTap;

  String get ranges {
    List<int> weaponLevels = _weapon.levels.sorted((a, b) => a.compareTo(b));
    int min = weaponLevels.min;
    int max = weaponLevels.max;
    String ranges = "";
    if (weaponLevels.length == 1) {
      ranges = "$min";
    } else {
      for (int i = 0; i < weaponLevels.length - 1; i++) {
        int current = weaponLevels.elementAt(i);
        int next = weaponLevels.elementAt(i + 1);
        max = current;

        if (current + 1 == next && i + 1 != weaponLevels.length - 1) {
          continue;
        } else if (i + 1 == weaponLevels.length - 1) {
          max = next;
        }

        ranges = "$ranges${min == max ? "$min" : "$min - $max"}";
        if (weaponLevels.indexOf(max) != weaponLevels.length - 1) ranges = "$ranges, ";
        min = next;
      }
    }
    return ranges;
  }

  List<WidgetTag> _listTags() {
    return [
      if (_weapon.isFromDlc)
        WidgetTag.big(
          icon: Assets.graphics.icons.dlc,
          color: Interface.alwaysDark,
          background: Interface.primary,
        ),
      WidgetTag.big(
        value: ranges,
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.big(
        icon: Assets.graphics.icons.weaponMag,
        value: _weapon.id == 21 ? "1/2" : _weapon.mag.toString(),
        color: Interface.dark,
        background: Interface.tag,
      )
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetItem(
      _index,
      text: _weapon.name,
      icon: Graphics.getWeaponIcon(_weapon),
      tags: _listTags(),
      onTap: () {
        _onTap();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => ActivityDetailWeapon(_weapon)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
