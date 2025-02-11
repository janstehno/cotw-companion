import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_value_range.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/parts/animal/animal_value.dart';

class ListAnimalWeightDistribution extends StatelessWidget {
  final Animal _animal;
  final bool _showDistribution;

  const ListAnimalWeightDistribution(
    Animal animal, {
    super.key,
    required showDistribution,
  })  : _animal = animal,
        _showDistribution = showDistribution;

  Widget _buildMaleMaxWeight(UnitType units) {
    String max = _animal.weightAsString(ThresholdType.max, CategoryType.male, units);

    return WidgetAnimalValue(
      icon: Assets.graphics.icons.genderMale,
      value: max,
      color: Interface.alwaysDark,
      background: Interface.genderMale,
    );
  }

  Widget _buildMaleWeight(UnitType units) {
    String min = _animal.weightAsString(ThresholdType.min, CategoryType.male, units);
    String max = _animal.weightAsString(ThresholdType.max, CategoryType.male, units);

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.genderMale,
      value: min,
      secondValue: max,
      color: Interface.alwaysDark,
      background: Interface.genderMale,
    );
  }

  Widget _buildFemaleMaxWeight(UnitType units) {
    String max = _animal.weightAsString(ThresholdType.max, CategoryType.female, units);

    return WidgetAnimalValue(
      icon: Assets.graphics.icons.genderFemale,
      value: max,
      color: Interface.alwaysDark,
      background: Interface.genderFemale,
    );
  }

  Widget _buildFemaleWeight(UnitType units) {
    String min = _animal.weightAsString(ThresholdType.min, CategoryType.female, units);
    String max = _animal.weightAsString(ThresholdType.max, CategoryType.female, units);

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.genderFemale,
      value: min,
      secondValue: max,
      color: Interface.alwaysDark,
      background: Interface.genderFemale,
    );
  }

  Widget _buildGOWeight(UnitType units) {
    String min = _animal.weightAsString(ThresholdType.min, CategoryType.go, units);
    String max = _animal.weightAsString(ThresholdType.max, CategoryType.go, units);

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.trophyGreatOne,
      value: min,
      secondValue: max,
      color: Interface.light,
      background: Interface.dark,
    );
  }

  List<Widget> _listWidgets(UnitType units) {
    if (_showDistribution) {
      return [
        if (_animal.hasGO) _buildGOWeight(units),
        _buildMaleWeight(units),
        _buildFemaleWeight(units),
      ];
    }
    return [
      _buildMaleMaxWeight(units),
      _buildFemaleMaxWeight(units),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    bool imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    UnitType units = imperialUnits ? UnitType.imperial : UnitType.metric;

    return WidgetPadding.a30(
      child: Column(
        spacing: 5,
        children: _listWidgets(units),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
