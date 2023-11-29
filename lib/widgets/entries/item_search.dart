// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryFastSearch extends StatefulWidget {
  final int index;
  final String icon;
  final String text;
  final String subText;
  final Function callback;
  final Widget activity;

  final double height = 60;

  const EntryFastSearch({
    Key? key,
    required this.index,
    required this.icon,
    required this.text,
    this.subText = "",
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
            height: widget.height,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30),
            color: Utils.background(widget.index),
            child: Row(
              mainAxisSize: MainAxisSize.max,
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
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.text,
                          style: Interface.s16w300n(Interface.dark),
                        ),
                        widget.subText.isNotEmpty
                            ? AutoSizeText(
                                widget.subText,
                                style: Interface.s12w300n(Interface.disabled),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
