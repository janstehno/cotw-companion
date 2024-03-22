import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class WidgetAnimalHeader extends StatelessWidget {
  final Animal _animal;

  const WidgetAnimalHeader(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  double get _headerLeftWidth => 75;

  double _headerWidth(BuildContext context) => MediaQuery.of(context).size.width - 90;

  double _headerHeight(BuildContext context) => _headerWidth(context) > 250 ? 250 : _headerWidth(context);

  Widget _buildAnimalIcon() {
    return WidgetIcon.withSize(
      Graphics.getAnimalIcon(_animal),
      color: Interface.dark,
      size: _headerLeftWidth,
    );
  }

  Widget _buildAnimalHead() {
    return SimpleShadow(
      color: Interface.shadow,
      sigma: 2,
      opacity: 1,
      offset: const Offset(-0.4, -0.4),
      child: Image.asset(
        Graphics.getAnimalHead(_animal),
        alignment: Alignment.bottomRight,
      ),
    );
  }

  Widget _buildIconHead(BuildContext context) {
    return SizedBox(
      height: _headerHeight(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              child: _buildAnimalIcon(),
            ),
          ),
          const SizedBox(width: 30),
          _buildAnimalHead(),
        ],
      ),
    );
  }

  Widget _buildAnimalClass() {
    return WidgetParameter(
      text: tr("ANIMAL_CLASS"),
      value: _animal.level,
    );
  }

  Widget _buildAnimalDifficulty() {
    return WidgetParameter(
      text: tr("ANIMAL_DIFFICULTY"),
      value: _animal.difficulty.toString(),
    );
  }

  Widget _buildClassDifficulty() {
    return Column(
      children: [
        _buildAnimalClass(),
        const SizedBox(height: 5),
        _buildAnimalDifficulty(),
      ],
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetPadding.a30(
      background: Interface.subtitle,
      child: Column(
        children: [
          _buildIconHead(context),
          const SizedBox(height: 30),
          _buildClassDifficulty(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
