// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/text_field_indicator.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

abstract class ActivityEdit extends StatefulWidget {
  final Function callback;

  const ActivityEdit({
    Key? key,
    required this.callback,
  }) : super(key: key);
}

abstract class ActivityEditState extends State<ActivityEdit> {
  final TextEditingController controller = TextEditingController();
  final RegExp nameRegex = RegExp(r'^(\p{L}|[\d_\- ]){1,30}$', unicode: true);
  final double addButtonSize = 60;
  final double safeSpaceHeight = 100;

  late ScaffoldMessengerState scaffoldMessengerState;

  bool editing = false;
  bool correctName = false;
  String errorMessage = "";

  @override
  void initState() {
    controller.addListener(() => reload());
    getData();
    super.initState();
  }

  @override
  void dispose() {
    scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void getData();

  void reload() {
    setState(() {
      correctName = nameRegex.hasMatch(controller.text);
    });
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void checkData();

  Widget buildName() {
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr("name"),
        ),
        WidgetTextFieldIndicator(
          numberOnly: false,
          correct: correctName,
          controller: controller,
        ),
      ],
    );
  }

  void addOrEdit();

  Widget _buildAdd() {
    return Positioned(
        bottom: 30,
        right: 30,
        child: SimpleShadow(
            sigma: 7,
            color: Interface.alwaysDark,
            child: WidgetButtonIcon(
              buttonSize: addButtonSize,
              icon: editing ? "assets/graphics/icons/edit.svg" : "assets/graphics/icons/plus.svg",
              onTap: () {
                focus();
                checkData();
                if (errorMessage.isEmpty) {
                  addOrEdit();
                  widget.callback();
                  Navigator.pop(context);
                } else {
                  Utils.buildSnackBarMessage(
                    errorMessage,
                    Process.error,
                    context,
                  );
                }
              },
            )));
  }

  Widget buildBody();

  Widget _buildStack() {
    return Stack(fit: StackFit.expand, children: [
      WidgetScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetAppBar(
                text: editing ? tr("edit") : tr("add"),
                context: context,
              ),
              buildBody(),
              SizedBox(
                height: safeSpaceHeight,
              ),
            ],
          ),
        ),
      ),
      _buildAdd(),
    ]);
  }

  Widget _buildWidgets() {
    reload();
    scaffoldMessengerState = ScaffoldMessenger.of(context);
    return WidgetScaffold(
      customBody: true,
      body: _buildStack(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
