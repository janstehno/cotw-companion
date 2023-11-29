// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/map.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/tap_text_indicator.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapLayers extends StatefulWidget {
  final Reserve reserve;
  final Function callback;

  const ActivityMapLayers({
    Key? key,
    required this.reserve,
    required this.callback,
  }) : super(key: key);

  @override
  ActivityMapLayersState createState() => ActivityMapLayersState();
}

class ActivityMapLayersState extends State<ActivityMapLayers> {
  final double _wrapSpace = 10;
  final double _structureButtonSize = 50;

  Widget _buildEnvironment() {
    return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: _wrapSpace,
          runSpacing: _wrapSpace,
          children: [
            WidgetSwitchIcon(
              buttonSize: _structureButtonSize,
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
              buttonSize: _structureButtonSize,
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
              buttonSize: _structureButtonSize,
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
          ],
        ));
  }

  Widget _buildList() {
    return Column(children: [
      WidgetTitleBigSwitch(
        primaryText: tr("wildlife"),
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
          itemCount: HelperMap.names.length,
          itemBuilder: (context, index) {
            return WidgetTapTextIndicator(
              text: HelperMap.getName(index),
              color: HelperMap.getColor(index),
              background: Utils.background(index),
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
          text: widget.reserve.getName(context.locale),
          maxLines: widget.reserve.getName(context.locale).split(" ").length > 2 ? 2 : 1,
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
