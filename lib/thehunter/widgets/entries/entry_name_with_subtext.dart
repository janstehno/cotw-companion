// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';

class EntryNameWithSubtext extends StatelessWidget {
  final String text;
  final String subText;
  final double size;
  final int? color;
  final int? background;
  final bool oneLine;
  final bool visible;

  const EntryNameWithSubtext(
      {Key? key,
      required this.text,
      this.subText = "",
      this.size = 50,
      this.color,
      this.background,
      this.oneLine = false,
      this.visible = true})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: Color(background ?? Values.colorTransparent),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    AutoSizeText(text,
                        maxLines: oneLine ? 1 : 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600)),
                    subText.isNotEmpty
                        ? AutoSizeText(subText,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400))
                        : Container()
                  ])))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
