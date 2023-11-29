// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryItem extends StatelessWidget {
  final String text, itemIcon, buttonIcon;
  final List<WidgetTag> tags;
  final Function? onButtonTap;

  final double _iconSize = 70;
  final double _wrapSpace = 5;

  const EntryItem({
    Key? key,
    required this.text,
    this.itemIcon = "",
    this.buttonIcon = "",
    this.tags = const [],
    this.onButtonTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    text,
                    maxLines: itemIcon.isNotEmpty ? 3 : 2,
                    textAlign: TextAlign.left,
                    style: Interface.s18w300n(Interface.dark),
                  ))),
          itemIcon.isNotEmpty
              ? Container(
                  width: _iconSize,
                  height: _iconSize,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    itemIcon,
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(
                      Interface.dark,
                      BlendMode.srcIn,
                    ),
                  ))
              : const SizedBox.shrink(),
        ],
      ),
      Container(
          margin: EdgeInsets.only(top: itemIcon.isNotEmpty ? 30 : 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: buttonIcon.isNotEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(right: buttonIcon.isNotEmpty ? 30 : 0),
                child: Wrap(
                  spacing: _wrapSpace,
                  runSpacing: _wrapSpace,
                  alignment: WrapAlignment.start,
                  children: tags,
                ),
              )),
              buttonIcon.isNotEmpty
                  ? Container(
                      width: _iconSize,
                      alignment: Alignment.bottomCenter,
                      child: WidgetButtonIcon(
                        icon: buttonIcon,
                        color: Interface.accent,
                        background: Interface.primary,
                        onTap: () {
                          if (onButtonTap != null) onButtonTap!();
                        },
                      ))
                  : const SizedBox.shrink()
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
