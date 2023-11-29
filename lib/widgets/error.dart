// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String code;
  final String text;
  final BuildContext context;

  const WidgetError({
    Key? key,
    required this.code,
    required this.text,
    required this.context,
  }) : super(key: key);

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(context: context),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                color: Interface.body,
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Error has occurred. Please restart the application. Don't forget to contact me about any problems. Details:",
                      textAlign: TextAlign.start,
                      style: Interface.s16w300n(Interface.dark),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: AutoSizeText(
                          "$code\n$text",
                          textAlign: TextAlign.start,
                          style: Interface.s16w300n(Interface.dark),
                        )),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
