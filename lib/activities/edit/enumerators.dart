// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/abstract_edit.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityEditEnumerators extends ActivityEdit {
  final int? enumeratorId;

  const ActivityEditEnumerators({
    super.key,
    required super.callback,
    this.enumeratorId,
  });

  @override
  ActivityEditEnumeratorsState createState() => ActivityEditEnumeratorsState();
}

class ActivityEditEnumeratorsState extends ActivityEditState {
  @override
  void getData() {
    int? enumeratorId = (widget as ActivityEditEnumerators).enumeratorId;
    if (enumeratorId != null) {
      //WHEN EDITING
      editing = true;
      controller.text = HelperEnumerator.getEnumerator(enumeratorId).name;
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

  Enumerator _createEnumerator() {
    int? enumeratorId = (widget as ActivityEditEnumerators).enumeratorId;
    Enumerator enumerator = HelperEnumerator.getEnumerator(enumeratorId!);
    int newEnumeratorId = editing ? enumerator.id : HelperEnumerator.enumerators.length;
    return Enumerator(id: newEnumeratorId, name: controller.text, counters: enumerator.counters);
  }

  @override
  void addOrEdit() {
    Enumerator enumerator = _createEnumerator();
    editing ? HelperEnumerator.editEnumerator(enumerator) : HelperEnumerator.addEnumerator(enumerator);
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(),
      ],
    );
  }
}
