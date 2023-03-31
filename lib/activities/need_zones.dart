// Copyright (c) 2022 Jan Stehno

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/builders/need_zones/reserve_need_zones.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/title_functional.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/slider.dart';
import 'package:cotwcompanion/widgets/switch.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class ActivityNeedZones extends StatefulWidget {
  const ActivityNeedZones({
    Key? key,
  }) : super(key: key);

  @override
  ActivityNeedZonesState createState() => ActivityNeedZonesState();
}

class ActivityNeedZonesState extends State<ActivityNeedZones> {
  final int _inGameSecond = 993333;

  late final RestartableTimer _timer;

  bool _stopped = false;
  bool _compact = false;
  bool _classSlider = true;
  int _hour = 8;
  int _minute = 30;
  int _second = 0;
  int _min = 1;
  int _max = 9;
  int _maxClass = 9;
  int _reserveId = 1;

  @override
  void initState() {
    Wakelock.enable();
    _timer = RestartableTimer(Duration(microseconds: _inGameSecond), () => _changeTime());
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void _resetTimer() {
    setState(() {
      _stopped = !_stopped;
      _second = 0;
      _timer.reset();
    });
  }

  void _changeTime() {
    setState(() {
      if (!_stopped) {
        _timer.reset();
        _second += 1;
        if (_second == 15) {
          _second = 0;
          _minute += 1;
          if (_minute == 60) {
            _minute = 0;
            _hour += 1;
            if (_hour == 24) {
              _hour = 0;
            }
          }
        }
      }
    });
  }

  Widget _buildTimeSliders() {
    return Column(children: [
      WidgetSlider(
          values: [_hour.toDouble()],
          leftText: _hour.toString(),
          min: 0,
          max: 23,
          onDrag: (id, lower, upper) {
            setState(() {
              _hour = lower.toInt();
            });
          }),
      WidgetSlider(
          values: [_minute.toDouble()],
          leftText: _minute.toString(),
          min: 0,
          max: 59,
          handleSize: 35,
          smallerSlider: true,
          onDrag: (id, lower, upper) {
            setState(() {
              _minute = lower.toInt();
            });
          })
    ]);
  }

  Widget _buildClassSlider() {
    return SizedBox(
        height: 50,
        child: WidgetSlider(
            values: [_min.toDouble(), _max.toDouble()],
            leftText: _min.toString(),
            rightText: _max.toString(),
            min: 1,
            max: _maxClass.toDouble(),
            rangeSlider: true,
            handleSize: 30,
            onDrag: (id, lower, upper) {
              setState(() {
                _min = lower.toInt();
                _max = upper.toInt();
              });
            }));
  }

  Widget _buildReserves() {
    return _compact
        ? Container()
        : Container(
            padding: const EdgeInsets.all(0),
            child: DropdownButton(
              dropdownColor: Interface.dropDownBody,
              underline: Container(),
              icon: Container(),
              elevation: 0,
              itemHeight: 60,
              isExpanded: true,
              value: _reserveId,
              onChanged: (dynamic value) {
                setState(() {
                  _reserveId = value;
                  _maxClass = _max = HelperJSON.getReserve(value).maxClass;
                });
              },
              items: _buildDropDownReserves(),
            ));
  }

  List<DropdownMenuItem> _buildDropDownReserves() {
    List<DropdownMenuItem> items = [];
    for (Reserve reserve in HelperJSON.reserves) {
      items.add(DropdownMenuItem(
          value: reserve.id,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(reserve.getName(context.locale),
                  maxLines: 1,
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s20,
                    fontWeight: FontWeight.w400,
                  )))));
    }
    return items;
  }

  Widget _buildSwitches(bool portrait, Color color) {
    _classSlider = !portrait ? true : _classSlider;
    return Row(children: [
      _compact
          ? WidgetSwitch.withIcon(
              buttonSize: 50,
              activeIcon: "assets/graphics/icons/min_max.svg",
              inactiveIcon: "assets/graphics/icons/min_max.svg",
              activeColor: color,
              inactiveColor: color,
              activeBackground: Colors.transparent,
              inactiveBackground: Colors.transparent,
              isActive: _classSlider,
              onTap: () {
                setState(() {
                  _classSlider = !_classSlider;
                });
              },
            )
          : Container(),
      portrait
          ? WidgetSwitch.withIcon(
              buttonSize: 50,
              activeIcon: "assets/graphics/icons/view_expanded.svg",
              inactiveIcon: "assets/graphics/icons/view_compact.svg",
              activeColor: color,
              inactiveColor: color,
              activeBackground: Colors.transparent,
              inactiveBackground: Colors.transparent,
              isActive: _compact,
              onTap: () {
                setState(() {
                  _compact = !_compact;
                  _classSlider = !_compact;
                });
              },
            )
          : Container()
    ]);
  }

  Widget _buildTime(Color color) {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      AnimatedContainer(
          width: 40,
          padding: const EdgeInsets.only(right: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(_hour.toInt().toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: Interface.s26,
                fontWeight: FontWeight.w700,
                fontFamily: 'Title',
              ))),
      AnimatedContainer(
          width: 15,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 3.5,
                height: 3.5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: 3.5,
              height: 3.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: 40,
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(_minute.toInt().toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: Interface.s26,
                fontWeight: FontWeight.w700,
                fontFamily: 'Title',
              ))),
      AnimatedContainer(
          width: 15,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 3.5,
                height: 3.5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: 3.5,
              height: 3.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: 40,
          padding: const EdgeInsets.only(left: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(_second.toInt().toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: Interface.s26,
                fontWeight: FontWeight.w700,
                fontFamily: 'Title',
              ))),
    ]);
  }

  Widget _buildActualTimeAndCompact(bool portrait) {
    Color color = Interface.dark;
    Color background = Interface.primary.withOpacity(0.5);
    return AnimatedContainer(
        height: 50,
        padding: const EdgeInsets.only(left: 20, right: 20),
        duration: const Duration(microseconds: 200),
        color: background,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Expanded(child: _buildTime(color)), _buildSwitches(portrait, color)]));
  }

  Widget _buildClass() {
    return _classSlider
        ? AnimatedContainer(
            height: 75,
            padding: const EdgeInsets.only(left: 30, right: 30),
            duration: const Duration(microseconds: 200),
            color: Interface.subTitleBackground,
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(tr('animal_class').toUpperCase(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Interface.title,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Title',
                      ))),
              Expanded(child: _buildClassSlider())
            ]))
        : Container();
  }

  Widget _buildTimeChangerAndReserve() {
    return _compact
        ? Container()
        : Column(children: [
            WidgetTitleFunctional.withSwitch(
              text: tr('time'),
              icon: "assets/graphics/icons/play.svg",
              inactiveIcon: "assets/graphics/icons/stop.svg",
              textColor: Interface.title,
              background: Interface.subTitleBackground,
              iconColor: Interface.alwaysDark,
              iconInactiveColor: Interface.alwaysDark,
              buttonBackground: Interface.play,
              buttonInactiveBackground: Interface.stop,
              isTitle: true,
              isActive: _stopped,
              onTap: () {
                _resetTimer();
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: _buildTimeSliders(),
            ),
            WidgetTitleFunctional.withButton(
                text: tr('reserve'),
                icon: "assets/graphics/icons/map.svg",
                textColor: Interface.title,
                background: Interface.subTitleBackground,
                iconColor: Interface.alwaysDark,
                buttonBackground: Interface.play,
                isTitle: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuilderMap(reserveId: _reserveId)),
                  );
                })
          ]);
  }

  Widget _buildTimeAndSelectors(bool portrait) {
    return Column(children: [
      _buildActualTimeAndCompact(portrait),
      _buildTimeChangerAndReserve(),
      _buildReserves(),
      _buildClass(),
    ]);
  }

  Widget _buildNeedZones() {
    return Column(children: [
      _compact
          ? Container()
          : WidgetTitle(
              text: tr('animal_need_zones'),
            ),
      BuilderReserveNeedZones(
        reserveId: _reserveId,
        hour: _hour,
        min: _min,
        max: _max,
        compact: _compact,
        classSlider: _classSlider,
      )
    ]);
  }

  WidgetAppBar _buildAppBar() {
    return _compact
        ? WidgetAppBar(
            text: "",
            height: 0,
            fontSize: 0,
            context: context,
          )
        : WidgetAppBar(
            text: tr('animal_need_zones'),
            color: Interface.accent,
            background: Interface.primary,
            fontSize: Interface.s30,
            context: context,
          );
  }

  Widget _buildPortraitView() {
    return WidgetScaffold(appBar: _buildAppBar(), children: [
      _buildTimeAndSelectors(true),
      _buildNeedZones(),
    ]);
  }

  Widget _buildLandscapeView() {
    _compact = false;
    return WidgetScaffold.withCustomBody(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      _buildAppBar(),
      Expanded(
          child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
            flex: 2,
            child: WidgetScrollbar(
                child: SingleChildScrollView(
              child: _buildTimeAndSelectors(false),
            ))),
        Flexible(
            flex: 3,
            child: WidgetScrollbar(
                child: SingleChildScrollView(
              child: _buildNeedZones(),
            )))
      ]))
    ]));
  }

  Widget _buildWidgets() {
    return OrientationBuilder(builder: ((context, orientation) {
      return orientation == Orientation.portrait ? _buildPortraitView() : _buildLandscapeView();
    }));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
