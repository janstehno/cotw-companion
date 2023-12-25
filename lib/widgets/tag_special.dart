// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTag extends StatelessWidget {
  final String identifier, value;
  final double height;
  final Color color, background;
  final bool isVisible, withIcon;

  const WidgetTag.special({
    Key? key,
    required this.identifier,
    required this.value,
    this.height = 30,
    required this.color,
    required this.background,
    this.isVisible = true,
    this.withIcon = false,
  }) : super(key: key);

  Widget _buildTag() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: height,
            minWidth: height,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 4)),
            color: background,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: Colors.transparent,
                  child: withIcon
                      ? SvgPicture.asset(
                          identifier,
                          width: height / 2,
                          height: height / 2,
                          colorFilter: ColorFilter.mode(
                            color,
                            BlendMode.srcIn,
                          ),
                        )
                      : AutoSizeText(
                          identifier,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: height <= 25
                              ? Interface.s12w500n(color)
                              : height <= 35
                                  ? Interface.s14w500n(color)
                                  : Interface.s16w500n(color),
                        )),
              Container(
                  height: height,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(height / 4),
                      bottomRight: Radius.circular(height / 4),
                    ),
                    color: color.withOpacity(0.75),
                  ),
                  child: AutoSizeText(
                    value,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: height <= 25
                        ? Interface.s14w500n(background)
                        : height <= 35
                            ? Interface.s16w500n(background)
                            : Interface.s18w500n(background),
                  ))
            ],
          ))
    ]);
  }

  Widget _buildWidgets() {
    return isVisible ? _buildTag() : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
