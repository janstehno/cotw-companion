import 'package:cotwcompanion/activities/modify/add/counters.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/material.dart';

class ActivityEditCounters extends ActivityAddCounters {
  final Counter _counter;

  const ActivityEditCounters(
    Counter counter, {
    super.key,
    required super.helperEnumerator,
    required super.enumerator,
    required super.onSuccess,
  })  : _counter = counter,
        super(type: ModifyType.edit);

  Counter get counter => _counter;

  @override
  State<StatefulWidget> createState() => ActivityEditCountersState();
}

class ActivityEditCountersState extends ActivityAddCountersState {
  late final Counter _counter;

  @override
  void initState() {
    _counter = (widget as ActivityEditCounters).counter;
    textController.text = _counter.name;
    valueController.text = _counter.value.toString();
    errorMessage = "";
    super.initState();
  }

  @override
  void onSuccess() {
    _counter.setName(textController.text);
    _counter.setValue(int.parse(valueController.text));
    (widget as ActivityAddCounters).helperEnumerator.save();
  }
}
