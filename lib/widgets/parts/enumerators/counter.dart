import 'package:cotwcompanion/activities/modify/edit/counters.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/parts/enumerators/dismissible.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class WidgetCounter extends WidgetEnumeratorDismissible {
  final Counter _counter;

  const WidgetCounter(
    super.i, {
    super.key,
    required super.enumerator,
    required super.callback,
    required super.context,
    required super.helperEnumerator,
    required Counter counter,
  }) : _counter = counter;

  Counter get counter => _counter;

  @override
  State<StatefulWidget> createState() => WidgetCounterState();
}

class WidgetCounterState extends WidgetEnumeratorEntryState {
  @override
  void startToEnd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (e) => ActivityEditCounters(
          (widget as WidgetCounter).counter,
          helperEnumerator: (widget as WidgetCounter).helperEnumerator,
          enumerator: (widget as WidgetCounter).enumerator,
          onSuccess: widget.callback ?? () {},
        ),
      ),
    );
  }

  @override
  void onTap() {}

  @override
  void onDoubleTap() {}

  @override
  void endToStart() {
    setState(() {
      (widget as WidgetCounter)
          .helperEnumerator
          .removeCounter((widget as WidgetCounter).enumerator, (widget as WidgetCounter).counter);
      if (widget.callback != null) widget.callback!();
    });
    super.endToStart();
  }

  @override
  void undo() {
    (widget as WidgetCounter).helperEnumerator.undoRemoveCounter((widget as WidgetCounter).enumerator);
    if (widget.callback != null) widget.callback!();
  }

  Widget _buildMinusButton() {
    return WidgetButtonIcon(
      Assets.graphics.icons.minus,
      size: Values.tapSize / 3,
      color: Interface.dark,
      background: Interface.search,
      onTap: () {
        setState(() {
          (widget as WidgetCounter).counter.subtract();
          (widget as WidgetCounter).helperEnumerator.save();
          if (widget.callback != null) widget.callback!();
        });
      },
    );
  }

  Widget _buildPlusButton() {
    return WidgetButtonIcon(
      Assets.graphics.icons.plus,
      size: Values.tapSize / 3,
      color: Interface.dark,
      background: Interface.search,
      onTap: () {
        setState(() {
          (widget as WidgetCounter).counter.add();
          (widget as WidgetCounter).helperEnumerator.save();
          if (widget.callback != null) widget.callback!();
        });
      },
    );
  }

  Widget _buildName(Counter counter) {
    return Row(
      children: [
        if (counter.icon.id != 0 || counter.color.id != 0)
          WidgetButtonIcon(
            counter.icon.asset,
            color: counter.color.id == 0 ? Interface.dark : counter.color.color,
            background: counter.color.id == 0 ? Interface.transparent : counter.color.background,
            onTap: () {},
          ),
        if (counter.icon.id != 0 || counter.color.id != 0) SizedBox(width: 10),
        Expanded(
          child: WidgetText(
            counter.name,
            color: Interface.dark,
            style: Style.normal.s16.w400,
            autoSize: true,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildValue(Counter counter) {
    return WidgetText(
      Utils.formatNumber(counter.value, 1000000),
      color: Interface.dark,
      style: Style.normal.s24.w600,
    );
  }

  @override
  Widget buildEntry() {
    Counter counter = (widget as WidgetCounter).counter;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: Values.section * 1.2,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Row(
              children: [
                _buildMinusButton(),
                SizedBox(width: 10),
                Expanded(child: _buildName(counter)),
                SizedBox(width: 30),
                _buildValue(counter),
                SizedBox(width: 10),
                _buildPlusButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
