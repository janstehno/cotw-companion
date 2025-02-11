import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/handling/drop_down.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap_align.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap_settings.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitySettings extends StatefulWidget {
  final Function _callback;

  const ActivitySettings({
    super.key,
    required Function callback,
  }) : _callback = callback;

  Function get callback => _callback;

  @override
  ActivitySettingsState createState() => ActivitySettingsState();
}

class ActivitySettingsState extends State<ActivitySettings> {
  Settings get _settings => Provider.of<Settings>(context, listen: false);

  DropdownMenuItem _buildDropdownItem(String language) {
    return DropdownMenuItem(
      value: _settings.languages.indexOf(language),
      child: WidgetPadding.h30(
        background: Interface.dropDown,
        child: WidgetText(
          _settings.getLocaleName(_settings.languages.indexOf(language)),
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      ),
    );
  }

  List<DropdownMenuItem> _listLanguages() {
    return _settings.languages.map((e) => _buildDropdownItem(e)).toList();
  }

  List<Widget> _listLanguage() {
    return [
      WidgetTitle(tr("LANGUAGE")),
      WidgetDropDown(
        value: _settings.language,
        items: _listLanguages(),
        onChange: (dynamic value) {
          setState(() {
            _settings.changeLanguage(value);
            EasyLocalization.of(context)!.setLocale(_settings.getLocale(value));
            widget.callback();
          });
        },
      )
    ];
  }

  Widget _buildLightMode() {
    return WidgetSectionIndicatorTapAlign(
      tr("LIGHT_MODE"),
      indicatorLeft: true,
      indicatorColor: !(_settings.darkMode) ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeTheme(false);
          widget.callback();
        });
      },
    );
  }

  Widget _buildDarkMode() {
    return WidgetSectionIndicatorTapAlign(
      tr("DARK_MODE"),
      indicatorColor: _settings.darkMode ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeTheme(true);
          widget.callback();
        });
      },
    );
  }

  List<Widget> _listInterface() {
    return [
      WidgetTitle(tr("INTERFACE")),
      Row(
        children: [
          Expanded(child: _buildLightMode()),
          Expanded(child: _buildDarkMode()),
        ],
      ),
    ];
  }

  Widget _buildMetricUnits() {
    return WidgetSectionIndicatorTapAlign(
      tr("METRIC_UNITS"),
      indicatorLeft: true,
      indicatorColor: !(_settings.imperialUnits) ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeUnits(false);
        });
      },
    );
  }

  Widget _buildImperialUnits() {
    return WidgetSectionIndicatorTapAlign(
      tr("IMPERIAL_UNITS"),
      indicatorColor: _settings.imperialUnits ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeUnits(true);
        });
      },
    );
  }

  List<Widget> _listUnits() {
    return [
      WidgetTitle(tr("UNITS")),
      Row(
        children: [
          Expanded(child: _buildMetricUnits()),
          Expanded(child: _buildImperialUnits()),
        ],
      ),
    ];
  }

  Widget _buildPerformanceMode() {
    return WidgetSectionIndicatorTapSettings(
      tr("MAP_PERFORMANCE_MODE"),
      indicatorColor: _settings.mapPerformanceMode ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeMapPerformanceMode();
        });
      },
    );
  }

  Widget _buildFurPercent() {
    return WidgetSectionIndicatorTapSettings(
      tr("MAP_ZONES_COUNT"),
      indicatorColor: _settings.mapZonesCount ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeMapZonesAccuracy();
        });
      },
    );
  }

  Widget _buildBestWeapons() {
    return WidgetSectionIndicatorTapSettings(
      tr("BEST_WEAPONS"),
      indicatorColor: _settings.bestWeaponsForAnimal ? Interface.primary : Interface.disabled,
      onTap: () {
        setState(() {
          _settings.changeBestWeaponsForAnimal();
        });
      },
    );
  }

  List<Widget> _listOther() {
    return [
      WidgetTitle(tr("OTHER")),
      _buildPerformanceMode(),
      _buildFurPercent(),
      _buildBestWeapons(),
    ];
  }

  Widget _buildDistributionSubtitle(Color background) {
    return WidgetSectionIndicatorTapSettings(
      "${tr("ANIMAL_TROPHY_DISTRIBUTION")} & ${tr("ANIMAL_WEIGHT_DISTRIBUTION").toLowerCase()}",
      indicatorColor: _settings.trophyWeightDistribution ? Interface.primary : Interface.disabled,
      background: background,
      needsWarning: true,
      onTap: () {
        setState(() {
          _settings.changeTrophyWeightDistribution();
        });
      },
    );
  }

  Widget _buildFurPercentSubtitle(Color background) {
    return WidgetSectionIndicatorTapSettings(
      tr("FUR_RARITY_PER_CENT"),
      indicatorColor: _settings.furRarityPerCent ? Interface.primary : Interface.disabled,
      background: background,
      needsWarning: true,
      onTap: () {
        setState(() {
          _settings.changeFurRarityPerCent();
        });
      },
    );
  }

  Widget _buildFurPercentageChange() {
    return Column(
      children: [
        _buildDistributionSubtitle(Interface.subtitle),
        _buildFurPercentSubtitle(Interface.odd),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("SETTINGS"),
        context: context,
      ),
      children: [
        ..._listLanguage(),
        ..._listInterface(),
        ..._listUnits(),
        ..._listOther(),
        _buildFurPercentageChange(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
