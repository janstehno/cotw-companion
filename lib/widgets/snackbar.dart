// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSnackBar extends StatelessWidget {
  final String text, icon;
  final Process process;
  final Function? onSnackBarTap;

  final double height = 75;

  final double _iconSize = 10;

  const WidgetSnackBar({
    Key? key,
    required this.text,
    this.icon = "",
    required this.process,
    this.onSnackBarTap,
  }) : super(key: key);

  Color _getColor() {
    switch (process) {
      case Process.success:
        return Interface.lightGreen;
      case Process.error:
        return Interface.red;
      case Process.info:
        return Interface.grey;
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
        color: Interface.search,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          SvgPicture.asset(
            _getIcon(),
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              _getColor(),
              BlendMode.srcIn,
            ),
          ),
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
