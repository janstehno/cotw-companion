import 'package:cotwcompanion/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetScrollBar extends StatelessWidget {
  final Widget _child;
  final ScrollController? _controller;

  const WidgetScrollBar({
    super.key,
    required Widget child,
    ScrollController? controller,
  })  : _child = child,
        _controller = controller;

  Widget _buildWidgets() {
    return RawScrollbar(
      controller: _controller,
      thumbColor: Interface.primary,
      thickness: 2,
      child: _child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
