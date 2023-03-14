// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetSelfSwitch extends StatefulWidget {
  final double size;
  final int? activeColor;
  final int? inactiveColor;
  final int? activeBackground;
  final int? inactiveBackground;
  final String text;
  final String? inactiveText;
  final String icon;
  final String? inactiveIcon;
  final bool visible;

  const WidgetSelfSwitch(
      {Key? key,
      this.text = "",
      this.inactiveText,
      this.icon = "",
      this.inactiveIcon,
      this.size = 50,
      this.activeColor,
      this.inactiveColor,
      this.activeBackground,
      this.inactiveBackground,
      this.visible = true})
      : super(key: key);

  @override
  WidgetSelfSwitchState createState() => WidgetSelfSwitchState();
}

class WidgetSelfSwitchState extends State<WidgetSelfSwitch> {
  bool isActive = false;

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          setState(() {
            isActive = !isActive;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.size,
          width: (widget.icon.isNotEmpty && widget.text.isEmpty) || (widget.icon.isEmpty && widget.text.isEmpty) ? widget.size : null,
          alignment: Alignment.center,
          padding: widget.icon.isNotEmpty && widget.text.isEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.size / 4)),
              color: isActive
                  ? Color(widget.activeBackground ?? widget.inactiveBackground ?? Values.colorTransparent)
                  : Color(widget.inactiveBackground ?? Values.colorTransparent)),
          child: widget.icon.isNotEmpty && widget.text.isEmpty
              ? SvgPicture.asset(
                  isActive ? widget.icon : widget.inactiveIcon ?? widget.icon,
                  width: widget.size / 1.5,
                  height: widget.size / 1.5,
                  color: isActive ? Color(widget.activeColor ?? widget.inactiveColor ?? Values.colorTransparent) : Color(widget.inactiveColor ?? Values.colorTransparent),
                )
              : widget.icon.isEmpty && widget.text.isNotEmpty
                  ? AutoSizeText(isActive ? widget.text : widget.inactiveText ?? widget.text,
                      maxLines: 1,
                      style: TextStyle(
                          color: isActive
                              ? Color(widget.activeColor ?? widget.inactiveColor ?? Values.colorTransparent)
                              : Color(widget.inactiveColor ?? Values.colorTransparent),
                          fontSize: Values.fontSize18,
                          fontWeight: FontWeight.w600))
                  : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return widget.visible
        ? (widget.icon.isNotEmpty && widget.text.isEmpty) || (widget.icon.isEmpty && widget.text.isNotEmpty) || (widget.icon.isEmpty && widget.text.isEmpty)
            ? _buildWidgets()
            : Container()
        : Container();
  }
}
