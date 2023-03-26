// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:material_scrollbar/material_scrollbar.dart';

class WidgetScrollbar extends StatelessWidget {
  final Color? thumbColor, trackColor;
  final bool? alwaysVisible;
  final Widget child;

  const WidgetScrollbar({
    Key? key,
    this.trackColor,
    this.thumbColor,
    this.alwaysVisible,
    required this.child,
  }) : super(key: key);

  Widget _buildWidgets() {
    return MaterialScrollBar(
      thumbVisibility: alwaysVisible,
      trackColor: trackColor ?? Interface.ff42,
      thumbColor: thumbColor ?? Interface.primary.withOpacity(0.85),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
