// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/abstract_edit.dart';
import 'package:cotwcompanion/miscellaneous/helpers/enumerator.dart';
import 'package:cotwcompanion/model/enumerator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityEditEnumerators extends ActivityEdit {
  final Enumerator? enumerator;

  const ActivityEditEnumerators({
    super.key,
    required super.callback,
    this.enumerator,
  });

  @override
  ActivityEditEnumeratorsState createState() => ActivityEditEnumeratorsState();
}

class ActivityEditEnumeratorsState extends ActivityEditState {
  @override
  void getData() {
    if ((widget as ActivityEditEnumerators).enumerator != null) {
      //WHEN EDITING
      editing = true;
      controller.text = (widget as ActivityEditEnumerators).enumerator!.name;
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
    Enumerator? enumerator = (widget as ActivityEditEnumerators).enumerator;
    int enumeratorId = editing ? enumerator!.id : HelperEnumerator.enumerators.length;
    enumerator = Enumerator(id: enumeratorId, name: controller.text, counters: enumerator != null ? enumerator.counters : []);
    return enumerator;
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
