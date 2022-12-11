// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class EntryWithoutDlc extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final bool visible;

  const EntryWithoutDlc({Key? key, required this.text, this.padding, this.visible = true}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        padding: padding ?? const EdgeInsets.all(0),
        child: AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
