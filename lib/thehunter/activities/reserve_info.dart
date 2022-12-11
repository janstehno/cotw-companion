// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/thehunter/builders/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_icon.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityReserveInfo extends StatefulWidget {
  final int reserveID;

  const ActivityReserveInfo({Key? key, required this.reserveID}) : super(key: key);

  @override
  ActivityReserveInfoState createState() => ActivityReserveInfoState();
}

class ActivityReserveInfoState extends State<ActivityReserveInfo> {
  late final Reserve _reserve;

  @override
  void initState() {
    _reserve = JSONHelper.getReserve(widget.reserveID);
    super.initState();
  }

  Widget _getEnvironment() {
    return WidgetContainer(
        child: Column(children: [
      Wrap(spacing: 10, children: [
        EntryIcon(
            background: Values.colorSummer, color: Values.colorAlwaysDark, isActive: _reserve.getSummer, size: 40, icon: "assets/graphics/icons/environment_summer.svg"),
        EntryIcon(
            background: Values.colorWinter, color: Values.colorAlwaysDark, isActive: _reserve.getWinter, size: 40, icon: "assets/graphics/icons/environment_winter.svg"),
        EntryIcon(
            background: Values.colorFields, color: Values.colorAlwaysDark, isActive: _reserve.getFields, size: 40, icon: "assets/graphics/icons/environment_fields.svg"),
        EntryIcon(
            background: Values.colorForest, color: Values.colorAlwaysDark, isActive: _reserve.getForest, size: 40, icon: "assets/graphics/icons/environment_forest.svg"),
      ]),
      const SizedBox(height: 10),
      Wrap(spacing: 10, children: [
        EntryIcon(
            background: Values.colorPlains, color: Values.colorAlwaysDark, isActive: _reserve.getPlains, size: 40, icon: "assets/graphics/icons/environment_plains.svg"),
        EntryIcon(
            background: Values.colorLowlands,
            color: Values.colorAlwaysDark,
            isActive: _reserve.getLowlands,
            size: 40,
            icon: "assets/graphics/icons/environment_lowlands.svg"),
        EntryIcon(
            background: Values.colorHills, color: Values.colorAlwaysDark, isActive: _reserve.getHills, size: 40, icon: "assets/graphics/icons/environment_hills.svg"),
        EntryIcon(
            background: Values.colorMountains,
            color: Values.colorAlwaysDark,
            isActive: _reserve.getMountains,
            size: 40,
            icon: "assets/graphics/icons/environment_mountains.svg"),
      ])
    ]));
  }

  Widget _buildAnimalsCallers() {
    return Column(children: [
      WidgetTitle.sub(text: tr('wildlife')),
      BuilderReserveAnimals(reserveID: widget.reserveID),
      WidgetTitle.sub(text: tr('callers')),
      BuilderReserveCallers(reserveID: widget.reserveID)
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _reserve.getName(context.locale),
          height: 150,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize40,
          fontWeight: FontWeight.w800,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_getEnvironment(), _buildAnimalsCallers()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
