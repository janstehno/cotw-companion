import 'package:cotwcompanion/activities/modify/add/enumerators.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/material.dart';

class ActivityEditEnumerators extends ActivityAddEnumerators {
  final Enumerator _enumerator;

  const ActivityEditEnumerators(
    Enumerator enumerator, {
    super.key,
    required super.helperEnumerator,
    required super.onSuccess,
  })  : _enumerator = enumerator,
        super(type: ModifyType.edit);

  Enumerator get enumerator => _enumerator;

  @override
  State<StatefulWidget> createState() => ActivityEditEnumeratorsState();
}

class ActivityEditEnumeratorsState extends ActivityAddEnumeratorsState {
  late final Enumerator _enumerator;

  @override
  void initState() {
    _enumerator = (widget as ActivityEditEnumerators).enumerator;
    textController.text = _enumerator.name;
    errorMessage = "";
    super.initState();
  }

  @override
  void onSuccess() {
    _enumerator.setName(textController.text);
    (widget as ActivityEditEnumerators).helperEnumerator.save();
  }
}
