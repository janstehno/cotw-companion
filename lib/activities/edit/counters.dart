// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/edit.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityEditCounters extends ActivityEdit {
  final int enumeratorId;
  final Counter? counter;

  const ActivityEditCounters({
    super.key,
    required super.callback,
    required this.enumeratorId,
    this.counter,
  });

  @override
  ActivityEditCountersState createState() => ActivityEditCountersState();
}

class ActivityEditCountersState extends ActivityEditState {
  final TextEditingController _controllerValue = TextEditingController(text: "0");

  late final Counter? _counter;
  late final int _enumeratorId;

  @override
  void initState() {
    _counter = (widget as ActivityEditCounters).counter;
    _enumeratorId = (widget as ActivityEditCounters).enumeratorId;
    _controllerValue.addListener(() => reload());
    super.initState();
  }

  @override
  void getData() {
    if (_counter != null) {
      //WHEN EDITING
      editing = true;
      controller.text = HelperEnumerator.getCounter(_enumeratorId, _counter!.id).name;
      _controllerValue.text = HelperEnumerator.getCounter(_enumeratorId, _counter!.id).value.toString();
    }
  }

  @override
  void checkData() {
    if (controller.text.isEmpty) {
      errorMessage = tr("error_no_name");
    } else if (!correctName) {
      errorMessage = tr("error_wrong_name");
    } else {
      errorMessage = "";
    }
  }

  Counter _createCounter() {
    return Counter(
      id: editing ? _counter!.id : HelperEnumerator.enumerators.elementAt(_enumeratorId).counters.length,
      name: controller.text,
      value: int.tryParse(_controllerValue.text) ?? 0,
    );
  }

  Widget _buildValue() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("value"),
      ),
      WidgetTextFieldIndicator(
        icon: "assets/graphics/icons/number.svg",
        numberOnly: true,
        decimal: false,
        correct: true,
        controller: _controllerValue,
      )
    ]);
  }

  @override
  void addOrEdit() {
    Counter counter = _createCounter();
    editing ? HelperEnumerator.editCounter(_enumeratorId, counter) : HelperEnumerator.addCounter(_enumeratorId, counter);
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(),
        _buildValue(),
      ],
    );
  }
}
