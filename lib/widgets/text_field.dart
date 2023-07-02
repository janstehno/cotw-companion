// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTextField extends StatelessWidget {
  final Color? color, background;
  final bool correct, numberOnly;
  final TextEditingController controller;

  const WidgetTextField({
    Key? key,
    required this.color,
    required this.background,
    required this.controller,
    required this.correct,
    this.numberOnly = true,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: 60,
        alignment: Alignment.centerLeft,
        color: background,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset(
                "assets/graphics/icons/edit.svg",
                width: 15,
                height: 15,
                color: Interface.disabled,
              )),
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 3),
                  child: TextField(
                      keyboardType: numberOnly
                          ? const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            )
                          : TextInputType.text,
                      maxLines: 1,
                      controller: controller,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Interface.primary,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )))),
          Expanded(
              flex: 0,
              child: AnimatedContainer(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(right: 5, left: 15),
                  duration: const Duration(milliseconds: 200),
                  decoration: ShapeDecoration(
                    color: correct ? Interface.green : Interface.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
