// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/about.dart';
import 'package:cotwcompanion/activities/need_zones.dart';
import 'package:cotwcompanion/activities/other.dart';
import 'package:cotwcompanion/activities/patch_notes.dart';
import 'package:cotwcompanion/activities/settings.dart';
import 'package:cotwcompanion/builders/loadouts.dart';
import 'package:cotwcompanion/builders/logs.dart';
import 'package:cotwcompanion/builders/rawc.dart';
import 'package:cotwcompanion/widgets/text_icon.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

class ActivityHomeState extends State<ActivityHome> {
  final double _entryWithTapHeight = 60;
  final double _menuHeaderHeight = 80;

  late double _screenWidth, _screenHeight, _screenPadding;

  bool _menuOpened = false;

  void _callback() {
    setState(() {});
  }

  void _getScreenSizes() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height - 1;
    _screenPadding = MediaQuery.of(context).viewPadding.top;
  }

  void _redirectToGitHub() async {
    if (!await launchUrl(Uri(scheme: "https", host: "github.com", path: "/janstehno/cotwcompanion"), mode: LaunchMode.externalApplication)) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  void _redirectToReddit() async {
    if (!await launchUrl(Uri(scheme: "https", host: "reddit.com", path: "/user/Toastovac"), mode: LaunchMode.externalApplication)) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  void _redirectToPayPal() async {
    if (!await launchUrl(Uri(scheme: "https", host: "paypal.me", path: "/toastovac"), mode: LaunchMode.externalApplication)) {
      throw 'Unfortunately the link could not be launched. Please, go back or restart the application.';
    }
  }

  Widget _buildLink(String icon, Function redirect) {
    return GestureDetector(
        onTap: () {
          redirect();
        },
        child: Container(
            height: 30,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            margin: const EdgeInsets.only(left: 15),
            child: SimpleShadow(
                sigma: 7,
                opacity: 0.2,
                offset: const Offset(-0.1, -0.1),
                color: _menuOpened ? Interface.accent : Interface.primary,
                child: SvgPicture.asset(
                  "assets/graphics/icons/$icon.svg",
                  color: _menuOpened ? Interface.accent : Interface.primary,
                ))));
  }

  Widget _theHunterMenu() {
    return WidgetScrollbar(
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                  WidgetTextIcon.withTap(
                      text: tr('reserves'),
                      icon: "assets/graphics/icons/reserve.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "reserves", type: ObjectType.reserve)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('wildlife'),
                      icon: "assets/graphics/icons/stag.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "wildlife", type: ObjectType.animal)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('weapons'),
                      icon: "assets/graphics/icons/weapon.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "weapons", type: ObjectType.weapon)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('callers'),
                      icon: "assets/graphics/icons/caller.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "callers", type: ObjectType.caller)));
                      }),
                  const Padding(padding: EdgeInsets.all(15)),
                  WidgetTextIcon.withTap(
                      text: tr('animal_need_zones'),
                      icon: "assets/graphics/icons/need_zones.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityNeedZones()));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('trophy_lodge'),
                      icon: "assets/graphics/icons/trophy_lodge.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLogs(trophyLodge: true)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('logbook'),
                      icon: "assets/graphics/icons/catch_book.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLogs(trophyLodge: false)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('loadouts'),
                      icon: "assets/graphics/icons/loadout.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLoadouts()));
                      }),
                  const Padding(padding: EdgeInsets.all(15)),
                  WidgetTextIcon.withTap(
                      text: tr('other'),
                      icon: "assets/graphics/icons/other.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityOther()));
                      }),
                  const Padding(padding: EdgeInsets.all(15)),
                  WidgetTextIcon.withTap(
                      text: tr('settings'),
                      icon: "assets/graphics/icons/settings.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivitySettings(callback: _callback)));
                      }),
                  WidgetTextIcon.withTap(
                      text: tr('about'),
                      icon: "assets/graphics/icons/about.svg",
                      height: _entryWithTapHeight,
                      color: Interface.dark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityAbout()));
                      })
                ]))));
  }

  Widget _buildName(Orientation orientation) {
    return Container(
        width: _screenWidth,
        height: _screenHeight,
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 80),
            child: orientation == Orientation.portrait
                ? Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                        width: 190,
                        child: SvgPicture.asset(
                          "assets/graphics/icons/app_stag.svg",
                          width: 180,
                          height: 180,
                          color: Interface.accent,
                        )),
                    Column(children: [
                      AutoSizeText("COTW COMPANION",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Title',
                            letterSpacing: -1.3,
                            color: Interface.accent,
                            height: 1.8,
                            fontSize: Interface.s30,
                            fontWeight: FontWeight.w800,
                          ))
                    ])
                  ])
                : Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(
                        width: 150,
                        child: SvgPicture.asset(
                          "assets/graphics/icons/app_stag.svg",
                          width: 120,
                          height: 120,
                          color: Interface.accent,
                        )),
                    Container(
                        margin: const EdgeInsets.only(left: 15),
                        padding: const EdgeInsets.only(bottom: 15),
                        child: AutoSizeText("COTW COMPANION",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Title',
                              letterSpacing: -1.3,
                              color: Interface.accent,
                              height: 1.8,
                              fontSize: Interface.s30,
                              fontWeight: FontWeight.w800,
                            )))
                  ])));
  }

  Widget _buildPatchNotes() {
    return Positioned(
        top: 0,
        left: 0,
        child: AnimatedOpacity(
            opacity: _menuOpened ? 0 : 1,
            duration: const Duration(milliseconds: 100),
            child: Container(
                width: _screenWidth,
                padding: const EdgeInsets.fromLTRB(0, 13, 20, 13),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityPatchNotes()));
                      },
                      child: Container(
                          height: 30,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              color: Interface.accent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                              )),
                          child: AutoSizeText(tr('patch_notes'),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Interface.primary,
                                fontSize: Interface.s18,
                                fontWeight: FontWeight.w800,
                              )))),
                  AutoSizeText(Interface.version,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Interface.accent,
                        fontSize: Interface.s18,
                        fontWeight: FontWeight.w800,
                      ))
                ]))));
  }

  Widget _buildHamburger() {
    return Stack(alignment: Alignment.centerRight, children: [
      AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _menuOpened ? 0 : 1,
          child: Container(
              width: _menuHeaderHeight,
              height: _menuHeaderHeight,
              alignment: Alignment.center,
              child: SimpleShadow(
                  sigma: 7,
                  opacity: 0.2,
                  offset: const Offset(-0.1, -0.1),
                  color: _menuOpened ? Interface.accent : Interface.primary,
                  child: WidgetButton(
                      buttonSize: _menuHeaderHeight - 20,
                      icon: "assets/graphics/icons/menu_open.svg",
                      color: Interface.primary,
                      background: Colors.transparent,
                      onTap: () {})))),
      AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _menuOpened ? 1 : 0,
          child: Container(
              width: _menuHeaderHeight,
              height: _menuHeaderHeight,
              alignment: Alignment.center,
              child: SimpleShadow(
                  sigma: 7,
                  opacity: 0.2,
                  offset: const Offset(-0.1, -0.1),
                  color: _menuOpened ? Interface.accent : Interface.primary,
                  child: WidgetButton(
                      buttonSize: _menuHeaderHeight - 20,
                      icon: "assets/graphics/icons/menu_close.svg",
                      color: Interface.accent,
                      background: Colors.transparent,
                      onTap: () {
                        setState(() {
                          _menuOpened = !_menuOpened;
                        });
                      }))))
    ]);
  }

  Widget _buildWidgets() {
    return Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Interface.primary, toolbarHeight: 1),
        body: OrientationBuilder(builder: (context, orientation) {
          return Stack(alignment: Alignment.center, children: [
            Container(color: Interface.primary, width: _screenWidth, height: _screenHeight),
            SizedBox(height: _screenHeight, child: _buildName(orientation)),
            _buildPatchNotes(),
            AnimatedPositioned(
                bottom: _menuOpened ? 0 : -(_screenHeight - _screenPadding - _menuHeaderHeight),
                width: _screenWidth,
                height: _screenHeight - _screenPadding,
                duration: const Duration(milliseconds: 200),
                child: Column(children: [
                  AnimatedContainer(
                      height: _menuHeaderHeight,
                      color: _menuOpened ? Interface.primary : Interface.accent,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(children: [
                                      _buildLink("paypal", _redirectToPayPal),
                                      _buildLink("github", _redirectToGitHub),
                                      _buildLink("reddit", _redirectToReddit),
                                    ]))),
                            _buildHamburger()
                          ])),
                  Expanded(
                      child: Container(
                    color: Interface.mainBody,
                    child: _theHunterMenu(),
                  ))
                ]))
          ]);
        }));
  }

  @override
  Widget build(BuildContext context) {
    _getScreenSizes();
    return _buildWidgets();
  }
}
