// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class EntryWithDlc extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final bool dlc;
  final bool visible;

  const EntryWithDlc({Key? key, required this.text, this.padding, required this.dlc, this.visible = true}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        padding: padding ?? const EdgeInsets.all(0),
        child: dlc
            ? Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child:
                            AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
                Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color(Values.colorPrimary),
                        border: Border.all(color: Color(Values.colorAccentBorder), width: Values.widthAccentBorder),
                        borderRadius: BorderRadius.circular(5)))
              ])
            : AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
