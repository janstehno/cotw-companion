// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/text_icon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapInformation extends StatelessWidget {
  const ActivityMapInformation({
    Key? key,
  }) : super(key: key);

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(appBar: WidgetAppBar(text: tr('help'), fontSize: Interface.s30, context: context), children: [
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('interface'),
          icon: "assets/graphics/icons/fullscreen.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: WidgetRichText(
              text: tr('map_info_0_1'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('zoom'),
          icon: "assets/graphics/icons/weapon_expansion.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: WidgetRichText(
              text: tr('map_info_1_1'),
            )),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: WidgetRichText(
              text: tr('map_info_1_2'),
            )),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: WidgetRichText(
              text: tr('map_info_1_3'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('map_info_3'),
          icon: "assets/graphics/icons/other.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('map_info_2'),
          icon: "assets/graphics/icons/zone_feed.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: WidgetRichText(
              text: tr('map_info_2_1'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('map_info_4'),
          icon: "assets/graphics/icons/min_max.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: WidgetRichText(
              text: tr('map_info_4_1'),
            )),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: WidgetRichText(
              text: tr('map_info_4_2'),
            )),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: WidgetRichText(
              text: tr('map_info_4_3'),
            )),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
