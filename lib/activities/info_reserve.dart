// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/lists/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityReserveInfo extends StatefulWidget {
  final int reserveId;

  const ActivityReserveInfo({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  ActivityReserveInfoState createState() => ActivityReserveInfoState();
}

class ActivityReserveInfoState extends State<ActivityReserveInfo> {
  late final Reserve _reserve;

  @override
  void initState() {
    _reserve = HelperJSON.getReserve(widget.reserveId);
    super.initState();
  }

  Widget _getEnvironment() {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Wrap(spacing: 10, children: [
            WidgetIcon(
              icon: "assets/graphics/icons/environment_summer.svg",
              color: Interface.alwaysDark,
              background: Interface.summer,
              isActive: _reserve.hasSummer,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_winter.svg",
              color: Interface.alwaysDark,
              background: Interface.winter,
              isActive: _reserve.hasWinter,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_fields.svg",
              color: Interface.alwaysDark,
              background: Interface.field,
              isActive: _reserve.hasFields,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_forest.svg",
              color: Interface.alwaysDark,
              background: Interface.forest,
              isActive: _reserve.hasForest,
            ),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 10, children: [
            WidgetIcon(
              icon: "assets/graphics/icons/environment_plains.svg",
              color: Interface.alwaysDark,
              background: Interface.plains,
              isActive: _reserve.hasPlains,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_lowlands.svg",
              color: Interface.alwaysDark,
              background: Interface.lowlands,
              isActive: _reserve.hasLowlands,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_hills.svg",
              color: Interface.alwaysDark,
              background: Interface.hills,
              isActive: _reserve.hasHills,
            ),
            WidgetIcon(
              icon: "assets/graphics/icons/environment_mountains.svg",
              color: Interface.alwaysDark,
              background: Interface.mountains,
              isActive: _reserve.hasMountains,
            ),
          ])
        ]));
  }

  Widget _buildAnimalsCallers() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('wildlife'),
      ),
      ListReserveAnimals(
        reserveId: widget.reserveId,
      ),
      WidgetTitleBig(
        primaryText: tr('callers'),
      ),
      ListReserveCallers(
        reserveId: widget.reserveId,
      )
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _reserve.getName(context.locale),
          maxLines: _reserve.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _getEnvironment(),
          _buildAnimalsCallers(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
