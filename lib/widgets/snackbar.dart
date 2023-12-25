// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetSnackBar extends StatelessWidget {
  final String text, icon;
  final Process process;
  final Function? onSnackBarTap;

  final double height = 75;

  final double _iconSize = 15;
  final double _iconPadding = 5;

  const WidgetSnackBar({
    Key? key,
    required this.text,
    this.icon = "",
    required this.process,
    this.onSnackBarTap,
  }) : super(key: key);

  Color _getBackground() {
    switch (process) {
      case Process.success:
        return Interface.lightGreen;
      case Process.error:
        return Interface.red;
      case Process.info:
        return Interface.search;
    }
  }

  Color _getColor() {
    switch (process) {
      case Process.success:
        return Interface.alwaysDark;
      case Process.error:
        return Interface.alwaysLight;
      case Process.info:
        return Interface.dark;
    }
  }

  String _getIcon() {
    switch (process) {
      case Process.success:
        return "assets/graphics/icons/accept.svg";
      case Process.error:
        return "assets/graphics/icons/menu_close.svg";
      case Process.info:
        return "assets/graphics/icons/other.svg";
    }
  }

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: _getBackground(),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: _iconSize + _iconPadding,
              height: _iconSize + _iconPadding,
              padding: EdgeInsets.all(_iconPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _getColor().withOpacity(0.85),
              ),
              child: SvgPicture.asset(
                _getIcon(),
                width: _iconSize,
                height: _iconSize,
                colorFilter: ColorFilter.mode(
                  _getBackground(),
                  BlendMode.srcIn,
                ),
              )),
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: icon.isNotEmpty ? 30 : 0),
                  child: AutoSizeText(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Interface.s14w300n(_getColor()),
                  ))),
          icon.isEmpty
              ? const SizedBox.shrink()
              : WidgetButtonIcon(
                  icon: icon,
                  onTap: () {
                    if (onSnackBarTap != null) onSnackBarTap!();
                  },
                )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
