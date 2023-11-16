// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
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
  final double _wrapSpace = 10;

  late final Reserve _reserve;

  @override
  void initState() {
    _reserve = HelperJSON.getReserve(widget.reserveId);
    super.initState();
  }

  Widget _buildMap() {
    return WidgetTitleBigButton(
      primaryText: tr("map"),
      icon: "assets/graphics/icons/map.svg",
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuilderMap(reserveId: widget.reserveId)));
      },
    );
  }

  Widget _getEnvironment() {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Wrap(
            spacing: _wrapSpace,
            runSpacing: _wrapSpace,
            children: [
              WidgetIcon(
                icon: "assets/graphics/icons/environment_summer.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentSummer,
                isActive: _reserve.hasSummer,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_winter.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentWinter,
                isActive: _reserve.hasWinter,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_fields.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentField,
                isActive: _reserve.hasFields,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_forest.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentForest,
                isActive: _reserve.hasForest,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_plains.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentPlains,
                isActive: _reserve.hasPlains,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_lowlands.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentLowlands,
                isActive: _reserve.hasLowlands,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_hills.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentHills,
                isActive: _reserve.hasHills,
              ),
              WidgetIcon(
                icon: "assets/graphics/icons/environment_mountains.svg",
                color: Interface.alwaysDark,
                background: Interface.environmentMountains,
                isActive: _reserve.hasMountains,
              ),
            ],
          ),
        ]));
  }

  Widget _buildAnimalsCallers() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("wildlife"),
      ),
      ListReserveAnimals(
        reserveId: widget.reserveId,
      ),
      WidgetTitleBig(
        primaryText: tr("callers"),
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
          _buildMap(),
          _getEnvironment(),
          _buildAnimalsCallers(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
