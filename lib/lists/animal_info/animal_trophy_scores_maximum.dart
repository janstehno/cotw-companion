import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_trophy_score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAnimalTrophyScoresMaximum extends StatelessWidget {
  final Animal _animal;

  const ListAnimalTrophyScoresMaximum(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildMaximumTrophy(bool greatOne) {
    if (greatOne) {
      return WidgetAnimalTrophyScore(
        icon: Assets.graphics.icons.trophyGreatOne,
        value: _animal.trophyAsString(_animal.trophyGO),
        color: Interface.light,
        background: Interface.dark,
        valueKnown: _animal.trophyGO != 0,
      );
    }
    return WidgetAnimalTrophyScore(
      icon: Assets.graphics.icons.harvestNoTrophyOrgan,
      value: _animal.trophyAsString(_animal.trophy),
      color: Interface.light,
      background: Interface.dark,
      valueKnown: _animal.trophy != 0,
    );
  }

  Widget _buildMaximumWeight(BuildContext context, bool greatOne) {
    bool imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;

    if (greatOne) {
      return WidgetAnimalTrophyScore(
        icon: Assets.graphics.icons.weight,
        value: _animal.weightGOAsString(imperialUnits),
        color: Interface.light,
        background: Interface.dark,
        valueKnown: imperialUnits ? _animal.weightGOLB != 0 : _animal.weightGOKG != 0,
        alignRight: true,
      );
    }
    return WidgetAnimalTrophyScore(
      icon: Assets.graphics.icons.weight,
      value: _animal.weightAsString(imperialUnits),
      color: Interface.light,
      background: Interface.dark,
      valueKnown: imperialUnits ? _animal.weightLB != 0 : _animal.weightKG != 0,
      alignRight: true,
    );
  }

  Widget _buildMaximumTrophyWeight(BuildContext context, bool greatOne) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildMaximumTrophy(greatOne),
        _buildMaximumWeight(context, greatOne),
      ],
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetPadding.a30(
      child: Column(
        children: [
          _buildMaximumTrophyWeight(context, false),
          const SizedBox(height: 5),
          if (_animal.hasGO) _buildMaximumTrophyWeight(context, true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
