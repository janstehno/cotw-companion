// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_map.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_switch.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapLayers extends StatefulWidget {
  final String name;
  final Function callback;

  const ActivityMapLayers({Key? key, required this.name, required this.callback}) : super(key: key);

  @override
  ActivityMapLayersState createState() => ActivityMapLayersState();
}

class ActivityMapLayersState extends State<ActivityMapLayers> {
  Widget _buildEnvironment() {
    return WidgetContainer(
        alignment: Alignment.center,
        child: Wrap(alignment: WrapAlignment.center, spacing: 15, runSpacing: 15, children: [
          WidgetSwitch(
            size: 50,
            icon: "assets/graphics/icons/outpost.svg",
            activeColor: Values.colorLight,
            activeBackground: HelperMap.getColorE(0),
            isActive: HelperMap.isActiveE(0),
            onTap: () {
              setState(() {
                HelperMap.activateE(0);
                widget.callback();
              });
            },
          ),
          WidgetSwitch(
            size: 50,
            icon: "assets/graphics/icons/lookout.svg",
            activeColor: Values.colorLight,
            activeBackground: HelperMap.getColorE(1),
            isActive: HelperMap.isActiveE(1),
            onTap: () {
              setState(() {
                HelperMap.activateE(1);
                widget.callback();
              });
            },
          ),
          WidgetSwitch(
            size: 50,
            icon: "assets/graphics/icons/hide.svg",
            activeColor: Values.colorLight,
            activeBackground: HelperMap.getColorE(2),
            isActive: HelperMap.isActiveE(2),
            onTap: () {
              setState(() {
                HelperMap.activateE(2);
                widget.callback();
              });
            },
          ),
          WidgetSwitch(
            size: 50,
            icon: "assets/graphics/icons/environment_fields.svg",
            activeColor: Values.colorAlwaysDark,
            activeBackground: HelperMap.getColorE(3),
            isActive: HelperMap.isActiveE(3),
            onTap: () {
              setState(() {
                HelperMap.activateE(3);
                widget.callback();
              });
            },
          )
        ]));
  }

  Widget _buildList() {
    return Column(children: [
      WidgetTitle.sub(text: tr('wildlife')),
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: HelperMap.getNames.length,
          itemBuilder: (context, index) {
            return EntryName.withSwitch(
              size: 40,
              text: HelperMap.getName(index),
              buttonActiveBackground: HelperMap.getColor(index),
              isActive: HelperMap.isActive(index),
              onTap: () {
                setState(() {
                  HelperMap.activate(index);
                  widget.callback();
                });
              },
            );
          })
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.name,
          maxLines: 1,
          height: 90,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          fontWeight: FontWeight.w700,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildEnvironment(), _buildList()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
