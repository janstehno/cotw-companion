// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_types.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/about.dart';
import 'package:cotwcompanion/thehunter/activities/need_zones.dart';
import 'package:cotwcompanion/thehunter/activities/other.dart';
import 'package:cotwcompanion/thehunter/activities/patch_notes.dart';
import 'package:cotwcompanion/thehunter/activities/settings.dart';
import 'package:cotwcompanion/thehunter/builders/loadouts.dart';
import 'package:cotwcompanion/thehunter/builders/logs.dart';
import 'package:cotwcompanion/thehunter/builders/rawc.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_icon_name_with_tap.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);

  @override
  ActivityHomeState createState() => ActivityHomeState();
}

class ActivityHomeState extends State<ActivityHome> {
  final double _entryWithTapHeight = 60;

  late double _screenWidth, _screenHeight, _screenPadding;

  bool _menuOpened = false;

  _callback() {
    setState(() {

    });
  }

  _getScreenSizes() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height - 1;
    _screenPadding = MediaQuery.of(context).viewPadding.top;
  }

  Widget _theHunter() {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(bottom: 30, top: 90),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              EntryIconNameWithTap(
                  text: tr('reserves'),
                  icon: "assets/graphics/icons/reserve.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "reserves", type: ObjectType.reserve)));
                  }),
              EntryIconNameWithTap(
                  text: tr('wildlife'),
                  icon: "assets/graphics/icons/stag.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "wildlife", type: ObjectType.animal)));
                  }),
              EntryIconNameWithTap(
                  text: tr('weapons'),
                  icon: "assets/graphics/icons/weapon.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "weapons", type: ObjectType.weapon)));
                  }),
              EntryIconNameWithTap(
                  text: tr('callers'),
                  icon: "assets/graphics/icons/caller.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderRAWC(text: "callers", type: ObjectType.caller)));
                  }),
              const Padding(padding: EdgeInsets.all(15)),
              EntryIconNameWithTap(
                  text: tr('animal_need_zones'),
                  icon: "assets/graphics/icons/need_zones.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityNeedZones()));
                  }),
              EntryIconNameWithTap(
                  text: tr('trophy_lodge'),
                  icon: "assets/graphics/icons/trophy_lodge.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLogs(trophyLodge: true)));
                  }),
              EntryIconNameWithTap(
                  text: tr('logbook'),
                  icon: "assets/graphics/icons/catch_book.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLogs(trophyLodge: false)));
                  }),
              EntryIconNameWithTap(
                  text: tr('loadouts'),
                  icon: "assets/graphics/icons/loadout.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderLoadouts()));
                  }),
              const Padding(padding: EdgeInsets.all(15)),
              EntryIconNameWithTap(
                  text: tr('other'),
                  icon: "assets/graphics/icons/other.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityOther()));
                  }),
              const Padding(padding: EdgeInsets.all(15)),
              EntryIconNameWithTap(
                  text: tr('settings'),
                  icon: "assets/graphics/icons/settings.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivitySettings(callback: _callback)));
                  }),
              EntryIconNameWithTap(
                  text: tr('about'),
                  icon: "assets/graphics/icons/about.svg",
                  height: _entryWithTapHeight,
                  color: Values.colorDark,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityAbout(version: Values.appVersion)));
                  })
            ])));
  }

  Widget _buildName(String name, String icon, Orientation orientation) {
    return Container(
        width: _screenWidth,
        height: _screenHeight,
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 80),
            child: orientation == Orientation.portrait
                ? Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(width: 190, child: SvgPicture.asset(icon, width: 180, height: 180, color: Color(Values.colorAccent))),
                    Column(children: [
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                        AutoSizeText(name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Lexend', letterSpacing: -1.3, color: Color(Values.colorAccent), height: 1.8, fontSize: Values.fontSize30)),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: AutoSizeText("TM",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(Values.colorAccent), letterSpacing: -0.2, height: 0.02, fontSize: Values.fontSize10, fontWeight: FontWeight.w400)))
                      ]),
                      AutoSizeText("COTW COMPANION",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(letterSpacing: 1.3, color: Color(Values.colorAccent), height: 1, fontSize: Values.fontSize20))
                    ])
                  ])
                : Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(width: 150, child: SvgPicture.asset(icon, width: 120, height: 120, color: Color(Values.colorAccent))),
                    Container(
                        height: 190,
                        margin: const EdgeInsets.only(left: 15),
                        padding: const EdgeInsets.only(bottom: 15),
                        child:
                            Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
                            AutoSizeText(name,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Lexend', letterSpacing: -1.3, color: Color(Values.colorAccent), height: 1.7, fontSize: Values.fontSize30)),
                            Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: AutoSizeText("TM",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(Values.colorAccent), letterSpacing: -0.2, height: 0.02, fontSize: Values.fontSize10, fontWeight: FontWeight.w400)))
                          ]),
                          AutoSizeText("COTW COMPANION",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(letterSpacing: 1.3, color: Color(Values.colorAccent), height: 1, fontSize: Values.fontSize20))
                        ]))
                  ])));
  }

  Widget _buildWidgets() {
    return Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Color(Values.colorPrimary), toolbarHeight: 1),
        body: OrientationBuilder(builder: (context, orientation) {
          return Stack(alignment: Alignment.center, children: [
            Container(color: Color(Values.colorPrimary), width: _screenWidth, height: _screenHeight),
            SizedBox(height: _screenHeight, child: _buildName("theHUNTER", "assets/graphics/icons/app_stag.svg", orientation)),
            Positioned(bottom: 90, left: 0, right: 0, child: Container(alignment: Alignment.center, height: 50, child: Container())),
            Positioned(
                top: 0,
                left: 0,
                child: AnimatedOpacity(
                    opacity: _menuOpened ? 0 : 1,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                        width: _screenWidth,
                        padding: const EdgeInsets.fromLTRB(0, 13, 20, 13),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityPatchNotes()));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                      decoration: ShapeDecoration(
                                        color: Color(Values.colorAccent),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(2.0), bottomRight: Radius.circular(2.0))),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        AutoSizeText(tr('patch_notes'),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Color(Values.colorPrimary), fontSize: Values.fontSize18, fontWeight: FontWeight.w800)),
                                        Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            child: AutoSizeText("( English )",
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color(Values.colorPrimary), fontSize: Values.fontSize14, fontWeight: FontWeight.w400)))
                                      ]))),
                              AutoSizeText(Values.appVersion,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize18, fontWeight: FontWeight.w800))
                            ])))),
            AnimatedPositioned(
                bottom: _menuOpened ? 0 : -_screenHeight + _screenPadding + 80,
                duration: const Duration(milliseconds: 200),
                child: Container(
                    width: _screenWidth,
                    height: _screenHeight - _screenPadding,
                    alignment: Alignment.center,
                    child: Stack(children: [
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: _screenHeight - _screenPadding,
                          margin: _menuOpened ? const EdgeInsets.only(top: 0) : const EdgeInsets.only(top: 80),
                          color: Color(Values.colorBody),
                          child: _theHunter()),
                      Positioned(
                          top: 0,
                          child: Stack(alignment: Alignment.topRight, children: [
                            AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _menuOpened ? 1 : 0,
                                child: Container(color: Color(Values.colorPrimary), width: _screenWidth, height: 80)),
                            AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _menuOpened ? 0 : 1,
                                child: Container(color: Color(Values.colorAccent), width: _screenWidth, height: 80)),
                            AnimatedPositioned(
                                top: _menuOpened ? 0 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Stack(alignment: Alignment.centerRight, children: [
                                  AnimatedOpacity(
                                      duration: const Duration(milliseconds: 200),
                                      opacity: _menuOpened ? 0 : 1,
                                      child: Container(
                                          width: 80,
                                          height: 80,
                                          alignment: Alignment.center,
                                          child: WidgetButton(
                                              size: 60,
                                              color: Values.colorPrimary,
                                              background: Values.colorTransparent,
                                              icon: "assets/graphics/icons/menu_open.svg",
                                              onTap: () {}))),
                                  AnimatedOpacity(
                                      duration: const Duration(milliseconds: 200),
                                      opacity: _menuOpened ? 1 : 0,
                                      child: Container(
                                          width: 80,
                                          height: 80,
                                          alignment: Alignment.center,
                                          child: WidgetButton(
                                              size: 60,
                                              color: Values.colorAccent,
                                              background: Values.colorTransparent,
                                              icon: "assets/graphics/icons/menu_close.svg",
                                              onTap: () {
                                                setState(() {
                                                  _menuOpened = !_menuOpened;
                                                });
                                              })))
                                ]))
                          ]))
                    ])))
          ]);
        }));
  }

  @override
  Widget build(BuildContext context) {
    _getScreenSizes();
    return _buildWidgets();
  }
}
