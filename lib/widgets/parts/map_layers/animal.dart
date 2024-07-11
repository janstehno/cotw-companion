import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/parts/reserve/animal.dart';
import 'package:flutter/material.dart';

class WidgetMapLayerAnimal extends WidgetReserveAnimal {
  WidgetMapLayerAnimal(
    super.animal, {
    super.key,
    required super.context,
    required super.reserve,
    required super.background,
    required super.indicatorColor,
    required super.isShown,
    required super.onTap,
  }) : super(indicatorSize: Values.indicatorSize);

  void _onLongTap() {
    Navigator.push(context, MaterialPageRoute(builder: (e) => ActivityDetailAnimal(animal, reserve: reserve)));
  }

  @override
  Widget buildRow() {
    return Row(
      children: [
        Expanded(child: super.buildTitle()),
        const SizedBox(width: 15),
        buildIndicator(),
      ],
    );
  }

  @override
  Widget buildContainer() {
    return GestureDetector(
      onLongPress: () => _onLongTap(),
      child: super.buildContainer(),
    );
  }
}
