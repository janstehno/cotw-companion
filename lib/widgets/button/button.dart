import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:flutter/material.dart';

abstract class WidgetButton extends StatelessWidget {
  final double? _width;
  final Color? _background;
  final Function _onTap;

  const WidgetButton({
    super.key,
    double? width,
    Color? background,
    required Function onTap,
  })  : _width = width,
        _background = background,
        _onTap = onTap;

  Color? get background => _background;

  Color get buttonBackground => _background ?? Interface.primary;

  double? get buttonWidth => _width == 0 ? null : buttonHeight;

  double get buttonHeight => Values.tapSize;

  Widget? buildCenter() => null;

  Widget _buildWidgets() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: AnimatedContainer(
        width: buttonWidth,
        height: buttonHeight,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: buttonBackground,
          borderRadius: BorderRadius.circular(Values.tapSize / 4),
        ),
        child: buildCenter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
