import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/weapons.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/button/switch_operation.dart';
import 'package:cotwcompanion/widgets/filter/picker_auto.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/filter/range_set.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:cotwcompanion/widgets/title/title_icon_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterWeapons extends ActivityFilter<Weapon> {
  const ActivityFilterWeapons({
    super.key,
    required FilterWeapons super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterWeaponsState();
}

class ActivityFilterWeaponsState extends ActivityFilterState<Weapon> {
  List<Widget> _listWeaponType() {
    return [
      WidgetTitleIcon(
        tr("TYPE"),
        icon: Assets.graphics.icons.weapon,
      ),
      WidgetFilterPickerText<WeaponType>(
        filter: widget.filter,
        filterKey: FilterKey.weaponType,
        bitKeys: WeaponType.values,
        labels: [
          tr("WEAPONS_RIFLES"),
          tr("WEAPONS_SHOTGUNS"),
          tr("WEAPONS_HANDGUNS"),
          tr("WEAPONS_BOWS_CROSSBOWS"),
        ],
      ),
    ];
  }

  List<Widget> _listAnimalClass() {
    return [
      WidgetTitleIconSwitch(
        tr("ANIMAL_CLASS"),
        icon: Assets.graphics.icons.level,
        switchButton: WidgetSwitchFilterOperation(
          onTap: () => super.switchOperation(FilterKey.weaponAnimalClass),
          operation: widget.filter.operationOf(FilterKey.weaponAnimalClass),
        ),
      ),
      WidgetFilterPickerAuto(
        filter: widget.filter,
        filterKey: FilterKey.weaponAnimalClass,
        bitKeys: List.generate(9, (i) => i + 1),
      ),
    ];
  }

  List<Widget> _listWeaponMag() {
    return [
      WidgetTitleIcon(
        tr("WEAPON_MAGAZINE"),
        icon: Assets.graphics.icons.weaponMag,
      ),
      WidgetFilterRangeSet(
        filter: widget.filter,
        filterKeyLower: FilterKey.weaponMagMin,
        filterKeyUpper: FilterKey.weaponMagMax,
        decimal: false,
      ),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listWeaponType(),
        ..._listAnimalClass(),
        ..._listWeaponMag(),
      ];
}
