import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_value_range.dart';
import 'package:flutter/material.dart';

class ListAnimalTrophyScoreDistribution extends StatelessWidget {
  final Animal _animal;

  const ListAnimalTrophyScoreDistribution(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildMaleTrophyScore() {
    String min = _animal.trophyAsString(_animal.trophy(ThresholdLevel.min, CategoryType.male));
    String max = _animal.trophyAsString(_animal.trophy(ThresholdLevel.max, CategoryType.male));

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.genderMale,
      value: min,
      secondValue: max,
      color: Interface.alwaysDark,
      background: Interface.genderMale,
    );
  }

  Widget _buildFemaleTrophyScore() {
    String min = _animal.trophyAsString(_animal.trophy(ThresholdLevel.min, CategoryType.female));
    String max = _animal.trophyAsString(_animal.trophy(ThresholdLevel.max, CategoryType.female));

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.genderFemale,
      value: min,
      secondValue: max,
      color: Interface.alwaysDark,
      background: Interface.genderFemale,
    );
  }

  Widget _buildGOTrophyScore() {
    String min = _animal.trophyAsString(_animal.trophy(ThresholdLevel.min, CategoryType.go));
    String max = _animal.trophyAsString(_animal.trophy(ThresholdLevel.max, CategoryType.go));

    return WidgetAnimalValueRange(
      icon: Assets.graphics.icons.trophyGreatOne,
      value: min,
      secondValue: max,
      color: Interface.light,
      background: Interface.dark,
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(
      child: Column(
        spacing: 5,
        children: [
          if (_animal.hasGO) _buildGOTrophyScore(),
          _buildMaleTrophyScore(),
          if (_animal.femaleTrophy) _buildFemaleTrophyScore(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
