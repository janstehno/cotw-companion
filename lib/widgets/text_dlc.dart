// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTextDlc extends StatelessWidget {
  final String text, subText;
  final bool dlc;

  final double _textHeight = 22;
  final double _subTextHeight = 18;
  final double _dotSize = 5;

  const WidgetTextDlc({
    Key? key,
    required this.text,
    this.subText = "",
    required this.dlc,
  }) : super(key: key);

  Widget _buildWidgets() {
    return SizedBox(
        height: subText.isEmpty ? _textHeight : _textHeight + _subTextHeight,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: AutoSizeText(
                      text,
                      maxLines: 1,
                      style: Interface.s16w300n(Interface.dark),
                    ))),
            dlc
                ? Container(
                    width: _dotSize,
                    height: _dotSize,
                    decoration: BoxDecoration(
                      color: Interface.primary,
                      border: Border.all(
                        color: Interface.accentBorder,
                        width: Interface.accentBorderWidth,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ))
                : const SizedBox.shrink()
          ]),
          subText.isNotEmpty
              ? SizedBox(
                  height: _subTextHeight,
                  child: AutoSizeText(
                    subText,
                    maxLines: 1,
                    style: Interface.s12w300n(Interface.disabled),
                  ))
              : const SizedBox.shrink()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
