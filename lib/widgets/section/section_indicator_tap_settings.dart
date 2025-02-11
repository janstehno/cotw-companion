import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class WidgetSectionIndicatorTapSettings extends WidgetSectionIndicatorTap {
  final bool _needsWarning;

  const WidgetSectionIndicatorTapSettings(
    super.text, {
    super.key,
    super.subtext,
    super.color,
    super.background,
    super.indicatorSize,
    super.indicatorColor,
    super.indicatorLeft,
    super.isShown = true,
    bool needsWarning = false,
    required super.onTap,
  }) : _needsWarning = needsWarning;

  Widget _buildWarning() {
    return WidgetPadding.fromLTRB(
      30,
      0,
      30 + Values.indicatorSize + 30,
      20,
      background: titleBackground,
      child: WidgetText(
        tr("SETTINGS_DATA_MINED_WARNING").toUpperCase(),
        color: Interface.red,
        style: Style.normal.s12.w500,
        autoSize: false,
      ),
    );
  }

  @override
  Widget buildContainer() {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          super.buildContainer(),
          if (_needsWarning) _buildWarning(),
        ],
      ),
    );
  }

  @override
  Widget buildIndicator() {
    if (isShown) return super.buildIndicator();
    return SizedBox(width: super.size);
  }
}
