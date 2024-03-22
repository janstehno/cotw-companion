import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:flutter/material.dart';

class WidgetAnimalSense extends StatelessWidget {
  final Animal _animal;
  final SenseType _sense;

  const WidgetAnimalSense(
    Animal animal, {
    super.key,
    required SenseType sense,
  })  : _animal = animal,
        _sense = sense;

  List<Widget> _listSenses() {
    return List.generate(_animal.senseStrength(_sense), (i) => _animal.senseStrength(_sense)).map((e) {
      return WidgetMargin.left(
        5,
        child: WidgetIndicator(
          _animal.senseColor(e),
          size: Values.dotSize,
        ),
      );
    }).toList();
  }

  Widget _buildIcon() {
    return WidgetIcon(
      Graphics.getSenseIcon(_sense),
      color: Interface.dark,
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: Values.entry,
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 15),
          Expanded(child: Row(children: _listSenses())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
