// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSearchBar extends StatefulWidget {
  final int? color;
  final int? background;
  final TextEditingController controller;

  const WidgetSearchBar({Key? key, this.color, this.background, required this.controller}) : super(key: key);

  @override
  WidgetSearchBarState createState() => WidgetSearchBarState();
}

class WidgetSearchBarState extends State<WidgetSearchBar> {
  Widget _buildWidgets() {
    return Container(
        height: 40,
        color: Color(widget.background ?? Values.colorSearchBackground),
        child: Row(children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SvgPicture.asset("assets/graphics/icons/search.svg", height: 15, width: 15, color: Color(widget.color ?? Values.colorSearch))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                      controller: widget.controller,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Color(Values.colorPrimary),
                      decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: Values.textFieldBottom)),
                      style: TextStyle(color: Color(widget.color ?? Values.colorSearch), fontSize: Values.fontSize18, fontWeight: FontWeight.w400)))),
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset("assets/graphics/icons/menu_close.svg", width: 15, height: 15, color: Color(Values.colorDisabled))),
              onTap: () {
                setState(() {
                  widget.controller.text = "";
                });
              })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
