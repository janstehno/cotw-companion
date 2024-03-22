import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/map.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/section/section_indicator_tap.dart';
import 'package:cotwcompanion/widgets/title/title_switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapLayers extends StatefulWidget {
  final HelperMap _helperMap;
  final Function _callback;

  const ActivityMapLayers({
    super.key,
    required HelperMap helperMap,
    required Function onChange,
  })  : _helperMap = helperMap,
        _callback = onChange;

  HelperMap get helperMap => _helperMap;

  Function get callback => _callback;

  @override
  ActivityMapLayersState createState() => ActivityMapLayersState();
}

class ActivityMapLayersState extends State<ActivityMapLayers> {
  Widget _buildOutpost() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.outpost,
      activeColor: Interface.light,
      activeBackground: Interface.dark,
      isActive: widget.helperMap.isEnvironmentActive(MapLocationType.outpost),
      onTap: () {
        setState(() {
          widget.helperMap.activateEnvironment(MapLocationType.outpost);
          widget.callback();
        });
      },
    );
  }

  Widget _buildLookout() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.lookout,
      activeColor: Interface.light,
      activeBackground: Interface.dark,
      isActive: widget.helperMap.isEnvironmentActive(MapLocationType.lookout),
      onTap: () {
        setState(() {
          widget.helperMap.activateEnvironment(MapLocationType.lookout);
          widget.callback();
        });
      },
    );
  }

  Widget _buildHide() {
    return WidgetSwitchIcon(
      Assets.graphics.icons.hide,
      activeColor: Interface.light,
      activeBackground: Interface.dark,
      isActive: widget.helperMap.isEnvironmentActive(MapLocationType.hide),
      onTap: () {
        setState(() {
          widget.helperMap.activateEnvironment(MapLocationType.hide);
          widget.callback();
        });
      },
    );
  }

  Widget _buildEnvironment() {
    return WidgetPadding.h30v20(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildOutpost(),
          _buildLookout(),
          _buildHide(),
        ],
      ),
    );
  }

  Widget _buildAnimalsTitle() {
    return WidgetTitleSwitchIcon(
      tr("WILDLIFE"),
      icon: Assets.graphics.icons.empty,
      activeIcon: Assets.graphics.icons.full,
      isActive: widget.helperMap.isEveryAnimalActive,
      alignRight: true,
      onTap: () {
        setState(() {
          widget.helperMap.activateAllAnimals();
          widget.callback();
        });
      },
    );
  }

  List<Widget> _listAnimals() {
    return widget.helperMap.zones.entries.mapIndexed((i, zone) {
      return WidgetSectionIndicatorTap(
        widget.helperMap.getAnimal(widget.helperMap.zonesKeys(context).elementAt(i))!.name,
        background: Utils.backgroundAt(i),
        indicatorColor: widget.helperMap.isAnimalActive(i) ? widget.helperMap.getAnimalColor(i) : Interface.disabled,
        onTap: () {
          setState(() {
            widget.helperMap.activateAnimal(i);
            widget.callback();
          });
        },
      );
    }).toList();
  }

  Widget _buildAnimals() {
    return Column(
      children: [
        _buildAnimalsTitle(),
        ..._listAnimals(),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        widget.helperMap.reserve.name,
        context: context,
      ),
      children: [
        _buildEnvironment(),
        _buildAnimals(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
