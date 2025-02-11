import 'package:cotwcompanion/widgets/section/section_indicator.dart';
import 'package:flutter/cupertino.dart';

class WidgetSectionIndicatorTap extends WidgetSectionIndicator {
  final bool _isShown;
  final Function _onTap;

  const WidgetSectionIndicatorTap(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.background,
    super.indicatorSize,
    super.indicatorColor,
    super.indicatorLeft,
    bool isShown = true,
    required Function onTap,
  })  : _isShown = isShown,
        _onTap = onTap;

  Function get onTap => _onTap;

  bool get isShown => _isShown;

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => _onTap(),
      child: super.buildContainer(),
    );
  }

  @override
  Widget buildIndicator() {
    if (_isShown) return super.buildIndicator();
    return SizedBox(width: super.size);
  }
}
