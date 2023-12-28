// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/edit/edit.dart';
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
  late final Enumerator? _enumerator;

  @override
  void initState() {
    _enumerator = (widget as ActivityEditEnumerators).enumerator;
    super.initState();
  }

  @override
  void getData() {
    if (_enumerator != null) {
      //WHEN EDITING
      editing = true;
      controller.text = HelperEnumerator.getEnumerator(_enumerator!.id).name;
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
    return Enumerator(
      id: editing ? _enumerator!.id : HelperEnumerator.enumerators.length,
      name: controller.text,
      counters: _enumerator != null ? HelperEnumerator.getEnumerator(_enumerator!.id).counters : [],
    );
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
