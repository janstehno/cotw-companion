// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_graphics.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/animal_info/animal_callers.dart';
import 'package:cotwcompanion/thehunter/builders/animal_info/animal_furs.dart';
import 'package:cotwcompanion/thehunter/builders/animal_info/animal_reserves.dart';
import 'package:cotwcompanion/thehunter/builders/animal_info/animal_weapons.dart';
import 'package:cotwcompanion/thehunter/builders/animal_info/animal_zones.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/widgets/animal_sense.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/tag.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:cotwcompanion/thehunter/widgets/trophy_score.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ActivityAnimalInfo extends StatefulWidget {
  final int animalID;

  const ActivityAnimalInfo({Key? key, required this.animalID}) : super(key: key);

  @override
  ActivityAnimalInfoState createState() => ActivityAnimalInfoState();
}

class ActivityAnimalInfoState extends State<ActivityAnimalInfo> {
  late final Animal _animal;
  late final Settings _settings;

  late bool _units;

  int _toggledRarity = -1;

  //double _opacity = 0;

  @override
  void initState() {
    _animal = JSONHelper.getAnimal(widget.animalID);
    _settings = Provider.of<Settings>(context, listen: false);
    _units = _settings.getImperialUnits;
    super.initState();
  }

  _toggleRarity(int r) {
    setState(() {
      if (_toggledRarity == r) {
        _toggledRarity = -1;
      } else {
        _toggledRarity = r;
      }
    });
  }

  /*
  FlutterSlider _sliderOpacity() {
    return FlutterSlider(
        values: [_opacity.toDouble()],
        min: 0,
        max: 1,
        step: const FlutterSliderStep(step: 0.1),
        handlerWidth: 15,
        handlerHeight: 15,
        tooltip: FlutterSliderTooltip(disabled: true),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: 2,
            inactiveTrackBarHeight: 1,
            activeTrackBar: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(100.0)), color: Color(Values.colorPrimary).withOpacity(0.4)),
            inactiveTrackBar: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(100.0)), color: Color(Values.colorSliderTrack))),
        handler: FlutterSliderHandler(decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5.0)), color: Color(Values.colorPrimary)), child: Container()),
        onDragging: (id, lower, upper) {
          setState(() {
            setState(() {
              _opacity = lower;
            });
          });
        });
  }
  */

