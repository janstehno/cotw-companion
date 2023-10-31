// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function? onFilter;

  final double height = 40;

  const WidgetSearchBar({
    Key? key,
    required this.controller,
    required this.onFilter,
  }) : super(key: key);

  @override
  WidgetSearchBarState createState() => WidgetSearchBarState();
}

class WidgetSearchBarState extends State<WidgetSearchBar> {
  final double _iconWidth = 25;
  final double _iconSize = 15;

  Widget _buildWidgets() {
    return Container(
        height: widget.height,
        color: Interface.search,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: _iconWidth,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/graphics/icons/search.svg",
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(
                    Interface.dark,
                    BlendMode.srcIn,
                  ),
                )),
            Expanded(
                child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: WidgetTextField(
                      controller: widget.controller,
                    ))),
            GestureDetector(
                child: Container(
                    width: _iconWidth,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/graphics/icons/menu_close.svg",
                      width: _iconSize,
                      height: _iconSize,
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
                        width: _iconWidth,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/graphics/icons/filter.svg",
                          width: _iconSize,
                          height: _iconSize,
                          colorFilter: ColorFilter.mode(
                            Interface.dark,
                            BlendMode.srcIn,
                          ),
                        )),
                    onTap: () {
                      widget.onFilter!();
                    })
                : const SizedBox.shrink()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
