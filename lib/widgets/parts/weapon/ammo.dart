import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/ammo_info/statistics.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/parts/stats/price.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetWeaponAmmo extends StatelessWidget {
  final Ammo _ammo;

  const WidgetWeaponAmmo(
    Ammo ammo, {
    super.key,
  }) : _ammo = ammo;

  bool _imperialUnits(BuildContext context) {
    return Provider.of<Settings>(context, listen: false).imperialUnits;
  }

  Widget _buildRequirements() {
    return WidgetPadding.h30v20(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          WidgetParameterPrice(price: _ammo.price),
          WidgetParameter(
            text: tr("REQUIREMENT_SCORE"),
            value: _ammo.score,
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context) {
    return WidgetPadding.h30v20(
      child: ListAmmoStatistics(
        _ammo,
        imperialUnits: _imperialUnits(context),
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return Column(
      children: [
        if (_ammo.hasRequirements) _buildRequirements(),
        _buildStatistics(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
