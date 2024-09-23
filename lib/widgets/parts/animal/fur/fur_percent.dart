import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetFurPercent extends StatelessWidget {
  final AnimalFur _animalFur;

  const WidgetFurPercent({
    super.key,
    required AnimalFur animalFur,
  }) : _animalFur = animalFur;

  Widget _buildText(String text) {
    return WidgetText(
      text,
      color: Interface.dark,
      style: Style.normal.s12.w300,
    );
  }

  Widget _buildRow(String left, String right) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildText(left),
        _buildText("."),
        _buildText(right),
        WidgetMargin.left(2, child: _buildText("%")),
      ],
    );
  }

  Widget _buildWidgets() {
    if (_animalFur.furId != Values.greatOneId && _animalFur.perCent > 0.0 && _animalFur.perCent < 100.0) {
      String left = _animalFur.perCent.toString().split(".")[0];
      String right = _animalFur.perCent.toString().split(".")[1];
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildRow(left, right),
          ),
        ],
      );
    }
    return const SizedBox(width: 80);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
