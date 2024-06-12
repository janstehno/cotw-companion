import 'package:cotwcompanion/activities/about.dart';
import 'package:cotwcompanion/activities/search.dart';
import 'package:cotwcompanion/activities/settings.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/lists/home/callers.dart';
import 'package:cotwcompanion/lists/home/other.dart';
import 'package:cotwcompanion/lists/home/reserves.dart';
import 'package:cotwcompanion/lists/home/tools.dart';
import 'package:cotwcompanion/lists/home/weapons.dart';
import 'package:cotwcompanion/lists/home/wildlife.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/home/menu.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:cotwcompanion/widgets/text/text_tap.dart';
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
  final List<List<dynamic>> _menuItems = [
    ["RESERVES", Assets.graphics.icons.reserve, const ListReserves()],
    ["WILDLIFE", Assets.graphics.icons.wildlife, const ListWildlife()],
    ["WEAPONS", Assets.graphics.icons.weapon, const ListWeapons()],
    ["CALLERS", Assets.graphics.icons.caller, const ListCallers()],
    ["TOOLS", Assets.graphics.icons.hammer, const ListTools()],
    ["OTHER", Assets.graphics.icons.other, const ListOther()],
    ["SEARCH", Assets.graphics.icons.search, const ActivitySearch()],
  ];

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
          color: Interface.alwaysDark.withOpacity(0.6),
          style: Style.normal.s8.w300,
        ),
        WidgetText(
          Values.version,
          color: Interface.alwaysDark.withOpacity(0.6),
          style: Style.normal.s12.w300,
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

  Widget _buildMenuItem(String text, String icon, Widget activity) {
    return WidgetSectionMenu(tr(text), icon: icon, onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (e) => activity));
    });
  }

  List<Widget> _listMenuItems() {
    return _menuItems.map((e) => _buildMenuItem(e.elementAt(0), e.elementAt(1), e.elementAt(2))).toList();
  }

  List<Widget> _listMenu() {
    return [
      ..._listMenuItems(),
      _buildMenuItem(
        "SETTINGS",
        Assets.graphics.icons.settings,
        ActivitySettings(callback: () {
          setState(() {});
        }),
      ),
      _buildMenuItem(
        "ABOUT",
        Assets.graphics.icons.about,
        const ActivityAbout(),
      ),
    ];
  }

  Widget _buildMenu() {
    return WidgetPadding.h30v20(
      alignment: Alignment.bottomLeft,
      child: WidgetScrollBar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listMenu(),
          ),
        ),
      ),
    );
  }

  List<Widget> _listOther() {
    return [
      WidgetTextTap(
        tr("WIKI").toUpperCase(),
        color: Interface.alwaysLight.withOpacity(0.8),
        style: Style.normal.s8.w500,
        onTap: () => Utils.redirectTo(
          Uri.parse("https://github.com/janstehno/cotw-companion/wiki"),
        ),
      ),
      const SizedBox(width: 10),
      WidgetTextTap(
        tr("PATCH_NOTES").toUpperCase(),
        color: Interface.alwaysLight.withOpacity(0.8),
        style: Style.normal.s8.w500,
        onTap: () => Utils.redirectTo(
          Uri.parse("https://github.com/janstehno/cotw-companion/wiki/Patch-notes"),
        ),
      ),
      const SizedBox(width: 10),
      WidgetTextTap(
        tr("IDEAS").toUpperCase(),
        color: Interface.alwaysLight.withOpacity(0.8),
        style: Style.normal.s8.w500,
        onTap: () => Utils.redirectTo(
          Uri.parse("https://github.com/janstehno/cotw-companion/discussions"),
        ),
      ),
      const SizedBox(width: 10),
      WidgetTextTap(
        tr("ISSUES").toUpperCase(),
        color: Interface.alwaysLight.withOpacity(0.8),
        style: Style.normal.s8.w500,
        onTap: () => Utils.redirectTo(
          Uri.parse("https://github.com/janstehno/cotw-companion/issues"),
        ),
      ),
    ];
  }

  Widget _buildOther() {
    return Container(
      color: Interface.alwaysDark.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _listOther(),
      ),
    );
  }

  Widget _buildDisclaimer() {
    return WidgetPadding.h30v20(
      background: Interface.alwaysDark.withOpacity(0.6),
      child: WidgetTextPattern(
        tr("DISCLAIMER"),
        color: Interface.alwaysLight.withOpacity(0.4),
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
    return Container(color: Interface.alwaysDark.withOpacity(0.4));
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          _buildShadow(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeader(),
              Expanded(child: _buildMenu()),
              _buildDisclaimer(),
              _buildOther(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
