import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/activities/filter/hunting_pass/hunting_pass_dlcs.dart';
import 'package:cotwcompanion/activities/filter/hunting_pass/hunting_pass_weapons.dart';
import 'package:cotwcompanion/filters/hunting_pass.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/filter/switch.dart';
import 'package:cotwcompanion/widgets/section/section_tap.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterHuntingPass extends ActivityFilter<dynamic> {
  const ActivityFilterHuntingPass({
    super.key,
    required FilterHuntingPass super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterHuntingPassState();
}

class ActivityFilterHuntingPassState extends ActivityFilterState<dynamic> {
  bool get _allowedWeapons => (widget.filter as FilterHuntingPass).allowedWeapons;

  List<Widget> _listDlcOptions() {
    return [
      WidgetTitleIcon(
        tr("CONTENT_DOWNLOADABLE_CONTENT"),
        icon: Assets.graphics.icons.dlc,
      ),
      WidgetSectionTap(
        tr("PASS_DLC"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (e) => ActivityFilterHuntingPassDlcs(
                filter: widget.filter as FilterHuntingPass,
                onConfirm: () {
                  setState(() {
                    widget.onConfirm();
                  });
                },
              ),
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _listGeneralOptions() {
    return [
      WidgetTitleIcon(
        tr("GENERAL"),
        icon: Assets.graphics.icons.settings,
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomReserve,
        text: tr("PASS_RESERVE"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAnimal,
        text: tr("PASS_ANIMAL"),
      ),
      WidgetSectionTap(
        tr("PASS_WEAPON"),
        background: Utils.backgroundAt(HuntingPassOption.randomWeapon.index),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (e) => ActivityFilterHuntingPassWeapons(
                filter: widget.filter as FilterHuntingPass,
                onConfirm: () {
                  setState(() {
                    widget.onConfirm();
                  });
                },
              ),
            ),
          );
        },
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAmmo,
        text: tr("PASS_AMMO"),
        enabled: _allowedWeapons,
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomDistance,
        text: tr("PASS_DISTANCE"),
        enabled: _allowedWeapons,
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedDog,
        text: tr("PASS_DOG"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedCallers,
        text: tr("PASS_CALLERS"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedScopes,
        text: tr("PASS_SCOPES"),
        enabled: _allowedWeapons,
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedAtv,
        text: tr("PASS_ATV"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedStructures,
        text: tr("PASS_STRUCTURES"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedFastTravel,
        text: tr("PASS_FAST_TRAVEL"),
      ),
      WidgetFilterSwitch(
        filter: widget.filter,
        filterKey: FilterKey.huntingPassGeneral,
        bitKey: HuntingPassOption.randomAllowedDayTime,
        text: tr("PASS_DAY_TIME"),
      ),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listDlcOptions(),
        ..._listGeneralOptions(),
      ];
}
