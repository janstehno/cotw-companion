// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetButtonIconText extends StatelessWidget {
  final String icon, text;
  final Color? color, background;
  final double buttonHeight;
  final double? buttonWidth;
  final Function onTap;
  final bool isExternalLink;

  const WidgetButtonIconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.buttonHeight,
    this.buttonWidth,
    this.color,
    this.background,
    required this.onTap,
    this.isExternalLink = false,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Container(
                height: buttonHeight,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  color: background ?? Interface.primary,
                ),
                child: Row(children: [
                  SvgPicture.asset(
                    icon,
                    height: buttonHeight / 1.75,
                    width: buttonHeight / 1.75,
                    colorFilter: ColorFilter.mode(
                      color ?? Interface.accent,
                      BlendMode.srcIn,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 7, right: 3),
                      child: AutoSizeText(
                        text,
                        style: buttonHeight <= 25
                            ? Interface.s14w500n(color ?? Interface.accent)
                            : buttonHeight <= 35
                                ? Interface.s16w500n(color ?? Interface.accent)
                                : Interface.s18w500n(color ?? Interface.accent),
                      )),
                  isExternalLink
                      ? SvgPicture.asset(
                          "assets/graphics/icons/external_link.svg",
                          height: buttonHeight / 4,
                          width: buttonHeight / 4,
                          colorFilter: ColorFilter.mode(
                            color ?? Interface.accent,
                            BlendMode.srcIn,
                          ),
                        )
                      : const SizedBox.shrink()
                ]))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
