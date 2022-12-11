// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTextField extends StatelessWidget {
  final double size;
  final int? color;
  final int? background;
  final bool numberOnly;
  final bool correct;
  final TextEditingController controller;

  const WidgetTextField({Key? key, this.size = 60, this.color, this.background, this.numberOnly = false, required this.correct, required this.controller}) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        height: size,
        alignment: Alignment.centerLeft,
        color: Color(background ?? Values.colorContentSubSubTitleBackground),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset("assets/graphics/icons/edit.svg", width: 15, height: 15, color: Color(Values.colorDisabled))),
          Expanded(
              child: TextField(
                  keyboardType: numberOnly ? const TextInputType.numberWithOptions(decimal: true, signed: false) : TextInputType.text,
                  maxLines: 1,
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Color(Values.colorPrimary),
                  decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: Values.textFieldBottom)),
                  style: TextStyle(color: Color(color ?? Values.colorContentSubTitle), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))),
          Expanded(
              flex: 0,
              child: AnimatedContainer(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(right: 5, left: 15),
                  duration: const Duration(milliseconds: 200),
                  decoration: ShapeDecoration(
                      color: correct ? const Color(Values.colorSeventh) : const Color(Values.colorFirst),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)))))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
