// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuilderAnimalZones extends StatefulWidget {
  final int animalId;

  const BuilderAnimalZones({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  BuilderAnimalZonesState createState() => BuilderAnimalZonesState();
}

class BuilderAnimalZonesState extends State<BuilderAnimalZones> {
  final PageController controller = PageController(viewportFraction: 1, keepPage: true);

  late final Map<int, List<Zone>> _zones = {};
  late final List<PieChartSectionData> _data = [];
  late final List<PieChartSectionData> _numberData = [];

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
      const radius = 23.0;
      if (zoneList.length == 1) {
        for (int hour = zone.from; hour < zone.to; hour++) {
          _data.add(PieChartSectionData(color: zone.color, radius: radius));
          _numberData.add(PieChartSectionData(
            color: Colors.transparent,
            radius: 50.0,
            title: hour.toString(),
            showTitle: true,
            titleStyle: Interface.s16w300n(Interface.dark),
          ));
        }
      } else {
        for (int hour = zone.from; hour < zone.to; hour++) {
          if (hour == zone.from) {
            if (index == 0 && zone.zone == zoneList[zoneList.length - 1].zone) {
              _data.add(PieChartSectionData(color: zone.color, radius: radius));
            } else {
              _data.add(PieChartSectionData(
                  color: zone.color,
                  radius: radius,
                  badgeWidget: SvgPicture.asset(
                    zone.icon,
                    height: 12,
                    width: 12,
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
            _data.add(PieChartSectionData(color: zone.color, radius: radius));
          }
          _numberData.add(PieChartSectionData(
            color: Colors.transparent,
            radius: 50.0,
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
          height: 350,
          child: Stack(children: [
            PieChart(PieChartData(
              startDegreeOffset: -90,
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 3,
              centerSpaceRadius: 80,
              sections: _data,
            )),
            PieChart(PieChartData(
              startDegreeOffset: -97.5,
              borderData: FlBorderData(
                show: false,
              ),
              centerSpaceRadius: 100,
              sections: _numberData,
            ))
          ])),
      SizedBox(
          height: 30,
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
              height: 380,
              child: PageView(controller: controller, pageSnapping: true, scrollDirection: Axis.horizontal, children: [
                for (int key in _zones.keys) _buildZoneChart(_zones[key]!),
              ])),
          _zones.length > 1
              ? Container(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: SmoothPageIndicator(
                      controller: controller,
                      count: _zones.length,
                      effect: CustomizableEffect(
                          activeDotDecoration: DotDecoration(
                              width: 10,
                              height: 10,
                              color: Interface.primary,
                              borderRadius: BorderRadius.circular(5),
                              dotBorder: DotBorder(
                                width: Interface.accentBorderWidth,
                                color: Interface.accentBorder,
                              )),
                          dotDecoration: DotDecoration(
                            width: 10 + Interface.accentBorderWidth,
                            height: 10 + Interface.accentBorderWidth,
                            color: Interface.disabled.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ))))
              : Container()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
