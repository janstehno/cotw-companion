import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/animal_info/animal_zones.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimalZones extends StatelessWidget {
  final Animal _animal;
  final Reserve? _reserve;

  const WidgetAnimalZones(
    Animal animal, {
    super.key,
    required Reserve? reserve,
  })  : _animal = animal,
        _reserve = reserve;

  Widget _buildZoneTypes() {
    return WidgetMargin.top(
      30,
      alignment: Alignment.center,
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.center,
        children: [
          if (_animal.hasFeedZones)
            WidgetTag.small(
              value: tr("ANIMAL_FEED"),
              color: Interface.alwaysDark,
              background: Interface.zoneFeed,
            ),
          if (_animal.hasDrinkZones)
            WidgetTag.small(
              value: tr("ANIMAL_DRINK"),
              color: Interface.alwaysDark,
              background: Interface.zoneDrink,
            ),
          if (_animal.hasRestZones)
            WidgetTag.small(
              value: tr("ANIMAL_REST"),
              color: Interface.alwaysDark,
              background: Interface.zoneRest,
            ),
          if (_animal.hasOtherZones)
            WidgetTag.small(
              value: tr("ANIMAL_OTHER"),
              color: Interface.light,
              background: Interface.zoneOther,
            ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        _buildZoneTypes(),
        ListAnimalZones(
          _animal,
          reserve: _reserve,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
