import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WidgetPageIndicator extends StatelessWidget {
  final int _length;
  final Color _color, _activeColor;
  final double _height;
  final PageController _pageController;

  const WidgetPageIndicator(
    int length, {
    super.key,
    required double height,
    required Color iColor,
    required Color aColor,
    required PageController pageController,
  })  : _length = length,
        _color = iColor,
        _activeColor = aColor,
        _height = height,
        _pageController = pageController;

  DotDecoration get activeDot {
    return DotDecoration(
      width: Values.dotSize,
      height: Values.dotSize,
      color: _activeColor,
      borderRadius: BorderRadius.circular(Values.dotSize / 2.5),
    );
  }

  DotDecoration get inactiveDot {
    return DotDecoration(
      width: Values.dotSize,
      height: Values.dotSize,
      color: _color,
      borderRadius: BorderRadius.circular(Values.dotSize / 2.5),
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: _height,
      child: WidgetPadding.h30(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: _pageController,
          count: _length,
          effect: CustomizableEffect(
            activeDotDecoration: activeDot,
            dotDecoration: inactiveDot,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
