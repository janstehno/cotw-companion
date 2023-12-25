// Copyright (c) 2023 Jan Stehno

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/lists/need_zones/need_zones.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/drop_down.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/slider.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/switch_text.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityNeedZones extends StatefulWidget {
  const ActivityNeedZones({
    Key? key,
  }) : super(key: key);

  @override
  ActivityNeedZonesState createState() => ActivityNeedZonesState();
}

class ActivityNeedZonesState extends State<ActivityNeedZones> {
  final List<bool> _shownClasses = [false, false, false, false, false, false, false, false, false];
  final List<bool> _disabledClasses = [true, true, true, true, true, true, true, true, true];
  final double _interfaceHeight = 45;
  final double _interfaceIconSize = 45;
  final double _timeWidth = 40;
  final double _timeDotWidth = 15;
  final double _timeDotSize = 3.5;
  final double _switchWidth = 30;
  final double _switchSpace = 10;
  final double _switchPadding = 30;

  late List<int> _allClasses = [];
  late RestartableTimer _timer;

  bool _stopped = false;
  bool _compact = false;
  bool _classSwitches = true;
  int _hour = 8;
  int _minute = 30;
  int _second = 0;
  int _reserveId = 1;
  int _inGameSecond = 995572;

  @override
  void initState() {
    _timer = RestartableTimer(const Duration(microseconds: 995572), () => _changeTime());
    _allClasses = HelperJSON.getReserve(_reserveId).allClasses;
    _resetSwitches();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _adjustSecond() {
    setState(() {
      _timer.cancel();
      if (_hour < 4) {
        _inGameSecond = 1000717;
      } else if (_hour > 15) {
        _inGameSecond = 1021850;
      }
      _timer = RestartableTimer(Duration(microseconds: _inGameSecond), () => _changeTime());
    });
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
            _hour == 24 ? _hour = 0 : _hour += 1;
            _adjustSecond();
          }
        }
      }
    });
  }

  void _resetSwitches() {
    for (int index = 0; index < 9; index++) {
      _shownClasses[index] = false;
      _disabledClasses[index] = true;
      if (_allClasses.contains(index + 1)) {
        _shownClasses[index] = true;
        _disabledClasses[index] = false;
      }
    }
  }

  Widget _buildTimeSliders() {
    return Column(children: [
      WidgetSlider(
          values: [_hour.toDouble()],
          min: 0,
          max: 23,
          onDrag: (id, lower, upper) {
            setState(() {
              _hour = lower.toInt();
              _adjustSecond();
            });
          }),
      WidgetSlider(
          values: [_minute.toDouble()],
          min: 0,
          max: 59,
          onDrag: (id, lower, upper) {
            setState(() {
              _minute = lower.toInt();
            });
          })
    ]);
  }

  Widget _buildReserves() {
    return _compact
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.all(0),
            child: WidgetDropDown(
                value: _reserveId,
                items: _buildDropDownReserves(),
                onTap: (dynamic value) {
                  setState(() {
                    _reserveId = value;
                    _allClasses = HelperJSON.getReserve(value).allClasses;
                    _resetSwitches();
                  });
                }));
  }

  List<DropdownMenuItem> _buildDropDownReserves() {
    List<DropdownMenuItem> items = [];
    for (Reserve reserve in HelperJSON.reserves) {
      items.add(
        DropdownMenuItem(
            value: reserve.id,
            child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: AutoSizeText(
                  reserve.getName(context.locale),
                  maxLines: 1,
                  style: Interface.s16w300n(Interface.dark),
                ))),
      );
    }
    return items;
  }

  Widget _buildSwitches(bool portrait, Color color) {
    _classSwitches = !portrait ? true : _classSwitches;
    return Row(children: [
      _compact
          ? WidgetButtonIcon(
              buttonSize: _interfaceIconSize,
              icon: "assets/graphics/icons/min_max.svg",
              color: color,
              background: Colors.transparent,
              onTap: () {
                setState(() {
                  _classSwitches = !_classSwitches;
                });
              },
            )
          : const SizedBox.shrink(),
      portrait
          ? WidgetSwitchIcon(
              buttonSize: _interfaceIconSize,
              icon: "assets/graphics/icons/view_compact.svg",
              activeIcon: "assets/graphics/icons/view_expanded.svg",
              color: color,
              background: Colors.transparent,
              activeColor: color,
              activeBackground: Colors.transparent,
              isActive: _compact,
              onTap: () {
                setState(() {
                  _compact = !_compact;
                  _classSwitches = !_compact;
                });
              },
            )
          : const SizedBox.shrink()
    ]);
  }

  Widget _buildTime(Color color) {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      AnimatedContainer(
          width: _timeWidth,
          padding: const EdgeInsets.only(right: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _hour.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
      AnimatedContainer(
          width: _timeDotWidth,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: _timeDotSize,
                height: _timeDotSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: _timeDotSize,
              height: _timeDotSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: _timeWidth,
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _minute.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
      AnimatedContainer(
          width: _timeDotWidth,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: _timeDotSize,
                height: _timeDotSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: _timeDotSize,
              height: _timeDotSize,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: _timeWidth,
          padding: const EdgeInsets.only(left: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _second.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
    ]);
  }

  Widget _buildActualTimeAndCompact(bool portrait) {
    Color color = Interface.dark;
    Color background = Interface.primary.withOpacity(0.5);
    return AnimatedContainer(
        height: _interfaceHeight,
        padding: const EdgeInsets.only(left: 20, right: 20),
        duration: const Duration(microseconds: 200),
        color: background,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(child: _buildTime(color)),
          _buildSwitches(portrait, color),
        ]));
  }

  double _getSwitchSize() {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemsBetween = 8 * _switchSpace + _switchPadding * 2;
    double availableWidth = screenWidth - itemsBetween;
    double itemsWidth = 9 * _switchWidth;
    double calcWidth = availableWidth / 9;
    return availableWidth > itemsWidth ? _switchWidth : calcWidth;
  }

  List<Widget> _buildClassSwitches() {
    List<Widget> switches = [];
    for (int index = 0; index < 9; index++) {
      switches.add(Container(
          margin: EdgeInsets.only(right: index < 8 ? _switchSpace : 0),
          child: WidgetSwitchText(
            buttonWidth: _getSwitchSize(),
            buttonHeight: _getSwitchSize(),
            text: "${index + 1}",
            color: Interface.disabled.withOpacity(_disabledClasses.elementAt(index) ? 0.3 : 1),
            background: Interface.disabled.withOpacity(_disabledClasses.elementAt(index) ? 0.1 : 0.3),
            isActive: _shownClasses.elementAt(index),
            disabled: _disabledClasses.elementAt(index),
            onTap: () {
              setState(() {
                _shownClasses[index] = !(_shownClasses.elementAt(index));
              });
            },
          )));
    }
    return switches;
  }

  Widget _buildClass() {
    return _classSwitches
        ? Container(
            color: Interface.title,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, _compact ? 20 : 0, 30, _compact ? 20 : 30),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildClassSwitches(),
                )))
        : const SizedBox.shrink();
  }

  Widget _buildTimeChangerAndReserve() {
    return _compact
        ? const SizedBox.shrink()
        : Column(children: [
            WidgetTitleBigSwitch(
              primaryText: tr("time"),
              icon: "assets/graphics/icons/stop.svg",
              color: Interface.alwaysDark,
              background: Interface.red,
              activeIcon: "assets/graphics/icons/play.svg",
              activeColor: Interface.alwaysDark,
              activeBackground: Interface.blue,
              isActive: _stopped,
              onTap: () {
                _resetTimer();
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: _buildTimeSliders(),
            ),
            WidgetTitleBigButton(
              primaryText: tr("reserve"),
              icon: "assets/graphics/icons/map.svg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuilderMap(reserveId: _reserveId)),
                );
              },
            )
          ]);
  }

  Widget _buildTimeAndSelectors(bool portrait) {
    return Column(children: [
      _buildActualTimeAndCompact(portrait),
      _buildTimeChangerAndReserve(),
      _buildReserves(),
    ]);
  }

  Widget _buildNeedZones() {
    return Column(children: [
      _compact
          ? const SizedBox.shrink()
          : WidgetTitleBig(
              primaryText: tr("animal_need_zones"),
            ),
      _buildClass(),
      ListNeedZones(
        reserveId: _reserveId,
        hour: _hour,
        classes: _shownClasses,
        compact: _compact,
        classSwitches: _classSwitches,
      )
    ]);
  }

  WidgetAppBar _buildAppBar() {
    return _compact
        ? WidgetAppBar(
            text: "",
            height: 0,
            context: context,
          )
        : WidgetAppBar(
            text: tr("animal_need_zones"),
            context: context,
          );
  }

  Widget _buildPortraitView() {
    return WidgetScaffold(
        appBar: _buildAppBar(),
        body: Column(children: [
          _buildTimeAndSelectors(true),
          _buildNeedZones(),
        ]));
  }

  Widget _buildLandscapeView() {
    _compact = false;
    return WidgetScaffold(
        customBody: true,
        body: Column(children: [
          _buildAppBar(),
          Expanded(
              child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              flex: 2,
              child: WidgetScrollbar(
                child: SingleChildScrollView(
                  child: _buildTimeAndSelectors(false),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: WidgetScrollbar(
                child: SingleChildScrollView(
                  child: _buildNeedZones(),
                ),
              ),
            ),
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
