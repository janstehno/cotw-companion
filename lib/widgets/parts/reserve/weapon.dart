import 'package:collection/collection.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetReserveWeapon extends WidgetSectionIndicatorTap {
  final Weapon _weapon;

  WidgetReserveWeapon(
    Weapon weapon, {
    super.key,
    super.color,
    super.indicatorColor,
    super.background,
    required super.isShown,
    required super.onTap,
  })  : _weapon = weapon,
        super(weapon.name, indicatorSize: Values.dotSize);

  @override
  Widget buildTitle() {
    List<int> weaponLevels = _weapon.levels;
    int min = weaponLevels.min;
    int max = weaponLevels.max;

    return Row(
      children: [
        WidgetMargin.right(
          15,
          child: WidgetText(
            min == max ? min.toString() : "$min - $max",
            color: Interface.disabled,
            style: Style.normal.s12.w500,
          ),
        ),
        Expanded(
          child: WidgetText(
            text,
            color: titleColor,
            style: Style.normal.s16.w300,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }
}
