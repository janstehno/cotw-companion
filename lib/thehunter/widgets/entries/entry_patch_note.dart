// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:flutter/material.dart';

class EntryPatchNote extends StatelessWidget {
  final String version;
  final int color;
  final List<String> changes;

  const EntryPatchNote({Key? key, required this.version, required this.color, this.changes = const []}) : super(key: key);

  Widget _buildWidgets() {
    int textColor = version == "1.0.0" || version == "1.3.0" || version == "1.4.6" ? Values.colorAccent : Values.colorDark;
    return Container(
        color: Color(color),
        child: WidgetContainer(
            child: Column(children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child:
                        AutoSizeText(version, style: TextStyle(color: Color(textColor), fontSize: Values.fontSize24, fontWeight: FontWeight.w800))),
                Container(
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                        changes.isNotEmpty
                            ? version == "1.0.0"
                                ? "Release"
                                : "Update"
                            : "Hotfix",
                        style: TextStyle(color: Color(textColor), fontSize: Values.fontSize16, fontWeight: FontWeight.w800))),
              ]),
              Container(
                  margin: EdgeInsets.only(top: changes.isNotEmpty ? 10 : 0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: changes.length,
                      itemBuilder: (context, index) {
                        return Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(changes[index],
                                style: TextStyle(
                                    color: Color(textColor), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)));
                      }))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
