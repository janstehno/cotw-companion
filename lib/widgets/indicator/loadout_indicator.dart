import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/loadout.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:flutter/material.dart';

class WidgetLoadoutIndicator extends StatelessWidget {
  final Animal _animal;

  const WidgetLoadoutIndicator({
    super.key,
    required Animal animal,
  }) : _animal = animal;

  double get _iconSize => Values.dotSize;

  Widget _buildAmmo() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.loadout,
      color: Interface.dark,
      size: _iconSize,
    );
  }

  Widget _buildCaller() {
    return WidgetIcon.withSize(
      Assets.graphics.icons.senseHearing,
      color: Interface.dark,
      size: _iconSize,
    );
  }

  Widget _buildWidgets() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (HelperLoadout.isAmmoEligible(_animal)) _buildAmmo(),
        if (HelperLoadout.isAmmoEligible(_animal) && HelperLoadout.isCallerEligible(_animal)) const SizedBox(height: 3),
        if (HelperLoadout.isCallerEligible(_animal)) _buildCaller(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
