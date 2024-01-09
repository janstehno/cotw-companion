// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetScrollbar extends StatelessWidget {
  final Widget child;

  const WidgetScrollbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  Widget _buildWidgets() {
    return RawScrollbar(
      thumbColor: Interface.primary,
      thickness: 3,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
