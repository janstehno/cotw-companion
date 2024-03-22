import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/logs/dismissible.dart';
import 'package:flutter/material.dart';

class WidgetTrophyLodge extends WidgetLogsDismissible {
  const WidgetTrophyLodge(
    super.i, {
    super.key,
    required super.log,
    super.callback,
    required super.context,
  }) : super(disabled: true);

  @override
  EntryTrophyLodgeState createState() => EntryTrophyLodgeState();
}

class EntryTrophyLodgeState extends WidgetLogsDismissibleState {
  Widget _buildNameTrophy() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildGender(),
        const SizedBox(width: 5),
        Expanded(child: buildName()),
        buildTrophy(),
      ],
    );
  }

  Widget _buildFurWeight() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: buildFur()),
        if ((widget as WidgetLogsDismissible).log.weight > 0) buildWeight(),
      ],
    );
  }

  @override
  Widget buildEntry() {
    return WidgetPadding.h30v20(
      child: Column(
        children: [
          _buildNameTrophy(),
          _buildFurWeight(),
        ],
      ),
    );
  }
}
