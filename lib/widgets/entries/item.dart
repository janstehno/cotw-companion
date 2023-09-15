// Copyright (c) 2022 - 2023 Jan Stehno

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

  const EntryItem({
    Key? key,
    required this.text,
    required this.itemIcon,
    this.buttonIcon = "",
    this.tags = const [],
    this.onButtonTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(right: 30),
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  text,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: Interface.s18w300n(Interface.dark),
                ))),
        Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              itemIcon,
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                Interface.dark,
                BlendMode.srcIn,
              ),
            ))
      ]),
      Container(
          margin: const EdgeInsets.only(top: 30),
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
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.start,
                    children: tags,
                  ),
                )),
                buttonIcon.isNotEmpty
                    ? Container(
                        width: 70,
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
              ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
