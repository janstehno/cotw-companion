import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetSwitchSort extends WidgetSwitchIcon {
  final bool _isAscended;
  final int? _orderNumber;

  const WidgetSwitchSort(
    super.icon, {
    super.key,
    required bool isAscended,
    int? orderNumber,
    super.color,
    super.background,
    super.activeColor,
    super.activeBackground,
    required super.onTap,
    required super.isActive,
  })  : _isAscended = isAscended,
        _orderNumber = orderNumber;

  String get actualOrder => _isAscended ? Assets.graphics.icons.sortAscended : Assets.graphics.icons.sortDescended;

  Widget _buildOrderIcon() {
    return WidgetIcon.withSize(
      actualOrder,
      size: (Values.tapSize / 5) * 2 - 2,
      color: iconColor,
    );
  }

  Widget _buildOrderNumber() {
    return WidgetText(
      ((_orderNumber ?? -1) + 1).toString(),
      color: iconColor,
      style: Style.normal.s14.w500,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSortIcon() {
    return WidgetIcon.withSize(
      icon,
      size: (Values.tapSize / 5) * 2 - 4,
      color: iconColor,
    );
  }

  Widget _buildSort() {
    return WidgetIcon(
      icon,
      color: iconColor,
    );
  }

  Widget _buildSortedCenter() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSortIcon(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildOrderIcon(),
            _buildOrderNumber(),
          ],
        )
      ],
    );
  }

  Widget _buildSorted() {
    return AnimatedContainer(
      width: Values.tapSize,
      height: Values.tapSize,
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Values.tapSize / 4)),
        color: buttonBackground,
      ),
      child: _buildSortedCenter(),
    );
  }

  @override
  Widget? buildCenter() {
    return Stack(
      children: [
        if (!isActive) _buildSort(),
        if (isActive) _buildSorted(),
      ],
    );
  }
}
