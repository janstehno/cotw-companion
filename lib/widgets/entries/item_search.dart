// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryFastSearch extends StatefulWidget {
  final int index;
  final String icon;
  final String text;
  final Function callback;
  final Widget activity;

  const EntryFastSearch({
    Key? key,
    required this.index,
    required this.icon,
    required this.text,
    required this.callback,
    required this.activity,
  }) : super(key: key);

  @override
  EntryFastSearchState createState() => EntryFastSearchState();
}

class EntryFastSearchState extends State<EntryFastSearch> {
  final double _iconSize = 20;

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(context, MaterialPageRoute(builder: (context) => widget.activity));
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            color: widget.index % 2 == 0 ? Interface.even : Interface.odd,
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(
                    Interface.disabled,
                    BlendMode.srcIn,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: AutoSizeText(
                      widget.text,
                      style: Interface.s16w300n(Interface.dark),
                    )),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
