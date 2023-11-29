// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTextFieldIndicator extends StatelessWidget {
  final String? icon;
  final bool correct, decimal, numberOnly;
  final TextEditingController controller;

  final double height = 60;

  final double _iconSize = 15;
  final double _indicatorSize = 10;

  const WidgetTextFieldIndicator({
    Key? key,
    this.icon,
    required this.controller,
    required this.correct,
    this.decimal = true,
    this.numberOnly = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: height,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset(
                  icon ?? "assets/graphics/icons/edit.svg",
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(
                    Interface.disabled,
                    BlendMode.srcIn,
                  ),
                )),
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: WidgetTextField(
                      decimal: decimal,
                      numberOnly: numberOnly,
                      controller: controller,
                    ))),
            Expanded(
                flex: 0,
                child: AnimatedContainer(
                    width: _indicatorSize,
                    height: _indicatorSize,
                    margin: const EdgeInsets.only(right: 5, left: 15),
                    duration: const Duration(milliseconds: 200),
                    decoration: ShapeDecoration(
                      color: correct ? Interface.green : Interface.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    )))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
