import 'package:cotwcompanion/activities/modify/modify.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/enumerator.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/exportable/enumerator.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityAddCounters extends ActivityModify {
  final HelperEnumerator _helperEnumerator;
  final Enumerator _enumerator;

  const ActivityAddCounters({
    super.key,
    super.type = ModifyType.add,
    required HelperEnumerator helperEnumerator,
    required Enumerator enumerator,
    required super.onSuccess,
  })  : _helperEnumerator = helperEnumerator,
        _enumerator = enumerator;

  Enumerator get enumerator => _enumerator;

  HelperEnumerator get helperEnumerator => _helperEnumerator;

  @override
  State<StatefulWidget> createState() => ActivityAddCountersState();
}

class ActivityAddCountersState extends ActivityModifyState {
  final TextEditingController textController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() => updateIndicatorOf(textController));
    super.initState();
  }

  Widget buildValue() {
    return Column(
      children: [
        WidgetTitle(tr("COUNT")),
        WidgetTextFieldIndicator(
          icon: Assets.graphics.icons.number,
          numberOnly: true,
          decimal: false,
          noIndicator: true,
          textController: valueController,
        )
      ],
    );
  }

  Counter get _newCounter {
    return Counter(
      order: (widget as ActivityAddCounters).enumerator.counters.length,
      name: textController.text,
      value: int.tryParse(valueController.text) ?? 0,
    );
  }

  void onSuccess() {
    (widget as ActivityAddCounters).enumerator.addCounter(_newCounter);
    (widget as ActivityAddCounters).helperEnumerator.save();
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
        buildValue(),
      ],
    );
  }
}
