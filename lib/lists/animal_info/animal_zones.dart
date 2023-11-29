// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListAnimalZones extends StatefulWidget {
  final int animalId;
  final int? reserveId;

  final double height = 350;
  final double reserveHeight = 30;
  final double indicatorHeight = 40;

  const ListAnimalZones({
    Key? key,
    required this.animalId,
    this.reserveId,
  }) : super(key: key);

  @override
  ListAnimalZonesState createState() => ListAnimalZonesState();
}

class ListAnimalZonesState extends State<ListAnimalZones> {
  final double _iconSize = 12;
  final double _pieInnerRadius = 23;
  final double _pieOuterRadius = 50;
  final double _pieSectionSpace = 3;
  final double _pieInnerCenterSpaceRadius = 80;
  final double _pieOuterCenterSpaceRadius = 100;
  final double _pieInnerDegree = -90;
  final double _pieOuterDegree = -97.5;
  final double _dotSize = 10;

  late final PageController controller;
  late final Map<int, List<Zone>> _zones = {};
  late final List<PieChartSectionData> _data = [];
  late final List<PieChartSectionData> _numberData = [];

  @override
  void initState() {
    List<IdtoId> animalsReserves = HelperJSON.animalsReserves.where((idToId) => idToId.firstId == widget.animalId).toList();
    controller = PageController(viewportFraction: 1, keepPage: true, initialPage: animalsReserves.indexWhere((idToId) => idToId.secondId == (widget.reserveId ?? 0)));
    super.initState();
  }

  void _getZones() {
    _zones.clear();
    _zones.addAll(Zone.allAnimalZones(widget.animalId));
  }

  Widget _buildZoneChart(List<Zone> zoneList) {
    _data.clear();
    _numberData.clear();
    String reserveName = HelperJSON.getReserve(zoneList[0].reserveId).getName(context.locale);
    for (int index = 0; index < zoneList.length; index++) {
      Zone zone = zoneList[index];
      if (zoneList.length == 1) {
        for (int hour = zone.from; hour < zone.to; hour++) {
          _data.add(PieChartSectionData(
            color: zone.color,
            radius: _pieInnerRadius,
          ));
          _numberData.add(PieChartSectionData(
            color: Colors.transparent,
            radius: _pieOuterRadius,
            title: hour.toString(),
            showTitle: true,
            titleStyle: Interface.s16w300n(Interface.dark),
          ));
        }
      } else {
        for (int hour = zone.from; hour < zone.to; hour++) {
          if (hour == zone.from) {
            if (index == 0 && zone.zone == zoneList[zoneList.length - 1].zone) {
              _data.add(PieChartSectionData(
                color: zone.color,
                radius: _pieInnerRadius,
              ));
            } else {
              _data.add(PieChartSectionData(
                  color: zone.color,
                  radius: _pieInnerRadius,
                  badgeWidget: SvgPicture.asset(
                    zone.icon,
                    height: _iconSize,
                    width: _iconSize,
                    colorFilter: ColorFilter.mode(
                        zone.zone == 4
                            ? Interface.dark
                            : zone.zone == 3
                                ? Interface.light
                                : Interface.alwaysDark,
                        BlendMode.srcIn),
                  )));
            }
          } else {
            _data.add(PieChartSectionData(
              color: zone.color,
              radius: _pieInnerRadius,
            ));
          }
          _numberData.add(PieChartSectionData(
            color: Colors.transparent,
            radius: _pieOuterRadius,
            title: hour.toString(),
            showTitle: true,
            titleStyle: Interface.s16w300n(Interface.dark),
          ));
        }
      }
    }
    return _buildPieChart(reserveName);
  }

  Widget _buildPieChart(String reserveName) {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
          height: widget.height,
          child: Stack(children: [
            PieChart(PieChartData(
              startDegreeOffset: _pieInnerDegree,
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: _pieSectionSpace,
              centerSpaceRadius: _pieInnerCenterSpaceRadius,
              sections: _data,
            )),
            PieChart(PieChartData(
              startDegreeOffset: _pieOuterDegree,
              borderData: FlBorderData(
                show: false,
              ),
              centerSpaceRadius: _pieOuterCenterSpaceRadius,
              sections: _numberData,
            ))
          ])),
      SizedBox(
          height: widget.reserveHeight,
          child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(
                reserveName,
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              )))
    ]);
  }

  Widget _buildWidgets() {
    _getZones();
    return SizedBox(
        height: (_zones.length > 1) ? 450 : 410,
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: widget.height + widget.reserveHeight,
              child: PageView(controller: controller, pageSnapping: true, scrollDirection: Axis.horizontal, children: [
                for (int key in _zones.keys) _buildZoneChart(_zones[key]!),
              ])),
          _zones.length > 1
              ? Container(
                  height: widget.indicatorHeight,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                      controller: controller,
                      count: _zones.length,
                      effect: CustomizableEffect(
                          activeDotDecoration: DotDecoration(
                              width: _dotSize,
                              height: _dotSize,
                              color: Interface.primary,
                              borderRadius: BorderRadius.circular(5),
                              dotBorder: DotBorder(
                                width: Interface.accentBorderWidth,
                                color: Interface.accentBorder,
                              )),
                          dotDecoration: DotDecoration(
                            width: _dotSize + Interface.accentBorderWidth,
                            height: _dotSize + Interface.accentBorderWidth,
                            color: Interface.disabled.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ))))
              : const SizedBox.shrink()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
