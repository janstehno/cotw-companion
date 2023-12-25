// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTag extends StatelessWidget {
  final String icon, value;
  final double height;
  final Color color, background;
  final bool isVisible;

  const WidgetTag.big({
    Key? key,
    this.icon = "",
    this.value = "",
    this.height = 30,
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  const WidgetTag.small({
    Key? key,
    this.icon = "",
    this.value = "",
    this.height = 25,
    required this.color,
    required this.background,
    this.isVisible = true,
  }) : super(key: key);

  Widget _buildTag() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: value.isEmpty ? height : null,
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: height,
            minWidth: height,
          ),
          alignment: Alignment.center,
          padding: value.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 4)),
            color: background,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            icon.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(right: value.isNotEmpty ? 7 : 0),
                    child: SvgPicture.asset(
                      icon,
                      width: height / 2,
                      height: height / 2,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ))
                : const SizedBox.shrink(),
            value.isNotEmpty
                ? AutoSizeText(
                    value,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: height <= 25
                        ? Interface.s12w500n(color)
                        : height <= 35
                            ? Interface.s14w500n(color)
                            : Interface.s16w500n(color),
                  )
                : const SizedBox.shrink()
          ]))
    ]);
  }

  Widget _buildWidgets() {
    return isVisible && (icon.isNotEmpty || value.isNotEmpty) ? _buildTag() : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
