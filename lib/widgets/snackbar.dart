// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:flutter/material.dart';

class WidgetSnackBar extends StatelessWidget {
  final String text, icon;
  final Function? onTap;

  const WidgetSnackBar({
    Key? key,
    required this.text,
    this.icon = "",
    this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 75,
        color: Interface.search,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(right: icon.isNotEmpty ? 30 : 0),
                  child: AutoSizeText(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Interface.s14w300n(Interface.dark),
                  ))),
          icon.isEmpty
              ? Container()
              : WidgetButtonIcon(
                  icon: icon,
                  onTap: () {
                    onTap!();
                  },
                )
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
