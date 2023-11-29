// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_missions.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailReserve extends StatefulWidget {
  final Reserve reserve;

  const ActivityDetailReserve({
    Key? key,
    required this.reserve,
  }) : super(key: key);

  @override
  ActivityDetailReserveState createState() => ActivityDetailReserveState();
}

class ActivityDetailReserveState extends State<ActivityDetailReserve> {
  final double _wrapSpace = 10;

  Widget _buildMissions() {
    return WidgetTitleBigButton(
      primaryText: tr("missions"),
      icon: "assets/graphics/icons/missions.svg",
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListReserveMissions(reserveId: widget.reserve.id)));
      },
    );
  }

  Widget _getEnvironment() {
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr("environment"),
        ),
        Container(
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
                    isActive: widget.reserve.hasSummer,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_winter.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentWinter,
                    isActive: widget.reserve.hasWinter,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_fields.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentField,
                    isActive: widget.reserve.hasFields,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_forest.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentForest,
                    isActive: widget.reserve.hasForest,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_plains.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentPlains,
                    isActive: widget.reserve.hasPlains,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_lowlands.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentLowlands,
                    isActive: widget.reserve.hasLowlands,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_hills.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentHills,
                    isActive: widget.reserve.hasHills,
                  ),
                  WidgetIcon(
                    icon: "assets/graphics/icons/environment_mountains.svg",
                    color: Interface.alwaysDark,
                    background: Interface.environmentMountains,
                    isActive: widget.reserve.hasMountains,
                  ),
                ],
              ),
            ])),
      ],
    );
  }

  Widget _buildAnimalsCallers() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("wildlife"),
      ),
      ListReserveAnimals(
        reserveId: widget.reserve.id,
      ),
      WidgetTitleBig(
        primaryText: tr("callers"),
      ),
      ListReserveCallers(
        reserveId: widget.reserve.id,
      )
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.reserve.getName(context.locale),
          maxLines: widget.reserve.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _getEnvironment(),
          _buildAnimalsCallers(),
          _buildMissions(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
