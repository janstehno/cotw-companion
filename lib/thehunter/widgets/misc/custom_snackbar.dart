// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar extends StatelessWidget {
  final String text;
  final String buttonIcon;
  final double size;
  final int? color;
  final int? background;
  final int? buttonColor;
  final bool visible;
  final Function? onTap;

  const WidgetSnackBar(
      {Key? key, required this.text, this.buttonIcon = "", this.size = 50, this.color, this.background, this.buttonColor, this.visible = true, this.onTap})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: Color(background ?? Values.colorTransparent),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(right: buttonIcon.isNotEmpty ? 30 : 0),
                  child: AutoSizeText(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color(color ?? Values.colorDark), fontSize: Values.fontSize14, fontWeight: FontWeight.w400),
                  ))),
          buttonIcon.isEmpty
              ? Container()
              : WidgetButton(
                  size: size,
                  icon: buttonIcon,
                  color: buttonColor,
                  background: Values.colorTransparent,
                  onTap: () {
                    onTap!();
                  })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
