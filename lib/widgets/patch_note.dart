// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:flutter/material.dart';

class WidgetPatchNote extends StatelessWidget {
  final String version;
  final Color color;
  final List<String> changes;

  const WidgetPatchNote({
    Key? key,
    required this.version,
    required this.color,
    this.changes = const [],
  }) : super(key: key);

  Widget _buildWidgets() {
    Color textColor, subTextColor;
    if(version == "1.0.0" || version == "1.3.0" || version == "1.4.6"){
      textColor = Interface.accent;
      subTextColor = Interface.accent;
    }else{
      textColor = Interface.dark;
      subTextColor = Interface.disabled;
    }
    return Container(
        color: color,
        child: Column(children: [
          WidgetTitle(
            text: version,
            subText: changes.isNotEmpty
                ? version == "1.0.0"
                    ? "Release"
                    : "Update"
                : "Hotfix",
            textColor: textColor,
            subTextColor: subTextColor,
            background: Colors.transparent,
          ),
          changes.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: changes.length,
                      itemBuilder: (context, index) {
                        return Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(changes[index],
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: Interface.s20,
                                  fontWeight: FontWeight.w400,
                                )));
                      }))
              : Container()
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
