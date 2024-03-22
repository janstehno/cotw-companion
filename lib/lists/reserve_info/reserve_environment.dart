import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon_background.dart';
import 'package:flutter/material.dart';

class ListReserveEnvironment extends StatelessWidget {
  final Reserve _reserve;

  const ListReserveEnvironment(
    Reserve reserve, {
    super.key,
  }) : _reserve = reserve;

  Widget _buildWidgets() {
    return WidgetPadding.a30(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          WidgetIconBackground(
            Assets.graphics.icons.environmentSummer,
            color: _reserve.hasSummer ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasSummer ? Interface.environmentSummer : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentWinter,
            color: _reserve.hasWinter ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasWinter ? Interface.environmentWinter : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentFields,
            color: _reserve.hasFields ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasFields ? Interface.environmentField : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentForest,
            color: _reserve.hasForest ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasForest ? Interface.environmentForest : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentPlains,
            color: _reserve.hasPlains ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasPlains ? Interface.environmentPlains : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentLowlands,
            color: _reserve.hasLowlands ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasLowlands ? Interface.environmentLowlands : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentHills,
            color: _reserve.hasHills ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasHills ? Interface.environmentHills : Interface.disabled,
          ),
          WidgetIconBackground(
            Assets.graphics.icons.environmentMountains,
            color: _reserve.hasMountains ? Interface.alwaysDark : Interface.disabledForeground,
            background: _reserve.hasMountains ? Interface.environmentMountains : Interface.disabled,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
