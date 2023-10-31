// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTitleSmallPrice extends WidgetTitleSmall {
  final double _iconSize = 10;

  const WidgetTitleSmallPrice({
    super.key,
    required super.primaryText,
  });

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Interface.sectionTitle,
        alignment: alignment,
        padding: const EdgeInsets.only(right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            primaryText == "0" || primaryText == "-1"
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(right: 2.5),
                    child: SvgPicture.asset(
                      "assets/graphics/icons/money.svg",
                      width: _iconSize,
                      height: _iconSize,
                      colorFilter: ColorFilter.mode(
                        Interface.disabled,
                        BlendMode.srcIn,
                      ),
                    )),
            AutoSizeText(
              primaryText == "0"
                  ? tr('free')
                  : primaryText == "-1"
                      ? tr('none')
                      : primaryText,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: Interface.s12w300n(Interface.disabled),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
