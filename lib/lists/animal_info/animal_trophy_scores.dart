import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_trophy_score.dart';
import 'package:flutter/material.dart';

class ListAnimalTrophyScores extends StatelessWidget {
  final Animal _animal;

  const ListAnimalTrophyScores(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildTrophySilver() {
    return WidgetAnimalTrophyScore(
      icon: Assets.graphics.icons.trophySilver,
      value: _animal.trophyAsString(_animal.silver),
      color: Interface.alwaysDark,
      background: Interface.trophySilver,
    );
  }

  Widget _buildTrophyGold() {
    return WidgetAnimalTrophyScore(
      icon: Assets.graphics.icons.trophyGold,
      value: _animal.trophyAsString(_animal.gold),
      color: Interface.alwaysDark,
      background: Interface.trophyGold,
    );
  }

  Widget _buildTrophyDiamond() {
    return WidgetAnimalTrophyScore(
      icon: Assets.graphics.icons.trophyDiamond,
      value: _animal.trophyAsString(_animal.diamond),
      color: Interface.alwaysDark,
      background: Interface.trophyDiamond,
    );
  }

  Widget _buildTrophyDiamondFemale() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.genderFemale,
      color: Interface.alwaysDark,
      size: 13,
    );
  }

  Widget _buildTrophyScores() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        _buildTrophySilver(),
        _buildTrophyGold(),
        Row(
          children: [
            _buildTrophyDiamond(),
            if (_animal.femaleDiamond) ...[
              const SizedBox(width: 15),
              _buildTrophyDiamondFemale(),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(child: _buildTrophyScores());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
