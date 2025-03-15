import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:flutter/material.dart';

class WidgetAnimalAnatomy extends StatelessWidget {
  final Animal _animal;

  const WidgetAnimalAnatomy(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildBody() {
    return Image.asset(
      Graphics.getAnimalAnatomy(_animal),
      height: 320,
      alignment: Alignment.center,
      fit: BoxFit.contain,
    );
  }

  Widget _buildWidgets() {
    return Container(
      height: 320,
      alignment: Alignment.center,
      child: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
