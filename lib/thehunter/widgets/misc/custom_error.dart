// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String? text;
  final bool visible;

  const WidgetError({Key? key, required this.text, this.visible = true}) : super(key: key);

  Widget _buildWidgets() {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: Color(Values.colorPrimary),
            padding: const EdgeInsets.all(30),
            child: AutoSizeText(
              text ?? "Error. Please restart the application.",
              textAlign: TextAlign.start,
              style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize22, fontWeight: FontWeight.w400),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
