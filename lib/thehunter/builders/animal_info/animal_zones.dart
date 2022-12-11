// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/model/zone.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuilderAnimalZones extends StatefulWidget {
  final int animalID;

  const BuilderAnimalZones({Key? key, required this.animalID}) : super(key: key);

  @override
  BuilderAnimalZonesState createState() => BuilderAnimalZonesState();
}

class BuilderAnimalZonesState extends State<BuilderAnimalZones> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  late final Map<int, List<Zone>> _zones = {};
  late final List<PieChartSectionData> _data = [];
  late final List<PieChartSectionData> _numberData = [];

  _getZones() {
    _zones.clear();
    _zones.addAll(Zone.getZones(widget.animalID));
  }

  Widget _buildZoneChart(List<Zone> lz) {
    _data.clear();
    _numberData.clear();
    String reserveName = JSONHelper.getReserve(lz[0].getReserveID).getName(context.locale);
    for (int p = 0; p < lz.length; p++) {
      Zone z = lz[p];
      const radius = 23.0;
      if (lz.length == 1) {
        for (int i = z.getFrom; i < z.getTo; i++) {
          _data.add(PieChartSectionData(color: z.getColor(), radius: radius));
          _numberData.add(PieChartSectionData(
              color: Colors.transparent,
              radius: 50.0,
              title: i.toString(),
              showTitle: true,
              titleStyle: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400)));
        }
      } else {
        for (int i = z.getFrom; i < z.getTo; i++) {
          if (i == z.getFrom) {
            if (p == 0 && z.getZone == lz[lz.length - 1].getZone) {
              _data.add(PieChartSectionData(color: z.getColor(), radius: radius));
            } else {
              _data.add(PieChartSectionData(
                  color: z.getColor(),
                  radius: radius,
                  badgeWidget: SvgPicture.asset(z.getIcon(),
                      color: z.getZone == 4
                          ? Color(Values.colorDark)
                          : z.getZone == 3
                              ? Color(Values.colorLight)
                              : Color(Values.colorAlwaysDark),
                      height: 12,
                      width: 12)));
            }
          } else {
            _data.add(PieChartSectionData(color: z.getColor(), radius: radius));
          }
          _numberData.add(PieChartSectionData(
              color: Colors.transparent,
              radius: 50.0,
              title: i.toString(),
              showTitle: true,
              titleStyle: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize18, fontWeight: FontWeight.w400)));
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
              child: AutoSizeText(reserveName, maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400))))
    ]);
  }

  Widget _buildWidgets() {
    return SizedBox(
        height: (_zones.length > 1) ? 450 : 410,
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: 380,
              child: PageView(
                  controller: controller, pageSnapping: true, scrollDirection: Axis.horizontal, children: [for (int key in _zones.keys) _buildZoneChart(_zones[key]!)])),
          WidgetContainer(
              visible: _zones.length > 1,
              child: SmoothPageIndicator(
                  controller: controller,
                  count: _zones.length,
                  effect: CustomizableEffect(
                      activeDotDecoration: DotDecoration(
                          width: 10,
                          height: 10,
                          color: Color(Values.colorPrimary),
                          borderRadius: BorderRadius.circular(5),
                          dotBorder: DotBorder(width: Values.widthAccentBorder, color: Color(Values.colorAccentBorder))),
                      dotDecoration: DotDecoration(
                          width: 10 + Values.widthAccentBorder,
                          height: 10 + Values.widthAccentBorder,
                          color: Color(Values.colorPagerUnselected),
                          borderRadius: BorderRadius.circular(5)))))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    _getZones();
    return _buildWidgets();
  }
}
