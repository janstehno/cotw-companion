// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String code;
  final String error;
  final String stack;

  const WidgetError({
    Key? key,
    required this.code,
    required this.error,
    this.stack = "",
  }) : super(key: key);

  Widget _buildWidgets() {
    return WidgetScaffold(
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
                      "Error has occurred. Please restart the application. Don't forget to contact me about any problems.",
                      textAlign: TextAlign.start,
                      style: Interface.s14w500n(Interface.dark),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: AutoSizeText(
                        "\n$code",
                        textAlign: TextAlign.start,
                        style: Interface.s14w500n(Interface.dark),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          error,
                          textAlign: TextAlign.start,
                          style: Interface.s14w300n(Interface.dark),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: AutoSizeText(
                        "\nStack",
                        textAlign: TextAlign.start,
                        style: Interface.s14w500n(Interface.dark),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          stack,
                          textAlign: TextAlign.start,
                          style: Interface.s14w300n(Interface.dark),
                        )),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
