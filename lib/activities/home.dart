// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/about.dart';
import 'package:cotwcompanion/activities/need_zones.dart';
import 'package:cotwcompanion/activities/patch_notes.dart';
import 'package:cotwcompanion/activities/search.dart';
import 'package:cotwcompanion/activities/settings.dart';
import 'package:cotwcompanion/builders/loadouts.dart';
import 'package:cotwcompanion/builders/logs.dart';
import 'package:cotwcompanion/lists/callers.dart';
import 'package:cotwcompanion/lists/other.dart';
import 'package:cotwcompanion/lists/reserves.dart';
import 'package:cotwcompanion/lists/weapons.dart';
import 'package:cotwcompanion/lists/wildlife.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/button_icon_text.dart';
import 'package:cotwcompanion/widgets/entries/menu.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

class ActivityHomeState extends State<ActivityHome> {
  final double _titleHeight = 35;
  final double _footerLeftButtonSize = 20;
  final double _footerRightButtonHeight = 30;
  final double _menuTopBarHeight = 95;

  late Orientation _orientation;
  late double _screenWidth, _screenHeight;

  bool _menuOpened = false;

  void _callback() {
    setState(() {});
  }

  void _getScreenSizes() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height - 1;
  }

  Widget _buildName() {
    return Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(children: [
          Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                          height: _titleHeight,
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "COTW COMPANION",
                            maxLines: 1,
                            style: Interface.s24w600c(Interface.alwaysLight),
                          )),
                      AutoSizeText(Values.version,
                          maxLines: 1,
                          style: Interface.s18w400c(
                            Interface.alwaysLight.withOpacity(0.5),
                          )),
                    ]))),
            Column(children: [
              WidgetButtonIcon(
                  icon: "assets/graphics/icons/menu_open.svg",
                  onTap: () {
                    setState(() {
                      _menuOpened = true;
                    });
                  }),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: WidgetButtonIcon(
                      icon: "assets/graphics/icons/search.svg",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivitySearch()));
                      })),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: WidgetButtonIcon(
                      icon: "assets/graphics/icons/settings.svg",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivitySettings(callback: _callback)));
                      }))
            ])
          ]),
        ]));
  }

  Widget _buildMenuItem(String text, String icon, Widget activity) {
    return EntryMenu(
      text: tr(text),
      icon: "assets/graphics/icons/$icon.svg",
      onMenuTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => activity));
      },
    );
  }

  Widget _buildMenu() {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        left: _menuOpened ? _screenWidth / (_orientation == Orientation.portrait ? 5 : 1.75) : _screenWidth,
        width: _screenWidth - _screenWidth / (_orientation == Orientation.portrait ? 5 : 1.75),
        height: _screenHeight,
        child: Container(
            color: Interface.body,
            child: Stack(children: [
              WidgetScrollbar(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 105, bottom: 40),
                          child:
                              Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            _buildMenuItem("reserves", "reserve", const ListReserves()),
                            _buildMenuItem("wildlife", "wildlife", const ListWildlife()),
                            _buildMenuItem("weapons", "weapon", const ListWeapons()),
                            _buildMenuItem("callers", "caller", const ListCallers()),
                            const Padding(padding: EdgeInsets.all(15)),
                            _buildMenuItem("animal_need_zones", "need_zones", const ActivityNeedZones()),
                            _buildMenuItem("trophy_lodge", "trophy_lodge", const BuilderLogs(trophyLodge: true)),
                            _buildMenuItem("logbook", "catch_book", const BuilderLogs(trophyLodge: false)),
                            _buildMenuItem("loadouts", "loadout", const BuilderLoadouts()),
                            const Padding(padding: EdgeInsets.all(15)),
                            _buildMenuItem("other", "other", const ListOther()),
                          ])))),
              Container(
                  height: _menuTopBarHeight,
                  color: Interface.sectionTitle,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.centerRight,
                  child: WidgetButtonIcon(
                      icon: "assets/graphics/icons/menu_close.svg",
                      onTap: () {
                        setState(() {
                          _menuOpened = false;
                        });
                      }))
            ])));
  }

  Widget _buildLink(String icon, String host, String path) {
    return GestureDetector(
        onTap: () {
          Utils.redirectTo(host, path);
        },
        child: Container(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset(
              "assets/graphics/icons/$icon.svg",
              width: _footerLeftButtonSize,
              height: _footerLeftButtonSize,
              colorFilter: const ColorFilter.mode(
                Interface.alwaysLight,
                BlendMode.srcIn,
              ),
            )));
  }

  Widget _buildLinks() {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      _buildLink("github", "github.com", "/janstehno"),
      _buildLink("reddit", "reddit.com", "/user/Toastovac"),
    ]);
  }

  List<Widget> _buildButtons() {
    EdgeInsets margin = EdgeInsets.only(bottom: _orientation == Orientation.portrait ? 7 : 0, right: _orientation == Orientation.portrait ? 0 : 7);
    return [
      Container(
          margin: margin,
          child: WidgetButtonIconText(
            icon: "assets/graphics/icons/about.svg",
            text: tr("about"),
            color: Interface.alwaysDark,
            background: Interface.alwaysLight,
            buttonHeight: _footerRightButtonHeight,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityAbout()));
            },
          )),
      Container(
          margin: margin,
          child: WidgetButtonIconText(
            icon: "assets/graphics/icons/issue.svg",
            text: tr("issues"),
            color: Interface.alwaysDark,
            background: Interface.red,
            buttonHeight: _footerRightButtonHeight,
            isExternalLink: true,
            onTap: () {
              Utils.redirectTo("github.com", "/janstehno/cotwcompanion/issues");
            },
          )),
      Container(
          margin: margin,
          child: WidgetButtonIconText(
            icon: "assets/graphics/icons/idea.svg",
            text: tr("ideas"),
            color: Interface.alwaysDark,
            background: Interface.yellow,
            buttonHeight: _footerRightButtonHeight,
            isExternalLink: true,
            onTap: () {
              Utils.redirectTo("github.com", "/janstehno/cotwcompanion/discussions");
            },
          )),
      WidgetButtonIconText(
        icon: "assets/graphics/icons/repair.svg",
        text: tr("patch_notes"),
        color: Interface.alwaysDark,
        background: Interface.blue,
        buttonHeight: _footerRightButtonHeight,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityPatchNotes()));
        },
      ),
    ];
  }

  Widget _buildFooterMenu() {
    return _orientation == Orientation.portrait
        ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildButtons(),
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildButtons(),
          );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLinks(),
          _buildFooterMenu(),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    _getScreenSizes();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Interface.primary,
          toolbarHeight: 0.1,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          _orientation = orientation;
          return Stack(children: [
            SizedBox(
                height: _screenHeight - 0.1,
                width: _screenWidth,
                child: Image.asset(
                  "assets/graphics/images/cotw.jpg",
                  fit: orientation == Orientation.portrait ? BoxFit.fitHeight : BoxFit.fitWidth,
                  alignment: Alignment.center,
                )),
            Container(
              height: _screenHeight - 0.1,
              width: _screenWidth,
              color: Interface.alwaysDark.withOpacity(0.5),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildName(),
              _buildFooter(),
            ]),
            _buildMenu(),
          ]);
        }));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
