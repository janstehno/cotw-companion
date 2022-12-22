// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with_dual_switch.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_slider.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitySettings extends StatefulWidget {
  final Function callback;

  const ActivitySettings({Key? key, required this.callback}) : super(key: key);

  @override
  ActivitySettingsState createState() => ActivitySettingsState();
}

class ActivitySettingsState extends State<ActivitySettings> {
  late Settings _settings;
  final List<String> _languages = ["English", "Русский", "Čeština", "Polski", "Deutsch", "Français", "Español", "Português", "日本語", "Türkçe"];
  final List<String> _languageCodes = ['en', 'ru', 'cs', 'pl', 'de', 'fr', 'es', 'pt', 'ja', 'tr'];
  late int _selectedLanguage;
  late int _fontSize;

  @override
  void initState() {
    _settings = Provider.of<Settings>(context, listen: false);
    _selectedLanguage = _settings.getLanguage;
    _fontSize = _settings.getFontSize;
    super.initState();
  }

  List<DropdownMenuItem> _buildDropDownLanguages() {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < _languages.length; i++) {
      items.add(DropdownMenuItem(
          value: i,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(_languages[i].toString(),
                  maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))));
    }
    return items;
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitle.sub(text: tr('language')),
      DropdownButton(
          dropdownColor: Color(Values.colorDropDownBackground),
          underline: Container(),
          icon: Container(),
          elevation: 0,
          itemHeight: 60,
          isExpanded: true,
          value: _selectedLanguage,
          onChanged: (dynamic value) {
            setState(() {
              _selectedLanguage = value;
              _settings.changeLanguage(value);
              EasyLocalization.of(context)!.setLocale(Locale(_languageCodes[value]));
              widget.callback();
            });
          },
          items: _buildDropDownLanguages())
    ]);
  }

  Widget _buildColor() {
    return Column(children: [
      WidgetTitle.sub(text: tr('color')),
      WidgetContainer(
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildColorButton(Values.colorZero),
          _buildColorButton(Values.colorFirst),
          _buildColorButton(Values.colorSecond),
          _buildColorButton(Values.colorThird),
          _buildColorButton(Values.colorFourth),
          _buildColorButton(Values.colorFifth),
        ]),
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildColorButton(Values.colorEleventh),
          _buildColorButton(Values.colorTenth),
          _buildColorButton(Values.colorNinth),
          _buildColorButton(Values.colorEighth),
          _buildColorButton(Values.colorSeventh),
          _buildColorButton(Values.colorSixth),
        ]),
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildColorButton(Values.colorTwelfth),
          _buildColorButton(Values.colorThirteenth),
          _buildColorButton(Values.colorFourteenth),
          _buildColorButton(Values.colorFifteenth),
          _buildColorButton(Values.colorSixteenth),
          _buildColorButton(Values.colorSeventeenth),
        ])
      ])),
    ]);
  }

  Widget _buildColorButton(int color) {
    return Container(
        margin: const EdgeInsets.all(2.5),
        child: WidgetButton(
            size: 40,
            background: color,
            onTap: () {
              widget.callback();
              setState(() {
                _settings.changeColor(color);
              });
            }));
  }

  Widget _buildFont() {
    return Column(children: [WidgetTitle.sub(text: tr('font')), Container(padding: const EdgeInsets.fromLTRB(30, 5, 30, 5), child: _buildFontSlider())]);
  }

  Widget _buildFontSlider() {
    return WidgetSlider(
        values: [_fontSize.toDouble()],
        text: _fontSize.toString(),
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
      EntryNameWithDualSwitch(
          text: tr('interface'),
          size: 40,
          oneLine: true,
          leftButtonText: tr('light_mode'),
          rightButtonText: tr('dark_mode'),
          background: Values.colorContentSubTitleBackground,
          color: Values.colorContentSubTitle,
          activeButtonColor: Values.colorAccent,
          activeButtonBackground: Values.colorPrimary,
          isActive: _settings.getDarkMode,
          onTap: () {
            setState(() {
              _settings.changeTheme();
              widget.callback();
            });
          }),
      EntryNameWithDualSwitch(
          text: tr('units'),
          size: 40,
          oneLine: true,
          leftButtonText: tr('metric_units'),
          rightButtonText: tr('imperial_units'),
          background: Values.colorContentSubTitleBackground,
          color: Values.colorContentSubTitle,
          activeButtonColor: Values.colorAccent,
          activeButtonBackground: Values.colorPrimary,
          isActive: _settings.getImperialUnits,
          onTap: () {
            setState(() {
              _settings.changeUnits();
              widget.callback();
            });
          })
    ]);
  }

  Widget _buildOther() {
    return Column(children: [
      WidgetTitle.sub(text: tr('other')),
      EntryName.withSwitch(
          text: tr('fur_rarity_per_cent'),
          color: Values.colorContentSubTitle,
          buttonActiveColor: Values.colorAccent,
          buttonActiveBackground: Values.colorPrimary,
          size: 40,
          isActive: _settings.getFurRarityPerCent,
          onTap: () {
            setState(() {
              _settings.changeFurRarityPerCent();
              widget.callback();
            });
          }),
      EntryName.withSwitch(
          text: tr('best_weapons'),
          color: Values.colorContentSubTitle,
          buttonActiveColor: Values.colorAccent,
          buttonActiveBackground: Values.colorPrimary,
          size: 40,
          isActive: _settings.getBestWeaponsForAnimal,
          onTap: () {
            setState(() {
              _settings.changeBestWeaponsForAnimal();
              widget.callback();
            });
          }),
      EntryName.withSwitch(
          text: tr('map_zones_style'),
          color: Values.colorContentSubTitle,
          buttonActiveColor: Values.colorAccent,
          buttonActiveBackground: Values.colorPrimary,
          size: 40,
          isActive: _settings.getMapZonesStyle,
          onTap: () {
            setState(() {
              _settings.changeMapZonesStyle();
              widget.callback();
            });
          }),
      EntryName.withSwitch(
          text: tr('date_of_record'),
          color: Values.colorContentSubTitle,
          buttonActiveColor: Values.colorAccent,
          buttonActiveBackground: Values.colorPrimary,
          size: 40,
          isActive: _settings.getDateOfRecord,
          onTap: () {
            setState(() {
              _settings.changeDateOfRecord();
              widget.callback();
            });
          }),
      EntryName.withSwitch(
          text: tr('trophy_lodge_record'),
          color: Values.colorContentSubTitle,
          buttonActiveColor: Values.colorAccent,
          buttonActiveBackground: Values.colorPrimary,
          size: 40,
          isActive: _settings.getTrophyLodgeRecord,
          onTap: () {
            setState(() {
              _settings.changeTrophyLodgeRecord();
              widget.callback();
            });
          })
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('settings'),
          height: 90,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          fontWeight: FontWeight.w700,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildLanguage(), _buildColor(), _buildInterface(), _buildFont(), _buildOther()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
