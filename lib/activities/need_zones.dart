import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/lists/need_zones/need_zones.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/button/switch_text.dart';
import 'package:cotwcompanion/widgets/handling/drop_down.dart';
import 'package:cotwcompanion/widgets/handling/slider.dart';
import 'package:cotwcompanion/widgets/parts/need_zones/time.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:cotwcompanion/widgets/title/title_switch_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityNeedZones extends StatefulWidget {
  const ActivityNeedZones({
    super.key,
  });

  @override
  ActivityNeedZonesState createState() => ActivityNeedZonesState();
}

class ActivityNeedZonesState extends State<ActivityNeedZones> {
  final ScrollController _leftScrollController = ScrollController(initialScrollOffset: 0);
  final ScrollController _rightScrollController = ScrollController(initialScrollOffset: 0);

  final int _classes = 9;
  final Map<int, bool> _shownClasses = {};
  final Map<int, bool> _disabledClasses = {};

  late RestartableTimer _timer;

  bool _stopped = false;
  bool _compact = false;
  bool _classSwitches = true;
  int _hour = 8;
  int _minute = 30;
  int _second = 0;
  int _inGameSecond = 995572;

  Reserve _reserve = HelperJSON.reserves.first;

  @override
  void initState() {
    _timer = RestartableTimer(const Duration(microseconds: 995572), () => _changeTime());
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
        if (++_second == 15) {
          _second = 0;
          if (++_minute == 60) {
            _minute = 0;
            _hour = ++_hour % 24;
            _adjustSecond();
          }
        }
      }
    });
  }

  void _resetSwitches() {
    for (int i = 0; i < _classes; i++) {
      _shownClasses[i] = false;
      _disabledClasses[i] = true;
      if (_reserve.allClasses.contains(i + 1)) {
        _shownClasses[i] = true;
        _disabledClasses[i] = false;
      }
    }
  }

  Widget _buildTimeSliders() {
    return Column(
      children: [
        WidgetSlider(
          values: [_hour.toDouble()],
          min: 0,
          max: 23,
          onChange: (id, lower, upper) {
            setState(() {
              _hour = lower.toInt();
              _adjustSecond();
            });
          },
        ),
        WidgetSlider(
          values: [_minute.toDouble()],
          min: 0,
          max: 59,
          onChange: (id, lower, upper) {
            setState(() {
              _minute = lower.toInt();
            });
          },
        )
      ],
    );
  }

  DropdownMenuItem _buildDropDownReserve(Reserve reserve) {
    return DropdownMenuItem(
      value: reserve.id,
      child: WidgetPadding.h30(
        background: Interface.body,
        child: WidgetText(
          reserve.name,
          color: Interface.dark,
          style: Style.normal.s16.w300,
        ),
      ),
    );
  }

  List<DropdownMenuItem> _listReserves() {
    return HelperJSON.reserves.sorted(Reserve.sortById).toList().map((e) => _buildDropDownReserve(e)).toList();
  }

  Widget _buildReserves() {
    if (!_compact) {
      return WidgetDropDown(
        value: _reserve.id,
        items: _listReserves(),
        onChange: (dynamic value) {
          setState(() {
            _reserve = HelperJSON.getReserve(value)!;
            _resetSwitches();
          });
        },
      );
    }
    return const SizedBox.shrink();
  }

  double _getSwitchSize() {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemsBetween = 8 * 10 + 30 * 2;
    double availableWidth = screenWidth - itemsBetween;
    double itemsWidth = 9 * Values.tapSize;
    double calcWidth = availableWidth / 9;
    return availableWidth > itemsWidth ? Values.tapSize : calcWidth;
  }

  Widget _buildClassSwitch(int i) {
    return Container(
      width: _getSwitchSize(),
      height: _getSwitchSize(),
      margin: EdgeInsets.only(right: i < 8 ? 10 : 0),
      child: WidgetSwitchText(
        "${i + 1}",
        color: Interface.disabledForeground,
        background: Interface.disabled.withValues(alpha: _disabledClasses[i]! ? 0.5 : 1),
        activeColor: Interface.alwaysDark,
        activeBackground: Interface.primary,
        isActive: _shownClasses[i]!,
        onTap: () {
          if (_disabledClasses[i]!) return;
          setState(() {
            _shownClasses[i] = !(_shownClasses[i]!);
          });
        },
      ),
    );
  }

  List<Widget> _buildClassSwitches() {
    List<Widget> switches = [];
    for (int i = 0; i < _classes; i++) {
      switches.add(_buildClassSwitch(i));
    }
    return switches;
  }

  Widget _buildClass() {
    return WidgetPadding.fromLTRB(
      30,
      _compact ? 20 : 0,
      30,
      _compact ? 20 : 30,
      background: Interface.title,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildClassSwitches(),
        ),
      ),
    );
  }

  Widget _buildTimeChangerAndReserve() {
    return Column(
      children: [
        WidgetTitleSwitchIcon(
          tr("TIME"),
          icon: Assets.graphics.icons.stop,
          buttonColor: Interface.alwaysDark,
          buttonBackground: Interface.timerStop,
          activeIcon: Assets.graphics.icons.play,
          activeButtonColor: Interface.alwaysDark,
          activeButtonBackground: Interface.timerPlay,
          alignRight: true,
          isActive: _stopped,
          onTap: () => _resetTimer(),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: _buildTimeSliders(),
        ),
        WidgetTitleButtonIcon(
          tr("RESERVE"),
          icon: Assets.graphics.icons.map,
          alignRight: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => BuilderMap(reserve: _reserve)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeAndSelectors(bool portrait) {
    return Column(children: [
      WidgetNeedZoneTime(
        hour: _hour,
        minute: _minute,
        second: _second,
        compact: _compact,
        onViewTap: () {
          setState(() {
            _compact = !_compact;
            _classSwitches = !_compact;
          });
        },
        onClassTap: () => setState(() => _classSwitches = !_classSwitches),
      ),
      if (!_compact) _buildTimeChangerAndReserve(),
      _buildReserves(),
    ]);
  }

  Widget _buildNeedZones() {
    return Column(
      children: [
        if (!_compact) WidgetTitle(tr("ANIMAL_NEED_ZONES")),
        if (_classSwitches) _buildClass(),
        ListNeedZones(
          _reserve,
          hour: _hour,
          classes: _shownClasses,
          compact: _compact,
          classSwitches: _classSwitches,
        ),
      ],
    );
  }

  WidgetAppBar _buildAppBar() {
    return WidgetAppBar(
      tr("ANIMAL_NEED_ZONES"),
      context: context,
    );
  }

  Widget _buildLeft() {
    return WidgetScrollBar(
      controller: _leftScrollController,
      child: SingleChildScrollView(
        controller: _leftScrollController,
        child: Column(
          children: [
            _buildAppBar(),
            _buildTimeAndSelectors(false),
          ],
        ),
      ),
    );
  }

  Widget _buildRight() {
    return WidgetScrollBar(
      controller: _rightScrollController,
      child: SingleChildScrollView(
        controller: _rightScrollController,
        child: _buildNeedZones(),
      ),
    );
  }

  Widget _buildLandscapeView() {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Interface.body,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 2, child: _buildLeft()),
            Flexible(flex: 3, child: _buildRight()),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitView() {
    return WidgetScaffold(
      appBar: (!_compact) ? _buildAppBar() : null,
      children: [
        _buildTimeAndSelectors(true),
        _buildNeedZones(),
      ],
    );
  }

  Widget _buildWidgets() {
    return OrientationBuilder(builder: ((context, orientation) {
      return orientation == Orientation.portrait ? _buildPortraitView() : _buildLandscapeView();
    }));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
