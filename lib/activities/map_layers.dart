// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/tap_text_indicator.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapLayers extends StatefulWidget {
  final String name;
  final Function callback;

  const ActivityMapLayers({
    Key? key,
    required this.name,
    required this.callback,
  }) : super(key: key);

  @override
  ActivityMapLayersState createState() => ActivityMapLayersState();
}

class ActivityMapLayersState extends State<ActivityMapLayers> {
  Widget _buildEnvironment() {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        alignment: Alignment.center,
        child: Wrap(alignment: WrapAlignment.center, spacing: 15, runSpacing: 15, children: [
          WidgetSwitchIcon(
            buttonSize: 50,
            icon: "assets/graphics/icons/outpost.svg",
            activeColor: Interface.light,
            activeBackground: Interface.dark,
            isActive: HelperMap.isActiveE(0),
            onTap: () {
              setState(() {
                HelperMap.activateE(0);
                widget.callback();
              });
            },
          ),
          WidgetSwitchIcon(
            buttonSize: 50,
            icon: "assets/graphics/icons/lookout.svg",
            activeColor: Interface.light,
            activeBackground: Interface.dark,
            isActive: HelperMap.isActiveE(1),
            onTap: () {
              setState(() {
                HelperMap.activateE(1);
                widget.callback();
              });
            },
          ),
          WidgetSwitchIcon(
            buttonSize: 50,
            icon: "assets/graphics/icons/hide.svg",
            activeColor: Interface.light,
            activeBackground: Interface.dark,
            isActive: HelperMap.isActiveE(2),
            onTap: () {
              setState(() {
                HelperMap.activateE(2);
                widget.callback();
              });
            },
          )
        ]));
  }

  Widget _buildList() {
    return Column(children: [
      WidgetTitleBigSwitch(
        primaryText: tr('wildlife'),
        icon: "assets/graphics/icons/empty.svg",
        activeIcon: "assets/graphics/icons/full.svg",
        activeColor: Interface.light,
        activeBackground: Interface.dark,
        isActive: HelperMap.isEverythingActive(),
        onTap: () {
          setState(() {
            HelperMap.activateAll();
            widget.callback();
          });
        },
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: HelperMap.getNames.length,
          itemBuilder: (context, index) {
            return WidgetTapTextIndicator(
              text: HelperMap.getName(index),
              color: HelperMap.getColor(index),
              background: index % 2 == 0 ? Interface.even : Interface.odd,
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
          maxLines: widget.name.split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildEnvironment(),
          _buildList(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
