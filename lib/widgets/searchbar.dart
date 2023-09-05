// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSearchBar extends StatefulWidget {
  final TextEditingController controller;

  const WidgetSearchBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  WidgetSearchBarState createState() => WidgetSearchBarState();
}

class WidgetSearchBarState extends State<WidgetSearchBar> {
  Widget _buildWidgets() {
    return Container(
        height: 40,
        color: Interface.search,
        child: Row(children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SvgPicture.asset(
                "assets/graphics/icons/search.svg",
                height: 15,
                width: 15,
                colorFilter: ColorFilter.mode(
                  Interface.dark,
                  BlendMode.srcIn,
                ),
              )),
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: widget.controller,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Interface.dark,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: -33),
                    ),
                    style: Interface.s16w300n(Interface.dark),
                  ))),
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SvgPicture.asset(
                    "assets/graphics/icons/menu_close.svg",
                    width: 15,
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      Interface.dark,
                      BlendMode.srcIn,
                    ),
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
