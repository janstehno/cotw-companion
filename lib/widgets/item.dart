// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class WidgetItem extends StatelessWidget {
  final String text, itemIcon, buttonIcon;
  final Color textColor, iconColor, buttonColor, buttonBackground;
  final double buttonSize;
  final List<WidgetTag> tags;
  final Function? onTap;

  const WidgetItem({
    Key? key,
    required this.text,
    required this.itemIcon,
    required this.textColor,
    required this.iconColor,
    this.buttonIcon = "",
    this.buttonColor = Colors.transparent,
    this.buttonBackground = Colors.transparent,
    this.buttonSize = 40,
    this.tags = const [],
    this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.only(right: 30),
                child: AutoSizeText(text,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: textColor,
                      fontSize: Interface.s24,
                      fontWeight: FontWeight.w600,
                    )))),
        Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              itemIcon,
              color: iconColor,
              width: 70,
              height: 70,
            ))
      ]),
      Container(
          height: 40,
          margin: const EdgeInsets.only(top: 30),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: buttonIcon.isNotEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(right: buttonIcon.isNotEmpty ? 30 : 0),
                  alignment: Alignment.centerLeft,
                  child: Row(children: tags),
                )),
                buttonIcon.isNotEmpty
                    ? Container(
                        width: 100,
                        alignment: Alignment.bottomCenter,
                        child: WidgetButton.withIcon(
                          icon: buttonIcon,
                          buttonSize: buttonSize,
                          color: buttonColor,
                          background: buttonBackground,
                          onTap: () {
                            onTap!();
                          },
                        ))
                    : Container()
              ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
