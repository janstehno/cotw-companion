// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryIcon extends StatelessWidget {
  final String text;
  final String icon;
  final double size;
  final int color;
  final int background;
  final bool isActive;
  final bool noInactiveOpacity;

  const EntryIcon(
      {Key? key, this.text = "", this.icon = "", this.size = 50, required this.color, required this.background, this.isActive = true, this.noInactiveOpacity = false})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(
      height: size,
      width: icon.isNotEmpty && text.isEmpty ? size : null,
      alignment: Alignment.center,
      padding: icon.isNotEmpty && text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shadows: isActive ? [BoxShadow(color: Color(Values.colorShadow), spreadRadius: -3, blurRadius: 5)] : [],
        color: isActive ? Color(background) : Color(Values.colorDisabled).withOpacity(noInactiveOpacity ? 1 : 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size / 3)),
      ),
      child: icon.isNotEmpty && text.isEmpty
          ? SvgPicture.asset(
              icon,
              width: size / 2.3,
              height: size / 2.3,
              color: isActive ? Color(color) : Color(Values.colorDark).withOpacity(noInactiveOpacity ? 1 : 0.3),
            )
          : icon.isEmpty && text.isNotEmpty
              ? AutoSizeText(text, maxLines: 1, style: TextStyle(color: Color(color), fontSize: Values.fontSize18, fontWeight: FontWeight.w600))
              : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (icon.isNotEmpty && text.isEmpty) || (icon.isEmpty && text.isNotEmpty) ? _buildWidgets() : Container();
  }
}
