// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetPatchNote extends StatelessWidget {
  final String version;
  final Color background;
  final List<String> changes;

  const WidgetPatchNote({
    Key? key,
    required this.version,
    required this.background,
    this.changes = const [],
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        color: background,
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: changes.isNotEmpty ? 15 : 0),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                AutoSizeText(
                  version,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Interface.s20w600c(Interface.dark),
                ),
                AutoSizeText(
                  changes.isNotEmpty
                      ? version == "1.0.0"
                          ? "Release"
                          : "Update"
                      : "Hotfix",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Interface.s12w300n(Interface.disabled),
                )
              ])),
          changes.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: changes.length,
                  itemBuilder: (context, index) {
                    return Container(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          changes.elementAt(index),
                          style: Interface.s16w300n(Interface.dark),
                        ));
                  })
              : const SizedBox.shrink()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
