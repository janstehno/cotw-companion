import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_link.dart';
import 'package:cotwcompanion/widgets/subtitle/subtitle.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetSurveyBanner extends StatelessWidget {
  const WidgetSurveyBanner({
    super.key,
  });

  Widget _buildText() {
    return WidgetText(
      tr("SURVEY:TEXT"),
      color: Interface.alwaysLight,
      style: Style.normal.s14.w300,
      textAlign: TextAlign.center,
      autoSize: false,
    );
  }

  Widget _buildButton() {
    return WidgetPadding.h30v20(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetButtonLink(
            tr("SURVEY:BUTTON"),
            onTap: () {
              Utils.redirectTo(Uri.parse(
                  "https://docs.google.com/forms/d/e/1FAIpQLSc64mx7f1TpbUnIWnaeKbnIksVVN3lKp7Wdys_DHR50vT504w/viewform?usp=preview"));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPowered() {
    return WidgetText(
      "Powered by Google Forms",
      color: Interface.alwaysLight.withAlpha(200),
      style: Style.normal.s10.w300,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildShadow() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.15, 1],
          colors: [Interface.alwaysDark.withAlpha(200), Interface.transparent],
        ),
      ),
    );
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        WidgetSubtitle(tr("SURVEY:TITLE")),
        WidgetPadding.fromLTRB(
          30,
          20,
          30,
          0,
          background: Interface.alwaysDark.withAlpha(200),
          child: WidgetPadding.h30(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildText(),
                _buildButton(),
                _buildPowered(),
              ],
            ),
          ),
        ),
        _buildShadow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
