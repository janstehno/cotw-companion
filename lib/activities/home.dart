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
import 'package:cotwcompanion/widgets/parts/home/changelog.dart';
import 'package:cotwcompanion/widgets/parts/home/search.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({
    super.key,
  });

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

class ActivityHomeState extends State<ActivityHome> {
  int _currentBuildNumber = 0;
  bool _showChangelog = false;
  bool _menuOpened = false;

  @override
  void initState() {
    _checkVersion();
    super.initState();
  }

  Future<void> _checkVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();
    _currentBuildNumber = int.parse(packageInfo.buildNumber);
    final storedVersion = prefs.getInt('lastBuildNumber') ?? 0;

    if (_currentBuildNumber > storedVersion) {
      setState(() {
        _showChangelog = true;
      });
    }
  }

  Future<void> _dismiss() async {
    setState(() {
      _showChangelog = false;
    });
  }

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
          () => Utils.redirectTo("https://www.reddit.com/user/Toastovac/"),
        ),
        const SizedBox(width: 10),
        _buildLink(
          Assets.graphics.icons.github,
          () => Utils.redirectTo("https://github.com/janstehno/cotw-companion?tab=readme-ov-file#cotw-companion"),
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

  Widget _buildUnofficial() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      alignment: Alignment.centerRight,
      color: Interface.primaryDark,
      child: WidgetText(
        tr("NOT_OFFICIAL").toUpperCase(),
        color: Interface.alwaysDark,
        style: Style.normal.s8.w500,
      ),
    );
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

  Widget _buildMenu() {
    Size screenSize = MediaQuery.of(context).size;
    EdgeInsets screenPadding = MediaQuery.of(context).padding;
    double menuWidth = screenSize.width > 500 ? 0.6 * screenSize.width : screenSize.width;

    return AnimatedPositioned(
      width: menuWidth,
      height: screenSize.height - screenPadding.bottom,
      left: _menuOpened ? 0 : -menuWidth,
      duration: const Duration(milliseconds: 200),
      child: WidgetHomeMenu(callback: () {
        setState(() {
          _menuOpened = false;
        });
      }),
    );
  }

  Widget _buildChangelog() {
    return Center(
      child: WidgetChangelog(
        currentBuildNumber: _currentBuildNumber,
        onDismiss: _dismiss,
      ),
    );
  }

  Widget _buildInnerStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            _buildSwipe(),
            _buildDisclaimer(),
          ],
        ),
        WidgetHomeSearch(),
      ],
    );
  }

  Widget _buildStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackground(),
        _buildShadow(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _buildUnofficial(),
            Expanded(child: _buildInnerStack()),
          ],
        ),
        if (_showChangelog) _buildChangelog(),
        _buildMenu(),
      ],
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            _dismiss();
            setState(() {
              if (details.delta.direction > 1) {
                _menuOpened = false;
              } else {
                _menuOpened = true;
              }
            });
          },
          child: _buildStack(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
