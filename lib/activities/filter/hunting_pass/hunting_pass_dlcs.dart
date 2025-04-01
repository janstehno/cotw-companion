import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/widgets/filter/switch_numeric.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterHuntingPassDlcs extends ActivityFilter<dynamic> {
  const ActivityFilterHuntingPassDlcs({
    super.key,
    required FilterHuntingPass super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterHuntingPassDlcsState();
}

class ActivityFilterHuntingPassDlcsState extends ActivityFilterState<dynamic> {
  late final List<Dlc> reserveDlcs;
  late final List<Dlc> weaponDlcs;

  @override
  void initState() {
    reserveDlcs = (widget.filter as FilterHuntingPass).reserveDlcs;
    weaponDlcs = (widget.filter as FilterHuntingPass).weaponDlcs;
    super.initState();
  }

  List<Widget> _listReserveDlcs() {
    return reserveDlcs.mapIndexed((i, d) {
      return WidgetFilterSwitchNumeric(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassReserveDlcs,
        bit: i,
        text: d.name,
      );
    }).toList();
  }

  List<Widget> _listWeaponDlcs() {
    return weaponDlcs.mapIndexed((i, d) {
      return WidgetFilterSwitchNumeric(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassWeaponDlcs,
        bit: i,
        text: d.name,
      );
    }).toList();
  }

  List<Widget> _listWeaponType() {
    return [
      WidgetTitleIcon(
        tr("RESERVES"),
        icon: Assets.graphics.icons.reserve,
      ),
      ..._listReserveDlcs(),
      WidgetTitleIcon(
        tr("WEAPONS"),
        icon: Assets.graphics.icons.weapon,
      ),
      ..._listWeaponDlcs(),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listWeaponType(),
      ];
}
