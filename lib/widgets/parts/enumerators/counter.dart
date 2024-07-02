import 'package:cotwcompanion/activities/modify/edit/counters.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
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
  void onTap() {
    setState(() {
      (widget as WidgetCounter).counter.add();
      (widget as WidgetCounter).helperEnumerator.save();
      if (widget.callback != null) widget.callback!();
    });
  }

  @override
  void onDoubleTap() {
    setState(() {
      (widget as WidgetCounter).counter.subtract();
      (widget as WidgetCounter).helperEnumerator.save();
      if (widget.callback != null) widget.callback!();
    });
  }

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

  Widget _buildName() {
    return WidgetText(
      (widget as WidgetCounter).counter.name,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  Widget _buildValue() {
    return WidgetText(
      (widget as WidgetCounter).counter.value.toString(),
      color: Interface.dark,
      style: Style.normal.s18.w500,
    );
  }

  @override
  Widget buildEntry() {
    return WidgetPadding.h30(
      child: Row(
        children: [
          Expanded(child: _buildName()),
          _buildValue(),
        ],
      ),
    );
  }
}
