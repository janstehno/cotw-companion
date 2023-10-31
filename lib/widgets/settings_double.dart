// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSettingsDouble extends StatelessWidget {
  final String text;
  final bool alignRight;
  final bool isActive;
  final Function onTap;

  final double height = 60;

  final double _indicatorSize = 20;

  const WidgetSettingsDouble({
    Key? key,
    required this.text,
    this.alignRight = false,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: height,
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                alignRight
                    ? Expanded(
                        child: AutoSizeText(
                          text,
                          textAlign: TextAlign.end,
                          style: Interface.s16w300n(Interface.dark),
                        ),
                      )
                    : const SizedBox.shrink(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _indicatorSize,
                  height: _indicatorSize,
                  margin: EdgeInsets.only(left: alignRight ? 15 : 0, right: alignRight ? 0 : 15),
                  decoration: BoxDecoration(
                    color: isActive ? Interface.primary : Interface.disabled,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                alignRight
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: AutoSizeText(
                          text,
                          textAlign: TextAlign.start,
                          style: Interface.s16w300n(Interface.dark),
                        ),
                      )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
