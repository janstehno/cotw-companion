// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:flutter/material.dart';

class WidgetLoadoutSwitch extends WidgetTitleBigSwitch {
  final int index;

  const WidgetLoadoutSwitch({
    super.key,
    required super.primaryText,
    super.secondaryText = "",
    super.maxLines = 1,
    super.upperCase = false,
    super.icon = "",
    super.activeIcon = "",
    super.color,
    super.background,
    super.activeColor,
    super.activeBackground,
    super.isActive = false,
    required super.onTap,
    required this.index,
  });

  @override
  Widget buildTitle(Widget? additional) {
    return Container(
        height: height,
        color: index % 2 == 0 ? Interface.even : Interface.odd,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(right: additional == null ? 0 : 30),
              child: buildText(
                Interface.s18w300n(Interface.dark),
                Interface.s12w300n(Interface.disabled),
              ),
            )),
            additional ?? const SizedBox.shrink(),
          ],
        ));
  }

  @override
  Widget buildWidgets() {
    return buildTitle(buildSwitch());
  }
}
