// Copyright (c) 2022 Jan Stehno

import 'package:flutter/material.dart';

class WidgetContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Alignment alignment;
  final bool visible;
  final Widget child;

  const WidgetContainer(
      {Key? key,
      this.width,
      this.height,
      this.padding = const EdgeInsets.all(30),
      this.margin = const EdgeInsets.all(0),
      this.alignment = Alignment.center,
      this.visible = true,
      required this.child})
      : super(key: key);

  Widget _buildWidgets() {
    return Container(width: width, height: height, padding: padding, margin: margin, alignment: alignment, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return visible ? _buildWidgets() : Container();
  }
}
