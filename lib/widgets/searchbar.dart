// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function? onFilter;

  const WidgetSearchBar({
    Key? key,
    required this.controller,
    required this.onFilter,
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
                      constraints: BoxConstraints(minHeight: 25, maxHeight: 25),
                    ),
                    style: Interface.s16w300n(Interface.dark),
                  ))),
          GestureDetector(
              child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30, right: widget.onFilter != null ? 10 : 30),
                  child: SvgPicture.asset(
                    "assets/graphics/icons/menu_close.svg",
                    width: 15,
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      Interface.dark.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                  )),
              onTap: () {
                setState(() {
                  widget.controller.text = "";
                });
              }),
          widget.onFilter != null
              ? GestureDetector(
                  child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: SvgPicture.asset(
                        "assets/graphics/icons/filter.svg",
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          Interface.dark,
                          BlendMode.srcIn,
                        ),
                      )),
                  onTap: () {
                    widget.onFilter!();
                  })
              : const SizedBox.shrink()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
