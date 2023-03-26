// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTitle extends StatelessWidget {
  final String text, subText;
  final Color? textColor, subTextColor, background;
  final Alignment alignment;
  final bool isSubTitle;

  const WidgetTitle({
    Key? key,
    required this.text,
    this.textColor,
    this.subTextColor,
    this.background,
    this.subText = "",
    this.alignment = Alignment.centerLeft,
    this.isSubTitle = false,
  }) : super(key: key);

  const WidgetTitle.sub({
    Key? key,
    required this.text,
    this.textColor,
    this.subTextColor,
    this.background,
    this.subText = "",
    this.alignment = Alignment.centerLeft,
    this.isSubTitle = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: background ?? (isSubTitle ? Interface.subSubTitleBackground : Interface.subTitleBackground),
        alignment: alignment,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: subText.isEmpty
            ? AutoSizeText(text.toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: textColor ?? Interface.title,
                  fontSize: isSubTitle ? Interface.s20 : Interface.s24,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Title',
                ))
            : Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                AutoSizeText(text.toUpperCase(),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: textColor ?? Interface.title,
                      fontSize: isSubTitle ? Interface.s20 : Interface.s24,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Title',
                    )),
                AutoSizeText(subText,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: subTextColor ?? Interface.title,
                      fontSize: Interface.s14,
                      fontWeight: FontWeight.w400,
                    ))
              ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
