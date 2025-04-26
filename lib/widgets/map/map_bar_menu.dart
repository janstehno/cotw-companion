import 'package:cotwcompanion/activities/map_layers.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/map.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetMapMenuBar extends StatelessWidget {
  final HelperMap _helperMap;
  final int _level;
  final Function _onChange;

  const WidgetMapMenuBar({
    super.key,
    required HelperMap helperMap,
    required int level,
    required Function onChange,
  })  : _helperMap = helperMap,
        _level = level,
        _onChange = onChange;

  Settings _settings(BuildContext context) => Provider.of<Settings>(context, listen: false);

  void _updateZoneType(BuildContext context) {
    _settings(context).changeMapZonesType();
    _onChange();
  }

  void _updateZoneStyle(BuildContext context) {
    _settings(context).changeMapZonesStyle();
    _onChange();
  }

  WidgetMenuBarItem _buildMenuBack(BuildContext context) {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.back,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  WidgetMenuBarItem _buildMenuZone(BuildContext context) {
    return WidgetMenuBarItem(
      barButton: WidgetSwitchIcon(
        Assets.graphics.icons.zoneFeed,
        background:
            _helperMap.showZoneTypeButton(_settings(context), _level) ? Interface.alwaysLight : Interface.disabled,
        activeBackground: Interface.primary,
        isActive: _helperMap.showZoneType(_settings(context), _level),
        onTap: () {
          if (_helperMap.showZoneTypeButton(_settings(context), _level)) _updateZoneType(context);
        },
      ),
    );
  }

  WidgetMenuBarItem _buildMenuCircles(BuildContext context) {
    return WidgetMenuBarItem(
      barButton: WidgetSwitchIcon(
        Assets.graphics.icons.other,
        background:
            _helperMap.showZoneStyleButton(_settings(context), _level) ? Interface.alwaysLight : Interface.disabled,
        activeBackground: Interface.primary,
        isActive: _helperMap.showZoneStyle(_settings(context), _level),
        onTap: () {
          if (_helperMap.showZoneStyleButton(_settings(context), _level)) _updateZoneStyle(context);
        },
      ),
    );
  }

  WidgetMenuBarItem _buildMenuFilter(BuildContext context) {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.menuOpen,
        color: Interface.alwaysDark,
        background: Interface.alwaysLight,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (e) => ActivityMapLayers(helperMap: _helperMap, onChange: _onChange)),
          );
        },
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetMenuBar(
      items: [
        _buildMenuBack(context),
        _buildMenuZone(context),
        _buildMenuCircles(context),
        _buildMenuFilter(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
