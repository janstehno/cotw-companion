import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/indicator/indicator.dart';
import 'package:cotwcompanion/widgets/parts/fur/fur.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetAnimalFur extends WidgetFur {
  final bool _isChosen;

  const WidgetAnimalFur(
    super.animalFur, {
    super.key,
    required bool isChosen,
    required super.showPerCent,
  }) : _isChosen = isChosen;

  double get _indicatorSize => _isChosen ? Values.dotSize * 2 : Values.dotSize;

  Widget _buildIndicator() {
    return Container(
      width: Values.dotSize * 2,
      alignment: Alignment.center,
      child: WidgetIndicator.withSize(
        height: Values.dotSize,
        width: _indicatorSize,
        color: animalFur.color,
      ),
    );
  }

  Widget _buildName() {
    return WidgetPadding.fromLTRB(
      showPerCent ? 0 : 20,
      0,
      20,
      0,
      child: WidgetText(
        animalFur.furName,
        color: Interface.dark,
        style: Style.normal.s16.w300,
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIndicator(),
        if (showPerCent) buildPercent(),
        Expanded(child: _buildName()),
        buildGender(),
      ],
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        if (animalFur.furId != Values.greatOneId) WidgetMargin.bottom(3, child: _buildRow()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
