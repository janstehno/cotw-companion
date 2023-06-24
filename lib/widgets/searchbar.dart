// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSearchBar extends StatefulWidget {
  final Color? color, background;
  final TextEditingController controller;

  const WidgetSearchBar({
    Key? key,
    this.color,
    this.background,
    required this.controller,
  }) : super(key: key);

  @override
  WidgetSearchBarState createState() => WidgetSearchBarState();
}

class WidgetSearchBarState extends State<WidgetSearchBar> {
  Widget _buildWidgets() {
    return Container(
        height: 40,
        color: widget.background ?? Interface.searchBackground,
        child: Row(children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SvgPicture.asset(
                "assets/graphics/icons/search.svg",
                height: 15,
                width: 15,
                color: widget.color ?? Interface.search,
              )),
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                      controller: widget.controller,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Interface.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: Interface.textFieldBottomPadding),
                      ),
                      style: TextStyle(
                        color: widget.color ?? Interface.search,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w400,
                      )))),
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset(
                    "assets/graphics/icons/menu_close.svg",
                    width: 15,
                    height: 15,
                    color: Interface.disabled,
                  )),
              onTap: () {
                setState(() {
                  widget.controller.text = "";
                });
              })
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
