import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/modify/add/logs_source.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/icon/icon_background.dart';
import 'package:cotwcompanion/widgets/indicator/loadout_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetNeedZone extends StatelessWidget {
  final Animal _animal;
  final Reserve _reserve;
  final List<AnimalZone> _zones;
  final int _index, _hour;

  const WidgetNeedZone(
    int i, {
    super.key,
    required Animal animal,
    required Reserve reserve,
    required List<AnimalZone> zones,
    required int hour,
    required int count,
    required bool compact,
    required bool classSwitches,
  })  : _index = i,
        _animal = animal,
        _reserve = reserve,
        _zones = zones,
        _hour = hour;

  double get zoneIconSize => Values.tapSize;

  double get itemHeight => Values.section;

  bool onDismiss(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityAddLogsSource(animal: _animal, reserve: _reserve, onSuccess: () {}),
      ),
    );
    return false;
  }

  void onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityDetailAnimal(_animal)),
    );
  }

  List<int> _initializeZones() {
    List<int> zones = List.filled(3, 4, growable: false);
    if (_zones.length != 1) {
      int hourNow = _hour;
      int hourAfter = (hourNow + 1) % 24;
      int hourAfterAfter = (hourAfter + 1) % 24;
      for (AnimalZone zone in _zones) {
        if ((hourNow >= zone.from && hourNow < zone.to) ||
            (hourAfter >= zone.from && hourAfter < zone.to) ||
            (hourAfterAfter >= zone.from && hourAfterAfter < zone.to)) {
          for (int hour = zone.from; hour < zone.to; hour++) {
            if (hour == hourNow) {
              zones[0] = zone.zone;
            } else if (hour == hourAfter) {
              zones[1] = zone.zone;
            } else if (hour == hourAfterAfter) {
              zones[2] = zone.zone;
            }
          }
        }
      }
    }
    return zones;
  }

  Widget _buildNow(int zoneNow) {
    return WidgetIconBackground(
      AnimalZone.iconFor(zoneNow),
      size: zoneIconSize,
      color: AnimalZone.iconColorFor(zoneNow),
      background: AnimalZone.colorFor(zoneNow),
    );
  }

  Widget _buildAfter(int zoneAfter) {
    return WidgetIconBackground(
      AnimalZone.iconFor(zoneAfter),
      size: zoneIconSize - 5,
      color: AnimalZone.iconColorFor(zoneAfter),
      background: AnimalZone.colorFor(zoneAfter).withValues(alpha: 0.6),
    );
  }

  Widget _buildAfterAfter(int zoneAfterAfter) {
    return WidgetIconBackground(
      AnimalZone.iconFor(zoneAfterAfter),
      size: zoneIconSize - 10,
      color: AnimalZone.iconColorFor(zoneAfterAfter),
      background: AnimalZone.colorFor(zoneAfterAfter).withValues(alpha: 0.4),
    );
  }

  Widget _buildZones(List<int> zones) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNow(zones.elementAt(0)),
        _buildAfter(zones.elementAt(1)),
        _buildAfterAfter(zones.elementAt(2)),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 30),
      child: WidgetText(
        _animal.getNameByReserve(context.locale, _reserve),
        color: Interface.dark,
        style: Style.normal.s16.w300,
        maxLines: _animal.getNameByReserve(context.locale, _reserve).split(RegExp(r'[ -]')).length > 2 ? 2 : 1,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildLevelName(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          WidgetText(
            _animal.level.toString(),
            color: Interface.dark,
            style: Style.normal.s18.w500,
          ),
          Expanded(child: _buildName(context))
        ],
      ),
    );
  }

  Widget _buildEntry(BuildContext context) {
    List<int> zones = _initializeZones();
    return SizedBox(
      height: Values.section,
      child: WidgetPadding.h30(
        background: Utils.backgroundAt(_index),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildLevelName(context)),
            if (HelperLoadout.isLoadoutActivated) WidgetLoadoutIndicator(animal: _animal),
            Container(
              width: zoneIconSize + zoneIconSize - 5 + zoneIconSize - 10 + 20,
              margin: const EdgeInsets.only(left: 15),
              child: _buildZones(zones),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditBackground() {
    return WidgetPadding.h30(
      background: Interface.green,
      child: WidgetIcon(
        Assets.graphics.icons.edit,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return Dismissible(
      key: Key(_index.toString()),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async => onDismiss(context),
      background: _buildEditBackground(),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: _buildEntry(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