  Widget _buildName() {
    return Column(children: [
      SizedBox(
          height: (MediaQuery.of(context).size.width / 16 * 9) + 60,
          child: Stack(fit: StackFit.expand, children: [
            //Image.asset(Graphics.getAnimalBackground(widget.animal.getID), fit: BoxFit.fitHeight),
            Column(children: [
              Container(
                  height: (MediaQuery.of(context).size.width / 16 * 9) + 60,
                  color: Color(Values.colorContentSubSubTitleBackground),
                  child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
                            alignment: Alignment.bottomLeft,
                            child: SvgPicture.asset(Graphics.getAnimalIcon(widget.animalID), color: Color(Values.colorDark), width: 60))),
                    Container(
                        width: (MediaQuery.of(context).size.width / 16 * 9) + 60,
                        padding: const EdgeInsets.all(30),
                        alignment: Alignment.bottomRight,
                        child: SimpleShadow(
                            color: Color(Values.colorShadowHead),
                            opacity: 1,
                            sigma: 2,
                            offset: const Offset(-0.35, -0.35),
                            child: SvgPicture.asset(Graphics.getAnimalHead(widget.animalID), fit: BoxFit.fitWidth, alignment: Alignment.bottomRight)))
                  ]))
            ])
          ])),
      Container(
          color: Color(Values.colorContentSubSubTitleBackground),
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: AutoSizeText(tr('animal_class'),
                            maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
                Text(_animal.getLevel.toString(), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
              ]),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: AutoSizeText(tr('animal_difficulty'),
                                maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
                    Text(_animal.getDifficulty.toString(), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
                  ]))
            ])
          ]))
    ]);
  }

  Widget _buildReserves() {
    return Column(children: [
      WidgetTitle.sub(text: tr('reserves')),
      WidgetContainer(child: Column(children: [BuilderAnimalReserves(animalID: widget.animalID)]))
    ]);
  }

  Widget _buildTrophy() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal_trophy')),
      WidgetContainer(
          child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
        WidgetTag.big(
            margin: const EdgeInsets.only(right: 5),
            text: _animal.removePointZero(_animal.getSilver.toString()),
            color: Values.colorAlwaysDark,
            background: Values.colorSilver),
        WidgetTag.big(
            margin: const EdgeInsets.only(left: 5, right: 5),
            text: _animal.removePointZero(_animal.getGold.toString()),
            color: Values.colorAlwaysDark,
            background: Values.colorGold),
        WidgetTag.big(
            margin: const EdgeInsets.only(left: 5),
            text: _animal.removePointZero(_animal.getDiamond.toString()),
            color: Values.colorAlwaysDark,
            background: Values.colorDiamond)
      ])),
      WidgetTitle.sub(text: tr('animal_maximum_trophy')),
      WidgetContainer(
          child: Column(children: [
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
          EntryTrophyWithUnknown(
              isValueKnown: _animal.getTrophy == 0,
              icon: "assets/graphics/icons/unknown.svg",
              text: _animal.removePointZero(_animal.getTrophy.toString()),
              alignIconLeft: true),
          _units
              ? EntryTrophyWithUnknown(
                  isValueKnown: _animal.getWeightLB == 0, icon: "assets/graphics/icons/unknown.svg", text: _animal.removePointZero(_animal.getWeight(_units)))
              : EntryTrophyWithUnknown(
                  isValueKnown: _animal.getWeightKG == 0, icon: "assets/graphics/icons/unknown.svg", text: _animal.removePointZero(_animal.getWeight(_units))),
        ]),
        WidgetContainer(
            visible: _animal.getTrophyGO != 0,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 10),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              EntryTrophyWithUnknown(
                  isValueKnown: true,
                  icon: _animal.getTrophyGO == 0 ? "assets/graphics/icons/unknown.svg" : "assets/graphics/icons/trophy_great_one.svg",
                  iconSize: _animal.getTrophyGO == 0 ? 16 : 20,
                  text: _animal.removePointZero(_animal.getTrophyGO.toString()),
                  alignIconLeft: true),
              _units
                  ? EntryTrophyWithUnknown(
                      isValueKnown: true,
                      icon: _animal.getWeightGOLB == 0 ? "assets/graphics/icons/unknown.svg" : "assets/graphics/icons/trophy_great_one.svg",
                      iconSize: _animal.getWeightGOLB == 0 ? 16 : 20,
                      text: _animal.removePointZero(_animal.getWeightGO(_units)))
                  : EntryTrophyWithUnknown(
                      isValueKnown: true,
                      icon: _animal.getWeightGOKG == 0 ? "assets/graphics/icons/unknown.svg" : "assets/graphics/icons/trophy_great_one.svg",
                      iconSize: _animal.getWeightGOKG == 0 ? 16 : 20,
                      text: _animal.removePointZero(_animal.getWeightGO(_units))),
            ]))
      ]))
    ]);
  }

  Widget _buildFurs() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal_furs')),
      WidgetContainer(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  onTap: () {
                    _toggleRarity(4);
                  },
                  child: WidgetTag.small(
                      text: tr('rarity_common'), color: Values.colorLight, background: Values.colorRarityCommon, margin: const EdgeInsets.only(right: 5))),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(3);
                  },
                  child: WidgetTag.small(
                      text: tr('rarity_uncommon'), color: Values.colorAlwaysDark, background: Values.colorRarityUncommon, margin: const EdgeInsets.only(right: 5))),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(2);
                  },
                  child: WidgetTag.small(text: tr('rarity_rare'), color: Values.colorAlwaysDark, background: Values.colorRarityRare)),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  onTap: () {
                    _toggleRarity(1);
                  },
                  child: WidgetTag.small(
                      text: tr('rarity_very_rare'),
                      color: Values.colorAlwaysDark,
                      background: Values.colorRarityVeryRare,
                      margin: const EdgeInsets.only(right: 2.5, top: 5))),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(0);
                  },
                  child: WidgetTag.small(
                      text: tr('rarity_mission'), color: Values.colorAlwaysDark, background: Values.colorRarityMission, margin: const EdgeInsets.only(left: 2.5, top: 5)))
            ])
          ])),
      WidgetContainer(child: BuilderAnimalFurs(animalID: widget.animalID, chosenRarity: _toggledRarity))
    ]);
  }

  Widget _buildZones() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal_need_zones')),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetTag.small(text: tr('animal_other'), color: Values.colorLight, background: Values.colorZoneOther, margin: const EdgeInsets.only(right: 2.5)),
              WidgetTag.small(text: tr('animal_feed'), color: Values.colorAlwaysDark, background: Values.colorZoneFeed, margin: const EdgeInsets.only(left: 2.5))
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetTag.small(
                  text: tr('animal_drink'), color: Values.colorAlwaysDark, background: Values.colorZoneDrink, margin: const EdgeInsets.only(right: 2.5, top: 5)),
              WidgetTag.small(text: tr('animal_rest'), color: Values.colorAlwaysDark, background: Values.colorZoneRest, margin: const EdgeInsets.only(left: 2.5, top: 5))
            ])
          ])),
      BuilderAnimalZones(animalID: widget.animalID)
    ]);
  }

  Widget _buildAnatomy() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal_anatomy'), visible: _animal.getLevel > 1),
      WidgetContainer(
          visible: _animal.getLevel > 1,
          padding: const EdgeInsets.all(0),
          child: Stack(children: [
            SvgPicture.asset(_animal.getAnatomyAsset("body"), fit: BoxFit.fitWidth, color: Color(Values.colorAnatomyBody)),
            SvgPicture.asset(_animal.getAnatomyAsset("organs"), fit: BoxFit.fitWidth),
            SvgPicture.asset(_animal.getAnatomyAsset("bones"), fit: BoxFit.fitWidth, color: Color(Values.colorAnatomyBones).withOpacity(0 /*_opacity*/))
          ]))
    ]);
  }

  Widget _buildSenses() {
    return Column(children: [
      WidgetTitle.sub(text: tr('animal_senses'), visible: _animal.getSenses),
      WidgetContainer(
          visible: _animal.getSenses,
          alignment: Alignment.centerLeft,
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
            EntryAnimalSense(icon: "assets/graphics/icons/sense_sight.svg", sense: _animal.getSight, visible: _animal.getSight > 0),
            EntryAnimalSense(icon: "assets/graphics/icons/sense_hearing.svg", sense: _animal.getHearing, visible: _animal.getHearing > 0),
            EntryAnimalSense(icon: "assets/graphics/icons/sense_smell.svg", sense: _animal.getSmell, visible: _animal.getSmell > 0)
          ]))
    ]);
  }

  Widget _buildCallers() {
    return Column(children: [
      WidgetTitle.sub(text: tr('recommended_callers')),
      WidgetContainer(alignment: Alignment.centerLeft, child: BuilderAnimalCallers(animalID: widget.animalID))
    ]);
  }

  Widget _buildWeapons() {
    return Column(children: [
      WidgetTitle.sub(text: tr('recommended_weapons')),
      WidgetTitle.detail(text: tr('weapons_rifles')),
      Container(padding: const EdgeInsets.all(30), alignment: Alignment.centerLeft, child: BuilderAnimalWeapons(animalLevel: _animal.getLevel, weaponType: 0)),
      WidgetTitle.detail(text: tr('weapons_shotguns')),
      Container(padding: const EdgeInsets.all(30), alignment: Alignment.centerLeft, child: BuilderAnimalWeapons(animalLevel: _animal.getLevel, weaponType: 1)),
      WidgetTitle.detail(text: tr('weapons_handguns')),
      Container(padding: const EdgeInsets.all(30), alignment: Alignment.centerLeft, child: BuilderAnimalWeapons(animalLevel: _animal.getLevel, weaponType: 2)),
      WidgetTitle.detail(text: tr('weapons_bows_crossbows')),
      Container(padding: const EdgeInsets.all(30), alignment: Alignment.centerLeft, child: BuilderAnimalWeapons(animalLevel: _animal.getLevel, weaponType: 3))
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          height: 150,
          text: _animal.getName(context.locale),
          maxLines: _animal.getName(context.locale).split(" ").length == 1 ? 1 : 2,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize40,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildName(), _buildReserves(), _buildTrophy(), _buildFurs(), _buildZones(), _buildAnatomy(), _buildSenses(), _buildCallers(), _buildWeapons()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
