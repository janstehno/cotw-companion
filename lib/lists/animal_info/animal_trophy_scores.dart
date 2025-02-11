import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_value.dart';
import 'package:flutter/material.dart';

class ListAnimalTrophyScores extends StatelessWidget {
  final Animal _animal;

  const ListAnimalTrophyScores(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildTrophySilver() {
    return WidgetAnimalValue(
      icon: Assets.graphics.icons.trophySilver,
      value: _animal.trophyAsString(_animal.silver),
      color: Interface.alwaysDark,
      background: Interface.trophySilver,
    );
  }

  Widget _buildTrophyGold() {
    return WidgetAnimalValue(
      icon: Assets.graphics.icons.trophyGold,
      value: _animal.trophyAsString(_animal.gold),
      color: Interface.alwaysDark,
      background: Interface.trophyGold,
    );
  }

  Widget _buildTrophyDiamond() {
    return Row(
      spacing: 15,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: WidgetAnimalValue(
            icon: Assets.graphics.icons.trophyDiamond,
            value: _animal.trophyAsString(_animal.diamond),
            color: Interface.alwaysDark,
            background: Interface.trophyDiamond,
          ),
        ),
        if (_animal.femaleDiamond) _buildTrophyDiamondFemale(),
      ],
    );
  }

  Widget _buildTrophyDiamondFemale() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.genderFemale,
      color: Interface.disabledForeground,
      size: 12,
    );
  }

  Widget _buildTrophyScores() {
    return Column(
      spacing: 5,
      children: [
        _buildTrophySilver(),
        _buildTrophyGold(),
        _buildTrophyDiamond(),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(child: _buildTrophyScores());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
