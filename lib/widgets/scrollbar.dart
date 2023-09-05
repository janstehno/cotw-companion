// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:material_scrollbar/material_scrollbar.dart';

class WidgetScrollbar extends StatelessWidget {
  final Widget child;

  const WidgetScrollbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  Widget _buildWidgets() {
    return MaterialScrollBar(
      trackColor: Interface.ff42.withOpacity(0.5),
      thumbColor: Interface.primary,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
