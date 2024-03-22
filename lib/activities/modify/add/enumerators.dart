import 'package:cotwcompanion/activities/modify/modify.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:flutter/material.dart';

class ActivityAddEnumerators extends ActivityModify {
  final HelperEnumerator _helperEnumerator;

  const ActivityAddEnumerators({
    super.key,
    super.type = ModifyType.add,
    required HelperEnumerator helperEnumerator,
    required super.onSuccess,
  }) : _helperEnumerator = helperEnumerator;

  HelperEnumerator get helperEnumerator => _helperEnumerator;

  @override
  State<StatefulWidget> createState() => ActivityAddEnumeratorsState();
}

class ActivityAddEnumeratorsState extends ActivityModifyState {
  final TextEditingController textController = TextEditingController();

  late final HelperEnumerator _helperEnumerator;

  @override
  void initState() {
    _helperEnumerator = (widget as ActivityAddEnumerators).helperEnumerator;
    textController.addListener(() => updateIndicatorOf(textController));
    super.initState();
  }

  Enumerator get _newEnumerator {
    return Enumerator(
      order: _helperEnumerator.enumerators.length,
      name: textController.text,
    );
  }

  void onSuccess() {
    _helperEnumerator.save(_newEnumerator);
  }

  @override
  void onConfirm() {
    if (errorMessage.isEmpty) {
      onSuccess();
      widget.onSuccess();
      Navigator.pop(context);
    } else {
      Utils.buildSnackBarMessage(
        errorMessage,
        Process.error,
        context,
      );
    }
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        buildName(correctName, textController),
      ],
    );
  }
}
