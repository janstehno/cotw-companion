// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryMenu extends StatelessWidget {
  final String icon, text;
  final Function? onMenuTap;

  final double height = 60;

  final double _iconSize = 30;

  const EntryMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.onMenuTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
      child: Container(
          height: height,
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(children: [
            Container(
                width: _iconSize,
                height: _iconSize,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  icon,
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                    Interface.dark,
                    BlendMode.srcIn,
                  ),
                )),
            Expanded(
                child: AutoSizeText(
              text,
              maxLines: 1,
              style: Interface.s18w300n(Interface.dark),
            ))
          ])),
      onTap: () {
        if (onMenuTap != null) onMenuTap!();
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
