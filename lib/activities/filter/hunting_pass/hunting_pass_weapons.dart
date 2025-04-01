import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterHuntingPassWeapons extends ActivityFilter<dynamic> {
  const ActivityFilterHuntingPassWeapons({
    super.key,
    required FilterHuntingPass super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterHuntingPassWeaponsState();
}

class ActivityFilterHuntingPassWeaponsState extends ActivityFilterState<dynamic> {
  List<Widget> _listWeaponType() {
    return [
      WidgetTitleIcon(
        tr("TYPE"),
        icon: Assets.graphics.icons.weapon,
      ),
      WidgetFilterPickerText<WeaponType>(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassWeapons,
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

  @override
  List<Widget> get filters => [
        ..._listWeaponType(),
      ];
}
