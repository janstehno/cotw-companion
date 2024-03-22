import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:flutter/material.dart';

class ListHarvestCheck extends StatelessWidget {
  final bool _correctAmmo;
  final bool _twoShots;
  final bool _trophyOrgan;
  final bool _vitalOrgan;
  final Function _correctAmmoChanged;
  final Function _twoShotsChanged;
  final Function _trophyOrganChanged;
  final Function _vitalOrganChanged;

  const ListHarvestCheck({
    super.key,
    required bool correctAmmo,
    required bool twoShots,
    required bool trophyOrgan,
    required bool vitalOrgan,
    required Function correctAmmoChanged,
    required Function twoShotsChanged,
    required Function trophyOrganChanged,
    required Function vitalOrganChanged,
  })  : _correctAmmo = correctAmmo,
        _twoShots = twoShots,
        _trophyOrgan = trophyOrgan,
        _vitalOrgan = vitalOrgan,
        _correctAmmoChanged = correctAmmoChanged,
        _twoShotsChanged = twoShotsChanged,
        _trophyOrganChanged = trophyOrganChanged,
        _vitalOrganChanged = vitalOrganChanged;

  Widget _buildCorrectAmmo() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.harvestCorrectAmmo,
      isActive: _correctAmmo,
      onTap: () => _correctAmmoChanged(),
    );
  }

  Widget _buildTwoShots() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.harvestTwoShots,
      isActive: _twoShots,
      onTap: () => _twoShotsChanged(),
    );
  }

  Widget _buildTrophyOrgan() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.harvestNoTrophyOrgan,
      isActive: _trophyOrgan,
      onTap: () => _trophyOrganChanged(),
    );
  }

  Widget _buildVitalOrgan() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.harvestVitalOrgan,
      isActive: _vitalOrgan,
      onTap: () => _vitalOrganChanged(),
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.h30v20(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCorrectAmmo(),
          _buildTwoShots(),
          _buildTrophyOrgan(),
          _buildVitalOrgan(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
