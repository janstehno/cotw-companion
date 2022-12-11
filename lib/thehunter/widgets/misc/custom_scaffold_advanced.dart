// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class WidgetScaffoldAdvanced extends StatelessWidget {
  final Widget body;

  const WidgetScaffoldAdvanced({Key? key, required this.body}) : super(key: key);

  Widget _buildWidgets() {
    return Scaffold(backgroundColor: Color(Values.colorBody), appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(Values.colorPrimary)), body: body);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
