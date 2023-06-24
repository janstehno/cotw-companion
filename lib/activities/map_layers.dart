// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/title_functional.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/switch.dart';
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
          WidgetSwitch.withIcon(
            buttonSize: 50,
            activeIcon: "assets/graphics/icons/outpost.svg",
            inactiveIcon: "assets/graphics/icons/outpost.svg",
            activeColor: Interface.light,
            inactiveColor: Interface.disabled,
            activeBackground: HelperMap.getColorE(0),
            inactiveBackground: Interface.disabled.withOpacity(0.3),
            isActive: HelperMap.isActiveE(0),
            onTap: () {
              setState(() {
                HelperMap.activateE(0);
                widget.callback();
              });
            },
          ),
          WidgetSwitch.withIcon(
            buttonSize: 50,
            activeIcon: "assets/graphics/icons/lookout.svg",
            inactiveIcon: "assets/graphics/icons/lookout.svg",
            activeColor: Interface.light,
            inactiveColor: Interface.disabled,
            activeBackground: HelperMap.getColorE(1),
            inactiveBackground: Interface.disabled.withOpacity(0.3),
            isActive: HelperMap.isActiveE(1),
            onTap: () {
              setState(() {
                HelperMap.activateE(1);
                widget.callback();
              });
            },
          ),
          WidgetSwitch.withIcon(
            buttonSize: 50,
            activeIcon: "assets/graphics/icons/hide.svg",
            inactiveIcon: "assets/graphics/icons/hide.svg",
            activeColor: Interface.light,
            inactiveColor: Interface.disabled,
            activeBackground: HelperMap.getColorE(2),
            inactiveBackground: Interface.disabled.withOpacity(0.3),
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
      WidgetTitleFunctional.withSwitch(
        text: tr('wildlife'),
        icon: "assets/graphics/icons/empty.svg",
        inactiveIcon: "assets/graphics/icons/full.svg",
        textColor: Interface.title,
        background: Interface.subTitleBackground,
        iconColor: Interface.light,
        iconInactiveColor: Interface.disabled,
        buttonBackground: Interface.dark,
        buttonInactiveBackground: Interface.disabled.withOpacity(0.3),
        isTitle: true,
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
            return WidgetTitleFunctional(
              text: HelperMap.getName(index),
              textColor: Interface.dark,
              background: index % 2 == 0 ? Interface.even : Interface.odd,
              buttonBackground: HelperMap.getColor(index),
              buttonInactiveBackground: Interface.disabled.withOpacity(0.3),
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
          maxLines: 2,
          color: Interface.accent,
          background: Interface.primary,
          fontSize: Interface.s26,
          context: context,
        ),
        children: [
          _buildEnvironment(),
          _buildList(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
