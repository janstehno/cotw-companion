// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_functional.dart';
import 'package:cotwcompanion/widgets/title_functional_double_switch.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/slider.dart';
import 'package:cotwcompanion/widgets/title.dart';
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

  late int _fontSize;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    _fontSize = _settings.getFontSize;
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
              child: AutoSizeText(_settings.getLocaleName(index),
                  maxLines: 1,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  )))));
    }
    return items;
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitle(
        text: tr('language'),
      ),
      DropdownButton(
          dropdownColor: Interface.dropDownBody,
          underline: Container(),
          icon: Container(),
          elevation: 0,
          itemHeight: 60,
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
      WidgetTitle(
        text: tr('color'),
      ),
      Container(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.pink),
              _buildColorButton(Interface.red),
              _buildColorButton(Interface.redorange),
              _buildColorButton(Interface.orange),
              _buildColorButton(Interface.yellow),
              _buildColorButton(Interface.lightyellow),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.blue),
              _buildColorButton(Interface.lightblue),
              _buildColorButton(Interface.teal),
              _buildColorButton(Interface.green),
              _buildColorButton(Interface.lightgreen),
              _buildColorButton(Interface.grassgreen),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildColorButton(Interface.darkblue),
              _buildColorButton(Interface.deepblue),
              _buildColorButton(Interface.purple),
              _buildColorButton(Interface.darkpink),
              _buildColorButton(Interface.brown),
              _buildColorButton(Interface.grey),
            ])
          ])),
    ]);
  }

  Widget _buildColorButton(Color color) {
    return Container(
        margin: const EdgeInsets.all(2.5),
        child: WidgetButton(
            background: color,
            onTap: () {
              widget.callback();
              setState(() {
                _settings.changeColor(color);
              });
            }));
  }

  Widget _buildFont() {
    return Column(children: [
      WidgetTitle(
        text: tr('font'),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
        child: _buildFontSlider(),
      )
    ]);
  }

  Widget _buildFontSlider() {
    return WidgetSlider(
        values: [_fontSize.toDouble()],
        leftText: _fontSize.toString(),
        min: 0,
        max: 3,
        onDrag: (id, lower, upper) {
          setState(() {
            _fontSize = lower.toInt();
            _settings.changeFontSize(_fontSize);
            widget.callback();
          });
        });
  }

  Widget _buildInterface() {
    return Column(children: [
      WidgetTitleFunctionalDoubleSwitch.withText(
          text: tr('interface'),
          leftText: tr('light_mode'),
          rightText: tr('dark_mode'),
          color: Interface.title,
          background: Interface.subTitleBackground,
          inactiveColor: Interface.disabled,
          activeColor: Interface.accent,
          inactiveBackground: Interface.disabled.withOpacity(0.3),
          activeBackground: Interface.primary,
          isActive: _settings.getDarkMode,
          onTap: () {
            setState(() {
              _settings.changeTheme();
              widget.callback();
            });
          }),
      WidgetTitleFunctionalDoubleSwitch.withText(
          text: tr('units'),
          leftText: tr('metric_units'),
          rightText: tr('imperial_units'),
          color: Interface.title,
          background: Interface.subTitleBackground,
          inactiveColor: Interface.disabled,
          activeColor: Interface.accent,
          inactiveBackground: Interface.disabled.withOpacity(0.3),
          activeBackground: Interface.primary,
          isActive: _settings.getImperialUnits,
          onTap: () {
            setState(() {
              _settings.changeUnits();
              widget.callback();
            });
          })
    ]);
  }

  Widget _buildFurPercentageChange() {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(top: 10),
          color: Interface.subTitleBackground,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            WidgetTitleFunctional(
              text: tr('fur_rarity_per_cent'),
              textColor: Interface.dark,
              iconColor: Interface.title,
              iconInactiveColor: Interface.accent,
              buttonBackground: Interface.primary,
              buttonInactiveBackground: Interface.disabled.withOpacity(0.3),
              isTitle: true,
              isActive: _settings.getFurRarityPerCent,
              onTap: () {
                setState(() {
                  _settings.changeFurRarityPerCent();
                  widget.callback();
                });
              },
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: AutoSizeText("by Ramalamadingdong7",
                    style: TextStyle(
                      color: Interface.dark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ))),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 25),
                child: Text(tr('fur_rarity_warning'),
                    style: const TextStyle(
                      color: Interface.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )))
          ]))
    ]);
  }

  Widget _buildOther() {
    return Column(children: [
      WidgetTitle(
        text: tr('other'),
      ),
      WidgetTitleFunctional(
          text: tr('map_zones_accuracy'),
          textColor: Interface.dark,
          iconColor: Interface.title,
          iconInactiveColor: Interface.accent,
          buttonBackground: Interface.primary,
          buttonInactiveBackground: Interface.disabled.withOpacity(0.3),
          isActive: _settings.getMapZonesAccuracy,
          onTap: () {
            setState(() {
              _settings.changeMapZonesAccuracy();
              widget.callback();
            });
          }),
      WidgetTitleFunctional(
          text: tr('best_weapons'),
          textColor: Interface.dark,
          iconColor: Interface.title,
          iconInactiveColor: Interface.accent,
          buttonBackground: Interface.primary,
          buttonInactiveBackground: Interface.disabled.withOpacity(0.3),
          isActive: _settings.getBestWeaponsForAnimal,
          onTap: () {
            setState(() {
              _settings.changeBestWeaponsForAnimal();
              widget.callback();
            });
          }),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('settings'),
          color: Interface.accent,
          background: Interface.primary,
          fontSize: Interface.s30,
          context: context,
        ),
        children: [
          _buildLanguage(),
          _buildColor(),
          _buildInterface(),
          _buildFont(),
          _buildOther(),
          _buildFurPercentageChange(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
