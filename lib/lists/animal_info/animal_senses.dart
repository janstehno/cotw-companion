import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal_sense.dart';
import 'package:flutter/material.dart';

class ListAnimalSenses extends StatelessWidget {
  final Animal _animal;

  const ListAnimalSenses(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildSense(Sense sense) {
    return WidgetAnimalSense(
      _animal,
      sense: sense,
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.a30(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_animal.senseStrength(Sense.sight) > 0) _buildSense(Sense.sight),
          if (_animal.senseStrength(Sense.hearing) > 0) _buildSense(Sense.hearing),
          if (_animal.senseStrength(Sense.smell) > 0) _buildSense(Sense.smell),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
