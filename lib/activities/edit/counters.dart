// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/abstract_edit.dart';
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

  late final int _enumeratorId;

  @override
  void initState() {
    _enumeratorId = (widget as ActivityEditCounters).enumeratorId;
    _controllerValue.addListener(() => reload());
    super.initState();
  }

  @override
  void getData() {
    if ((widget as ActivityEditCounters).counter != null) {
      //WHEN EDITING
      editing = true;
      controller.text = (widget as ActivityEditCounters).counter!.name;
      _controllerValue.text = (widget as ActivityEditCounters).counter!.value.toString();
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
    Counter? counter = (widget as ActivityEditCounters).counter;
    int counterId = editing ? counter!.id : HelperEnumerator.enumerators.elementAt(_enumeratorId).counters.length;
    counter = Counter(id: counterId, name: controller.text, value: int.tryParse(_controllerValue.text) ?? 0);
    return counter;
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
