// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/builders/animal_info/animal_callers.dart';
import 'package:cotwcompanion/builders/animal_info/animal_furs.dart';
import 'package:cotwcompanion/builders/animal_info/animal_reserves.dart';
import 'package:cotwcompanion/builders/animal_info/animal_weapons.dart';
import 'package:cotwcompanion/builders/animal_info/animal_zones.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/sense.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_small.dart';
import 'package:cotwcompanion/widgets/trophy_score.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ActivityAnimalInfo extends StatefulWidget {
  final int animalId;

  const ActivityAnimalInfo({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  ActivityAnimalInfoState createState() => ActivityAnimalInfoState();
}

class ActivityAnimalInfoState extends State<ActivityAnimalInfo> {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  late final Animal _animal;
  late final bool _imperialUnits;

  int _toggledRarity = -1;

  //double _opacity = 0;

  @override
  void initState() {
    _animal = HelperJSON.getAnimal(widget.animalId);
    _imperialUnits = Provider.of<Settings>(context, listen: false).getImperialUnits;
    super.initState();
  }

  void _toggleRarity(int rarity) {
    setState(() {
      if (_toggledRarity == rarity) {
        _toggledRarity = -1;
      } else {
        _toggledRarity = rarity;
      }
    });
  }

  Widget _buildName() {
    double width = MediaQuery.of(context).size.width - 90;
    double size = width > 250 ? 250 : width;
    return Column(children: [
      SizedBox(
          height: size,
          child: Stack(fit: StackFit.expand, children: [
            /*OrientationBuilder(builder: (context, orientation) {
              return LimitedBox(
                maxHeight: size,
                child: Image.asset(
                  Graphics.getAnimalBackground(_animal.id),
                  fit: orientation == Orientation.portrait ? BoxFit.contain : BoxFit.cover,
                ),
              );
            }),*/
            Column(children: [
              Container(
                  height: size,
                  color: Interface.sectionTitle,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: 90,
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: SvgPicture.asset(
                              Graphics.getAnimalIcon(widget.animalId),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomLeft,
                              colorFilter: ColorFilter.mode(
                                Interface.dark,
                                BlendMode.srcIn,
                              ),
                            )),
                        Container(
                            width: size,
                            padding: _padding,
                            alignment: Alignment.bottomRight,
                            child: SimpleShadow(
                                color: Interface.shadow,
                                opacity: 1,
                                sigma: 2,
                                offset: const Offset(-0.35, -0.35),
                                child: SvgPicture.asset(
                                  Graphics.getAnimalHead(widget.animalId),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.bottomRight,
                                )))
                      ]))
            ])
          ])),
      Container(
          color: Interface.sectionTitle,
          padding: _padding,
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: AutoSizeText(
                          tr('animal_class'),
                          maxLines: 1,
                          style: Interface.s16w300n(Interface.dark),
                        ))),
                Text(
                  _animal.level.toString(),
                  style: Interface.s18w500n(Interface.dark),
                )
              ]),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: AutoSizeText(
                              tr('animal_difficulty'),
                              maxLines: 1,
                              style: Interface.s16w300n(Interface.dark),
                            ))),
                    Text(
                      _animal.difficulty.toString(),
                      style: Interface.s18w500n(Interface.dark),
                    )
                  ]))
            ])
          ]))
    ]);
  }

  Widget _buildReserves() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('reserves'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            BuilderAnimalReserves(animalId: widget.animalId),
          ]))
    ]);
  }

  Widget _buildTrophy() {
    return Column(children: [
      Row(children: [
        Expanded(
            child: WidgetTitleBig(
          primaryText: tr('animal_trophy'),
        )),
        _animal.grounded
            ? Container(
                height: 75,
                color: Interface.title,
                padding: const EdgeInsets.only(right: 25),
                alignment: Alignment.center,
                child: WidgetTag.medium(
                  iconSize: 20,
                  icon: "assets/graphics/icons/grounded.svg",
                  color: Interface.disabled,
                  background: Colors.transparent,
                ))
            : Container()
      ]),
      Container(
          padding: _padding,
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            WidgetTrophyScore(
              text: _animal.removePointZero(_animal.silver.toString()),
              icon: "assets/graphics/icons/trophy_silver.svg",
              color: Interface.alwaysDark,
              background: Interface.trophySilver,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            WidgetTrophyScore(
              text: _animal.removePointZero(_animal.gold.toString()),
              icon: "assets/graphics/icons/trophy_gold.svg",
              color: Interface.alwaysDark,
              background: Interface.trophyGold,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            Row(children: [
              WidgetTrophyScore(
                text: _animal.removePointZero(_animal.diamond.toString()),
                icon: "assets/graphics/icons/trophy_diamond.svg",
                color: Interface.alwaysDark,
                background: Interface.trophyDiamond,
                margin: const EdgeInsets.only(right: 3),
              ),
              _animal.femaleDiamond
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 1.5),
                      child: SvgPicture.asset(
                        "assets/graphics/icons/female.svg",
                        width: 14,
                        colorFilter: ColorFilter.mode(
                          Interface.disabled,
                          BlendMode.srcIn,
                        ),
                      ))
                  : Container()
            ]),
          ])),
      WidgetTitleBig(
        primaryText: tr('animal_maximum_trophy'),
        secondaryText: tr('subject_to_change'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(bottom: _animal.hasGO ? 10 : 0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        WidgetTrophyScore(
                          text: _animal.removePointZero(_animal.trophy.toString()),
                          icon: "assets/graphics/icons/harvest_no_trophy_organ.svg",
                          color: Interface.accent,
                          background: Interface.primary,
                          valueKnown: _animal.trophy != 0,
                          margin: const EdgeInsets.only(right: 3),
                        ),
                        (_animal.id > 80 && _animal.trophy > 0)
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 1.5),
                                child: Text(
                                  "?",
                                  style: Interface.s18w500n(Interface.disabled),
                                ))
                            : Container()
                      ]),
                      WidgetTrophyScore(
                        text: _animal.removePointZero(_animal.getWeight(_imperialUnits)),
                        icon: "assets/graphics/icons/weight.svg",
                        color: Interface.accent,
                        background: Interface.primary,
                        valueKnown: _imperialUnits ? _animal.weightLB != 0 : _animal.weightKG != 0,
                        alignRight: true,
                      )
                    ])),
            _animal.hasGO
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        WidgetTrophyScore(
                          text: _animal.removePointZero(_animal.trophyGO.toString()),
                          icon: "assets/graphics/icons/trophy_great_one.svg",
                          color: Interface.accent,
                          background: Interface.primary,
                          valueKnown: _animal.trophyGO != 0,
                          margin: const EdgeInsets.only(right: 10),
                        ),
                        WidgetTrophyScore(
                          text: _animal.removePointZero(_animal.getWeightGO(_imperialUnits)),
                          icon: "assets/graphics/icons/weight.svg",
                          color: Interface.accent,
                          background: Interface.primary,
                          valueKnown: _imperialUnits ? _animal.weightGOLB != 0 : _animal.weightGOKG != 0,
                          alignRight: true,
                        )
                      ])
                : Container(),
          ]))
    ]);
  }

  Widget _buildFurs() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('animal_furs'),
        secondaryText: tr('subject_to_change'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  onTap: () {
                    _toggleRarity(4);
                  },
                  child: WidgetTag.small(
                    text: tr('rarity_common'),
                    color: Interface.light,
                    background: Interface.common,
                    margin: const EdgeInsets.only(right: 5),
                  )),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(3);
                  },
                  child: WidgetTag.small(
                    text: tr('rarity_uncommon'),
                    color: Interface.alwaysDark,
                    background: Interface.uncommon,
                    margin: const EdgeInsets.only(right: 5),
                  )),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(2);
                  },
                  child: WidgetTag.small(
                    text: tr('rarity_rare'),
                    color: Interface.alwaysDark,
                    background: Interface.rare,
                  )),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  onTap: () {
                    _toggleRarity(1);
                  },
                  child: WidgetTag.small(
                    text: tr('rarity_very_rare'),
                    color: Interface.alwaysDark,
                    background: Interface.veryrare,
                    margin: const EdgeInsets.only(right: 2.5, top: 5),
                  )),
              GestureDetector(
                  onTap: () {
                    _toggleRarity(0);
                  },
                  child: WidgetTag.small(
                    text: tr('rarity_mission'),
                    color: Interface.alwaysDark,
                    background: Interface.mission,
                    margin: const EdgeInsets.only(left: 2.5, top: 5),
                  ))
            ])
          ])),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 27),
          child: BuilderAnimalFurs(
            animalId: widget.animalId,
            chosenRarity: _toggledRarity,
          ))
    ]);
  }

  Widget _buildZones() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('animal_need_zones'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetTag.small(
                text: tr('animal_other'),
                color: Interface.light,
                background: Interface.other,
                margin: const EdgeInsets.only(right: 2.5),
              ),
              WidgetTag.small(
                text: tr('animal_feed'),
                color: Interface.alwaysDark,
                background: Interface.feed,
                margin: const EdgeInsets.only(left: 2.5),
              )
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetTag.small(
                text: tr('animal_drink'),
                color: Interface.alwaysDark,
                background: Interface.drink,
                margin: const EdgeInsets.only(right: 2.5, top: 5),
              ),
              WidgetTag.small(
                text: tr('animal_rest'),
                color: Interface.alwaysDark,
                background: Interface.rest,
                margin: const EdgeInsets.only(left: 2.5, top: 5),
              )
            ])
          ])),
      BuilderAnimalZones(animalId: widget.animalId)
    ]);
  }

  Widget _buildAnatomy() {
    return _animal.level > 1
        ? Column(children: [
            WidgetTitleBig(
              primaryText: tr('animal_anatomy'),
            ),
            Stack(children: [
              SvgPicture.asset(
                Graphics.getAnatomyAsset(_animal.id, AnatomyType.body),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                  Interface.anatomyBody,
                  BlendMode.srcIn,
                ),
              ),
              SvgPicture.asset(
                Graphics.getAnatomyAsset(_animal.id, AnatomyType.organs),
                fit: BoxFit.fitWidth,
              )
            ])
          ])
        : Container();
  }

  Widget _buildSenses() {
    return _animal.hasSenses
        ? Column(children: [
            WidgetTitleBig(
              primaryText: tr('animal_senses'),
            ),
            Container(
                padding: _padding,
                alignment: Alignment.centerLeft,
                child:
                    Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  WidgetSense(
                    icon: "assets/graphics/icons/sense_sight.svg",
                    sense: _animal.sight,
                    isVisible: _animal.sight > 0,
                  ),
                  WidgetSense(
                    icon: "assets/graphics/icons/sense_hearing.svg",
                    sense: _animal.hearing,
                    isVisible: _animal.hearing > 0,
                  ),
                  WidgetSense(
                    icon: "assets/graphics/icons/sense_smell.svg",
                    sense: _animal.smell,
                    isVisible: _animal.smell > 0,
                  ),
                ]))
          ])
        : Container();
  }

  Widget _buildCallers() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('recommended_callers'),
      ),
      Container(
        padding: _padding,
        alignment: Alignment.centerLeft,
        child: BuilderAnimalCallers(animalId: widget.animalId),
      )
    ]);
  }

  Widget _buildWeapons() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('recommended_weapons'),
      ),
      WidgetTitleSmall(
        primaryText: tr('weapons_rifles'),
      ),
      Container(
        padding: _padding,
        alignment: Alignment.centerLeft,
        child: BuilderAnimalWeapons(animalLevel: _animal.level, weaponType: WeaponType.rifle),
      ),
      WidgetTitleSmall(
        primaryText: tr('weapons_shotguns'),
      ),
      Container(
        padding: _padding,
        alignment: Alignment.centerLeft,
        child: BuilderAnimalWeapons(animalLevel: _animal.level, weaponType: WeaponType.shotgun),
      ),
      WidgetTitleSmall(
        primaryText: tr('weapons_handguns'),
      ),
      Container(
        padding: _padding,
        alignment: Alignment.centerLeft,
        child: BuilderAnimalWeapons(animalLevel: _animal.level, weaponType: WeaponType.handgun),
      ),
      WidgetTitleSmall(
        primaryText: tr('weapons_bows_crossbows'),
      ),
      Container(
        padding: _padding,
        alignment: Alignment.centerLeft,
        child: BuilderAnimalWeapons(animalLevel: _animal.level, weaponType: WeaponType.bow),
      )
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _animal.getName(context.locale),
          maxLines: _animal.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildName(),
          _buildReserves(),
          _buildTrophy(),
          _buildFurs(),
          _buildZones(),
          _buildAnatomy(),
          _buildSenses(),
          _buildCallers(),
          _buildWeapons(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
