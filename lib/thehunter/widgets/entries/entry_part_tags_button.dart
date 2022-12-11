// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:flutter/material.dart';

class EntryPartTagsButton extends StatelessWidget {
  final String icon;
  final double size;
  final int? buttonColor;
  final int? buttonBackground;
  final List<WidgetTag> tags;
  final Function? onTap;

  const EntryPartTagsButton({Key? key, this.icon = "", this.size = 40, this.buttonColor, this.buttonBackground, required this.tags, this.onTap}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: icon.isNotEmpty ? size : null,
        margin: const EdgeInsets.only(top: 30),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: icon.isNotEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.end,
            children: [
              Expanded(child: Container(padding: EdgeInsets.only(right: icon.isNotEmpty ? 30 : 0), alignment: Alignment.centerLeft, child: Row(children: tags))),
              icon.isNotEmpty
                  ? Container(
                      width: 100,
                      alignment: Alignment.bottomCenter,
                      child: WidgetButton(
                          icon: icon,
                          size: size,
                          color: buttonColor,
                          background: buttonBackground,
                          onTap: () {
                            onTap!();
                          }))
                  : Container()
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
