import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/fonts.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/connect/animal_zone.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/indicator/page_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListAnimalZones extends StatefulWidget {
  final Animal _animal;
  final Reserve? _reserve;

  const ListAnimalZones(
    Animal animal, {
    super.key,
    Reserve? reserve,
  })  : _animal = animal,
        _reserve = reserve;

  Animal get animal => _animal;

  Reserve? get reserve => _reserve;

  @override
  ListAnimalZonesState createState() => ListAnimalZonesState();
}

class ListAnimalZonesState extends State<ListAnimalZones> {
  Map<int, List<AnimalZone>> get _zones => HelperJSON.getAnimalZonesFor(widget.animal.id);

  final double _pageHeight = 350;
  final double _reserveHeight = 30;
  final double _indicatorHeight = 40;

  final double _pieIconSize = 12;
  final double _pieInnerRadius = 23;
  final double _pieOuterRadius = 50;
  final double _pieSectionSpace = 3;
  final double _pieInnerCenterSpaceRadius = 80;
  final double _pieOuterCenterSpaceRadius = 100;
  final double _pieInnerDegree = -90;
  final double _pieOuterDegree = -97.5;

  late final PageController _pageController;

  @override
  void initState() {
    _initializeController();
    super.initState();
  }

  void _initializeController() {
    List<Reserve> reserves = HelperJSON.getAnimalReserves(widget.animal.id).sorted(Reserve.sortById);

    _pageController = PageController(
      viewportFraction: 1,
      keepPage: true,
      initialPage: reserves.indexWhere((reserve) {
        if (widget.reserve != null) return reserve.id == widget.reserve!.id;
        return false;
      }),
    );
  }

  PieChartSectionData _buildZoneSection(AnimalZone zone) {
    return PieChartSectionData(
      color: zone.color,
      radius: _pieInnerRadius,
    );
  }

  PieChartSectionData _buildZoneSectionChange(AnimalZone zone) {
    return PieChartSectionData(
      color: zone.color,
      radius: _pieInnerRadius,
      badgeWidget: SvgPicture.asset(
        zone.icon,
        height: _pieIconSize,
        width: _pieIconSize,
        colorFilter: ColorFilter.mode(
          zone.iconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  PieChartSectionData _buildNumberSection(int hour) {
    return PieChartSectionData(
      color: Colors.transparent,
      radius: _pieOuterRadius,
      title: hour.toString(),
      showTitle: true,
      titleStyle: TextStyle(
        color: Interface.dark,
        fontSize: 16,
        fontWeight: FontWeight.w300,
        height: 1.1,
        fontFamily: FontFamily.normal,
      ),
    );
  }

  Widget _buildZoneChart(List<AnimalZone> zoneList) {
    final List<PieChartSectionData> data = [];
    final List<PieChartSectionData> numberData = [];

    String reserveName = HelperJSON.getReserve(zoneList[0].reserveId)!.name;
    for (AnimalZone zone in zoneList) {
      for (int hour = zone.from; hour < zone.to; hour++) {
        if ((zoneList.indexOf(zone) == 0 && zone.zone == zoneList[zoneList.length - 1].zone) || hour != zone.from) {
          data.add(_buildZoneSection(zone));
        } else {
          data.add(_buildZoneSectionChange(zone));
        }
        numberData.add(_buildNumberSection(hour));
      }
    }
    return _buildPieChartReserve(reserveName, data, numberData);
  }

  Widget _buildPieChartZones(List<PieChartSectionData> data) {
    return PieChart(PieChartData(
      startDegreeOffset: _pieInnerDegree,
      borderData: FlBorderData(show: false),
      sectionsSpace: _pieSectionSpace,
      centerSpaceRadius: _pieInnerCenterSpaceRadius,
      sections: data,
    ));
  }

  Widget _buildPieChartNumbers(List<PieChartSectionData> numberData) {
    return PieChart(PieChartData(
      startDegreeOffset: _pieOuterDegree,
      borderData: FlBorderData(show: false),
      centerSpaceRadius: _pieOuterCenterSpaceRadius,
      sections: numberData,
    ));
  }

  Widget _buildReserve(String name) {
    return SizedBox(
      height: _reserveHeight,
      child: WidgetPadding.h30(
        alignment: Alignment.center,
        child: WidgetText(
          name,
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      ),
    );
  }

  Widget _buildPieChart(List<PieChartSectionData> data, List<PieChartSectionData> numberData) {
    return SizedBox(
      height: _pageHeight,
      child: Stack(
        children: [
          _buildPieChartZones(data),
          _buildPieChartNumbers(numberData),
        ],
      ),
    );
  }

  Widget _buildPieChartReserve(
      String reserveName, List<PieChartSectionData> data, List<PieChartSectionData> numberData) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildPieChart(data, numberData),
        _buildReserve(reserveName),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return WidgetPageIndicator(
      _zones.length,
      height: _indicatorHeight,
      iColor: Interface.disabled,
      aColor: Interface.primary,
      pageController: _pageController,
    );
  }

  Widget _buildPages() {
    return SizedBox(
      height: _pageHeight + _reserveHeight,
      child: PageView(
        controller: _pageController,
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (int key in _zones.keys) _buildZoneChart(_zones[key]!),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: (_zones.length > 1) ? 450 : 410,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildPages(),
          if (_zones.length > 1) _buildPageIndicator(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
