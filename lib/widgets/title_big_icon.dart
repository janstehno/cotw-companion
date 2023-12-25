// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTitleBigIcon extends WidgetTitleBig {
  final String icon;

  final double _iconWidth = 20;

  const WidgetTitleBigIcon({
    super.key,
    required super.primaryText,
    super.secondaryText,
    required this.icon,
  });

  Widget _buildIcon() {
    return Container(
        height: WidgetTitleBig.height,
        color: Interface.title,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          icon,
          width: _iconWidth,
          colorFilter: ColorFilter.mode(Interface.disabled, BlendMode.srcIn),
        ));
  }

  @override
  Widget buildWidgets() {
    return buildTitle(_buildIcon());
  }
}
