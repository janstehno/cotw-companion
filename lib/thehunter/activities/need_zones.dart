// Copyright (c) 2022 Jan Stehno

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/map.dart';
import 'package:cotwcompanion/thehunter/builders/need_zones/reserve_need_zones.dart';
import 'package:cotwcompanion/thehunter/model/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_slider.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class ActivityNeedZones extends StatefulWidget {
  const ActivityNeedZones({Key? key}) : super(key: key);

  @override
  ActivityNeedZonesState createState() => ActivityNeedZonesState();
}

class ActivityNeedZonesState extends State<ActivityNeedZones> {
  late RestartableTimer _timer;

  bool _stopped = false;
  bool _visible = true;

  int _hour = 8;
  int _minute = 30;
  int _second = 0;
  int _reserveID = 1;

  @override
  void initState() {
    Wakelock.enable();
    _timer = RestartableTimer(const Duration(milliseconds: 1000), () => _changeTime());
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    _timer.cancel();
    super.dispose();
  }

  _resetTimer() {
    setState(() {
      _stopped = !_stopped;
      _second = 0;
      _timer.reset();
    });
  }

  _changeTime() {
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

  Widget _buildSliders() {
    return Column(children: [
      WidgetSlider(
          values: [_hour.toDouble()],
          text: _hour.toString(),
          min: 0,
          max: 23,
          onDrag: (id, lower, upper) {
            setState(() {
              _hour = lower.toInt();
            });
          }),
      WidgetSlider(
          values: [_minute.toDouble()],
          text: _minute.toString(),
          min: 0,
          max: 59,
          handlerSize: 35,
          smallerSlider: true,
          onDrag: (id, lower, upper) {
            setState(() {
              _minute = lower.toInt();
            });
          })
    ]);
  }

  Widget _buildReserves() {
    return WidgetContainer(
        padding: const EdgeInsets.all(0),
        visible: _visible,
        child: DropdownButton(
            dropdownColor: Color(Values.colorDropDownBackground),
            underline: Container(),
            icon: Container(),
            elevation: 0,
            itemHeight: 60,
            isExpanded: true,
            value: _reserveID,
            onChanged: (dynamic value) {
              setState(() {
                _reserveID = value;
              });
            },
            items: _buildDropDownReserves()));
  }

  List<DropdownMenuItem> _buildDropDownReserves() {
    List<DropdownMenuItem> items = [];
    for (Reserve r in JSONHelper.reserves) {
      items.add(DropdownMenuItem(
          value: r.getID,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(r.getName(context.locale),
                  maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))));
    }
    return items;
  }

  WidgetAppBar _buildAppBar(Orientation orientation) {
    return WidgetAppBar(
        height: _visible ? 90 : 50,
        fontSize: Values.fontSize30,
        fontWeight: FontWeight.w700,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 23),
        function: () {
          Navigator.pop(context);
        },
        custom: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          WidgetSwitch(
              size: 60,
              icon: "assets/graphics/icons/view_compact.svg",
              inactiveIcon: "assets/graphics/icons/view_expanded.svg",
              activeColor: Values.colorAccent,
              activeBackground: Values.colorPrimary,
              inactiveColor: Values.colorAccent,
              inactiveBackground: Values.colorPrimary,
              noInactiveOpacity: true,
              isActive: _visible,
              visible: orientation == Orientation.portrait,
              onTap: () {
                setState(() {
                  _visible = !_visible;
                });
              }),
          Expanded(
              child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                padding: const EdgeInsets.only(right: 3),
                width: 40,
                child: AutoSizeText(_hour.toInt().toString(),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w800, fontFamily: 'Title'))),
            SizedBox(
                width: 15,
                child:
                    Text(":", textAlign: TextAlign.center, style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w700))),
            SizedBox(
                width: 40,
                child: AutoSizeText(_minute.toInt().toString(),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w800, fontFamily: 'Title'))),
            SizedBox(
                width: 15,
                child:
                    Text(":", textAlign: TextAlign.center, style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w700))),
            Container(
                padding: const EdgeInsets.only(left: 3),
                width: 40,
                child: AutoSizeText(_second.toInt().toString(),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(Values.colorAccent), fontSize: Values.fontSize30, fontWeight: FontWeight.w800, fontFamily: 'Title'))),
          ]))
        ]));
  }

  Widget _buildTimeAndReserve() {
    return Column(children: [
      EntryName.withSwitch(
          isTitle: true,
          text: tr('time'),
          size: 40,
          background: Values.colorContentSubTitleBackground,
          buttonActiveColor: Values.colorAlwaysDark,
          buttonInactiveColor: Values.colorAlwaysDark,
          buttonActiveBackground: Values.colorSwitchPlay,
          buttonInactiveBackground: Values.colorSwitchStop,
          buttonIcon: "assets/graphics/icons/play.svg",
          buttonInactiveIcon: "assets/graphics/icons/stop.svg",
          noInactiveOpacity: true,
          isActive: _stopped,
          visible: _visible,
          onTap: () {
            _resetTimer();
          }),
      WidgetContainer(visible: _visible, padding: const EdgeInsets.fromLTRB(30, 15, 30, 15), child: _buildSliders()),
      EntryName.withTap(
          isTitle: true,
          text: tr('reserve'),
          size: 40,
          background: Values.colorContentSubTitleBackground,
          buttonIcon: "assets/graphics/icons/map.svg",
          visible: _visible,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BuilderMap(reserveID: _reserveID)),
            );
          }),
      _buildReserves()
    ]);
  }

  Widget _buildNeedZones() {
    return Column(
        children: [WidgetTitle.sub(text: tr('animal_need_zones'), visible: _visible), BuilderReserveNeedZones(reserveID: _reserveID, hour: _hour, compact: _visible)]);
  }

  Widget _buildPortraitView() {
    return WidgetScaffold(appBar: _buildAppBar(Orientation.portrait), children: [_buildTimeAndReserve(), _buildNeedZones()]);
  }

  Widget _buildLandscapeView() {
    _visible = true;
    return WidgetScaffoldAdvanced(
        body: Column(mainAxisSize: MainAxisSize.max, children: [
      _buildAppBar(Orientation.landscape),
      Expanded(
          child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(flex: 2, child: SingleChildScrollView(child: _buildTimeAndReserve())),
        Flexible(flex: 3, child: SingleChildScrollView(child: _buildNeedZones()))
      ]))
    ]));
  }

  Widget _buildWidgets() {
    return OrientationBuilder(builder: ((context, orientation) {
      return orientation == Orientation.portrait ? _buildPortraitView() : _buildLandscapeView();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
