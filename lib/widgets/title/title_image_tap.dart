import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/title/title_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetTitleImageTap extends WidgetTitleTap {
  final Widget _child;
  final Color? _titleColor;

  const WidgetTitleImageTap(
    super.text, {
    super.key,
    Color? titleColor,
    required Widget child,
    required super.onTap,
  })  : _titleColor = titleColor,
        _child = child;

  @override
  Color get titleColor => _titleColor ?? super.titleColor;

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _child,
            WidgetPadding.h30(
              child: Row(
                children: [
                  Expanded(
                    child: WidgetMargin.right(30, child: super.buildRow()),
                  ),
                ],
              ),
            ).blurry(
              blur: 3,
              elevation: 0,
              padding: EdgeInsets.zero,
              color: Interface.alwaysDark.withValues(alpha: 0.6),
              shadowColor: Interface.transparent,
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
      ),
    );
  }
}
