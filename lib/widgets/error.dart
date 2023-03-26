// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String? text;

  const WidgetError({
    Key? key,
    required this.text,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: Interface.primary,
            padding: const EdgeInsets.all(30),
            child: AutoSizeText(
              text ?? "Error. Please restart the application.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Interface.accent,
                fontSize: Interface.s22,
                fontWeight: FontWeight.w400,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
