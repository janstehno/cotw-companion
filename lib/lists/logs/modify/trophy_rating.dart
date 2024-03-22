import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:flutter/material.dart';

class ListTrophyRating extends StatelessWidget {
  final int _trophyRating;
  final AnimalFur _selectedFur;
  final Function _trophyRatingChanged;

  const ListTrophyRating({
    super.key,
    required int trophyRating,
    required AnimalFur selectedFur,
    required Function trophyRatingChanged,
  })  : _trophyRating = trophyRating,
        _selectedFur = selectedFur,
        _trophyRatingChanged = trophyRatingChanged;

  Widget _buildNone() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.trophyNone,
      activeColor: Interface.light,
      activeBackground: Interface.trophyNone,
      isActive: _trophyRating == 0,
      onTap: () => _trophyRatingChanged(0),
    );
  }

  Widget _buildBronze() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.trophyBronze,
      activeColor: Interface.alwaysDark,
      activeBackground: Interface.trophyBronze,
      isActive: _trophyRating == 1,
      onTap: () => _trophyRatingChanged(1),
    );
  }

  Widget _buildSilver() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.trophySilver,
      activeColor: Interface.alwaysDark,
      activeBackground: Interface.trophySilver,
      isActive: _trophyRating == 2,
      onTap: () => _trophyRatingChanged(2),
    );
  }

  Widget _buildGold() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.trophyGold,
      activeColor: Interface.alwaysDark,
      activeBackground: Interface.trophyGold,
      isActive: _trophyRating == 3,
      onTap: () => _trophyRatingChanged(3),
    );
  }

  Widget _buildDiamond() {
    return WidgetSwitchIcon(
      _selectedFur.furId == Values.greatOneId
          ? Assets.graphics.icons.trophyGreatOne
          : Assets.graphics.icons.trophyDiamond,
      activeColor: _selectedFur.furId == Values.greatOneId ? Interface.light : Interface.alwaysDark,
      activeBackground: _selectedFur.furId == Values.greatOneId ? Interface.trophyGreatOne : Interface.trophyDiamond,
      isActive: _trophyRating == 4,
      onTap: () => _trophyRatingChanged(4),
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.h30v20(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNone(),
          _buildBronze(),
          _buildSilver(),
          _buildGold(),
          _buildDiamond(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
