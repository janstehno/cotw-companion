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
  final Function? onTap;

  const EntryItem({
    Key? key,
    required this.text,
    required this.itemIcon,
    this.buttonIcon = "",
    this.tags = const [],
    this.onTap,
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
            width: 100,
            height: 70,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 17.5, right: 17.5),
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
          height: 40,
          margin: const EdgeInsets.only(top: 30),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: buttonIcon.isNotEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(right: buttonIcon.isNotEmpty ? 30 : 0),
                  alignment: Alignment.centerLeft,
                  child: Row(children: tags),
                )),
                buttonIcon.isNotEmpty
                    ? Container(
                        width: 100,
                        alignment: Alignment.bottomCenter,
                        child: WidgetButtonIcon(
                          icon: buttonIcon,
                          color: Interface.accent,
                          background: Interface.primary,
                          onTap: () {
                            onTap!();
                          },
                        ))
                    : Container()
              ]))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
