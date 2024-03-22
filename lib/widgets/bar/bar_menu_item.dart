import 'package:collection/collection.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:flutter/material.dart';

class WidgetMenuBarItem extends StatelessWidget {
  final double? _height;
  final Widget _barButton;
  final List<Widget> _subButtons;
  final bool _menuOpened;

  const WidgetMenuBarItem({
    super.key,
    double? height,
    required Widget barButton,
    List<Widget> subButtons = const [],
    bool menuOpened = false,
  })  : _height = height,
        _barButton = barButton,
        _subButtons = subButtons,
        _menuOpened = menuOpened;

  List<Widget> get subButtons => _subButtons;

  bool get menuOpened => _menuOpened;

  double position(int i, bool position) => position ? (_height ?? Values.menuBar) + (45 * i) : 0;

  Widget _buildSubButton(int i, Widget button) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      right: 0,
      bottom: position(i, _menuOpened),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _menuOpened ? 1 : 0,
        child: button,
      ),
    );
  }

  List<Widget> _listSubButtons() {
    return _subButtons.mapIndexed((i, button) => _buildSubButton(i, button)).toList();
  }

  Widget _buildBarButton() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: _barButton,
    );
  }

  Widget _buildWidgets() {
    if (_subButtons.isNotEmpty) {
      return Stack(
        children: [
          ..._listSubButtons(),
          _buildBarButton(),
        ],
      );
    }
    return _barButton;
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
