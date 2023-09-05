// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/tap_text_indicator.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitySettings extends StatefulWidget {
  final Function callback;

  const ActivitySettings({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  ActivitySettingsState createState() => ActivitySettingsState();
}

class ActivitySettingsState extends State<ActivitySettings> {
  late final Settings _settings;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  List<DropdownMenuItem> _buildDropDownLanguages() {
    List<DropdownMenuItem> items = [];
    for (int index = 0; index < _settings.getLanguages.length; index++) {
      items.add(DropdownMenuItem(
          value: index,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(
                _settings.getLocaleName(index),
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              ))));
    }
    return items;
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('language'),
      ),
      DropdownButton(
          dropdownColor: Interface.dropDown,
          underline: Container(),
          icon: Container(),
          elevation: 0,
          itemHeight: 60,
          menuMaxHeight: 300,
          isExpanded: true,
          value: _settings.getLanguage,
          onChanged: (dynamic value) {
            setState(() {
              _settings.changeLanguage(value);
              EasyLocalization.of(context)!.setLocale(_settings.getLocale(value));
              widget.callback();
            });
          },
          items: _buildDropDownLanguages())
    ]);
  }

  Widget _buildColor() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('color'),
      ),
      Container(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.darkpink),
              _buildColorButton(Interface.pink),
              _buildColorButton(Interface.red),
              _buildColorButton(Interface.redorange),
              _buildColorButton(Interface.orange),
              _buildColorButton(Interface.yellow),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.lightblue),
              _buildColorButton(Interface.teal),
              _buildColorButton(Interface.green),
              _buildColorButton(Interface.lightgreen),
              _buildColorButton(Interface.grassgreen),
              _buildColorButton(Interface.lightyellow),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.blue),
              _buildColorButton(Interface.darkblue),
              _buildColorButton(Interface.deepblue),
              _buildColorButton(Interface.purple),
              _buildColorButton(Interface.brown),
              _buildColorButton(Interface.grey),
            ])
          ])),
    ]);
  }

  Widget _buildColorButton(Color color) {
    return Container(
        margin: const EdgeInsets.all(2.5),
        child: WidgetButtonIcon(
          background: color,
          onTap: () {
            widget.callback();
            setState(() {
              _settings.changeColor(color);
            });
          },
        ));
  }

  Widget _buildInterface() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('interface'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child:
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _settings.changeTheme(false);
                        widget.callback();
                      });
                    },
                    child: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: _settings.getDarkMode ? Interface.disabled : Interface.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Expanded(
                                child: AutoSizeText(
                              tr('light_mode'),
                              textAlign: TextAlign.start,
                              style: Interface.s16w300n(Interface.dark),
                            ))
                          ],
                        )))),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _settings.changeTheme(true);
                        widget.callback();
                      });
                    },
                    child: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                tr('dark_mode'),
                                textAlign: TextAlign.end,
                                style: Interface.s16w300n(Interface.dark),
                              )),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: _settings.getDarkMode ? Interface.primary : Interface.disabled,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )
                            ]))))
          ]))
    ]);
  }

  Widget _buildUnits() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('units'),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child:
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _settings.changeUnits(false);
                        widget.callback();
                      });
                    },
                    child: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: _settings.getImperialUnits ? Interface.disabled : Interface.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Expanded(
                                child: AutoSizeText(
                              tr('metric_units'),
                              textAlign: TextAlign.start,
                              style: Interface.s16w300n(Interface.dark),
                            ))
                          ],
                        )))),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _settings.changeUnits(true);
                        widget.callback();
                      });
                    },
                    child: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                tr('imperial_units'),
                                textAlign: TextAlign.end,
                                style: Interface.s16w300n(Interface.dark),
                              )),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: _settings.getImperialUnits ? Interface.primary : Interface.disabled,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )
                            ]))))
          ]))
    ]);
  }

  Widget _buildFurPercentageChange() {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(top: 10),
          color: Interface.title,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            WidgetTitleBigSwitch(
                primaryText: tr('fur_rarity_per_cent'),
                maxLines: 2,
                isActive: _settings.getFurRarityPerCent,
                onTap: () {
                  setState(() {
                    _settings.changeFurRarityPerCent();
                    widget.callback();
                  });
                }),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: AutoSizeText(
                  "by Ramalamadingdong7",
                  style: Interface.s14w500n(Interface.dark),
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 25),
                child: Text(
                  tr('fur_rarity_warning'),
                  style: Interface.s12w300n(Interface.red),
                ))
          ]))
    ]);
  }

  Widget _buildOther() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('other'),
      ),
      WidgetTapTextIndicator(
          text: tr('map_zones_accuracy'),
          maxLines: 2,
          isActive: _settings.getMapZonesAccuracy,
          onTap: () {
            setState(() {
              _settings.changeMapZonesAccuracy();
              widget.callback();
            });
          }),
      WidgetTapTextIndicator(
          text: tr('best_weapons'),
          maxLines: 2,
          isActive: _settings.getBestWeaponsForAnimal,
          onTap: () {
            setState(() {
              _settings.changeBestWeaponsForAnimal();
              widget.callback();
            });
          })
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('settings'),
          context: context,
        ),
        body: Column(children: [
          _buildLanguage(),
          _buildColor(),
          _buildInterface(),
          _buildUnits(),
          _buildOther(),
          _buildFurPercentageChange(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
