// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryMenu extends StatelessWidget {
  final String icon, text;
  final Function? onTap;

  const EntryMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap!();
        },
        child: Container(
            height: 60,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(children: [
              Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(
                    icon,
                    width: 22,
                    height: 22,
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
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
