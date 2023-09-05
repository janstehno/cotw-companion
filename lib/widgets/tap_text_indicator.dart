// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTapTextIndicator extends StatelessWidget {
  final String text;
  final Color? color, background;
  final int maxLines;
  final bool isActive;
  final Function onTap;

  const WidgetTapTextIndicator({
    Key? key,
    required this.text,
    this.color,
    this.background,
    this.maxLines = 1,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: 70,
            color: background ?? Colors.transparent,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        text,
                        maxLines: maxLines,
                        textAlign: TextAlign.start,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isActive ? color ?? Interface.primary : Interface.disabled,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
