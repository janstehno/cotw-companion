import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimalAnatomy extends StatelessWidget {
  final Animal _animal;

  const WidgetAnimalAnatomy(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildBody() {
    return Container(
      height: 320,
      alignment: Alignment.center,
      child: Image.asset(
        Graphics.getAnimalAnatomy(_animal),
        height: 320,
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDisclaimer() {
    return WidgetPadding.h30v20(
      child: WidgetText(
        tr("DISCLAIMER_MODEL"),
        autoSize: false,
        textAlign: TextAlign.center,
        color: Interface.disabled,
        style: Style.normal.s8.w300,
      ),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        _buildBody(),
        _buildDisclaimer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
