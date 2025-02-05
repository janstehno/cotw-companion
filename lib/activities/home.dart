import 'dart:math';

import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_swipe.dart';
import 'package:cotwcompanion/widgets/fullscreen/home_menu.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/other/survey_banner.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({
    super.key,
  });

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

class ActivityHomeState extends State<ActivityHome> {
  bool _menuOpened = false;

  Widget _buildName() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText(
          "COTW COMPANION",
          color: Interface.alwaysDark,
          style: Style.condensed.s24.w600,
        ),
        WidgetText(
          tr("NOT_OFFICIAL").toUpperCase(),
          color: Interface.alwaysDark.withValues(alpha: 0.8),
          style: Style.normal.s8.w300,
        ),
        WidgetText(
          Values.version,
          color: Interface.alwaysDark,
          style: Style.normal.s14.w500,
        ),
      ],
    );
  }

  Widget _buildLink(String icon, [Function? onTap]) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: WidgetIcon.withSize(
        icon,
        size: 17,
        color: Interface.alwaysDark,
      ),
    );
  }

  Widget _buildLinks() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLink(Assets.graphics.icons.post, () => Utils.mailTo()),
        const SizedBox(width: 10),
        _buildLink(
          Assets.graphics.icons.reddit,
          () => Utils.redirectTo(
            Uri.parse("https://www.reddit.com/user/Toastovac/"),
          ),
        ),
        const SizedBox(width: 10),
        _buildLink(
          Assets.graphics.icons.github,
          () => Utils.redirectTo(
            Uri.parse("https://github.com/janstehno/cotw-companion?tab=readme-ov-file#cotw-companion"),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return WidgetPadding.a30(
      background: Interface.primary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildName()),
          _buildLinks(),
        ],
      ),
    );
  }

  Widget _buildSurvey() {
    return WidgetSurveyBanner();
  }

  Widget _buildSwipe() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WidgetButtonSwipe(
          Assets.graphics.icons.tap,
          background: Interface.transparent,
          onTap: () {
            setState(() {
              _menuOpened = true;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return WidgetPadding.a30(
      child: WidgetTextPattern(
        tr("DISCLAIMER"),
        color: Interface.alwaysLight.withValues(alpha: 0.8),
        normalStyle: Style.normal.s10.w300,
        patternStyle: Style.normal.s10.w500,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      Assets.graphics.images.cotw.path,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  Widget _buildShadow() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          transform: const GradientRotation(pi / 2),
          colors: [
            Interface.ff06.withValues(alpha: 0.1),
            Interface.ff06.withValues(alpha: 0.4),
            Interface.ff06.withValues(alpha: 0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildCenter() {
    Size screenSize = MediaQuery.of(context).size;
    EdgeInsets screenPadding = MediaQuery.of(context).padding;
    double menuWidth = screenSize.width > 500 ? 0.6 * screenSize.width : screenSize.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackground(),
        _buildShadow(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _buildSurvey(),
            Spacer(),
            _buildSwipe(),
            _buildDisclaimer(),
          ],
        ),
        AnimatedPositioned(
          width: menuWidth,
          height: screenSize.height - screenPadding.bottom,
          left: _menuOpened ? 0 : -menuWidth,
          duration: const Duration(milliseconds: 200),
          child: WidgetHomeMenu(callback: () {
            setState(() {
              _menuOpened = false;
            });
          }),
        ),
      ],
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            if (details.delta.direction > 1) {
              _menuOpened = false;
            } else {
              _menuOpened = true;
            }
          });
        },
        child: _buildCenter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
