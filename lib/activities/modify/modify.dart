import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/text/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityModify extends StatefulWidget {
  final ModifyType _type;
  final Function _onSuccess;

  const ActivityModify({
    super.key,
    required ModifyType type,
    required Function onSuccess,
  })  : _type = type,
        _onSuccess = onSuccess;

  ModifyType get type => _type;

  Function get onSuccess => _onSuccess;
}

abstract class ActivityModifyState extends State<ActivityModify> {
  final RegExp rxName = RegExp(r'^([^ ](?:\p{L}|[\d_\- ]){1,28}[^ ])$', unicode: true);
  late ScaffoldMessengerState _scaffoldMessengerState;

  String errorMessage = tr("ERROR_NO_NAME");

  bool get correctName => errorMessage.isEmpty;

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void updateIndicatorOf(TextEditingController textController) {
    setState(() {
      if (textController.text.isEmpty) {
        errorMessage = tr("ERROR_NO_NAME");
      } else if (!rxName.hasMatch(textController.text)) {
        errorMessage = tr("ERROR_WRONG_NAME");
      } else {
        errorMessage = "";
      }
    });
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void onConfirm();

  Widget buildName(bool correctName, TextEditingController textController) {
    return Column(
      children: [
        WidgetTitle(tr("NAME")),
        WidgetTextFieldIndicator(
          icon: Assets.graphics.icons.edit,
          length: 30,
          numberOnly: false,
          correct: correctName,
          textController: textController,
        ),
      ],
    );
  }

  Widget buildBody();

  Widget _buildConfirm() {
    return WidgetTitleTap(
      tr(widget.type.name.toUpperCase()),
      content: WidgetIcon(
        Assets.graphics.icons.accept,
        color: Interface.dark,
      ),
      onTap: () => onConfirm(),
    );
  }

  Widget _buildStack() {
    return Container(
      color: Interface.body,
      child: Stack(
        fit: StackFit.expand,
        children: [
          WidgetScrollBar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WidgetAppBar(
                    tr(widget.type.name.toUpperCase()),
                    context: context,
                  ),
                  buildBody(),
                  _buildConfirm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildStack(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
