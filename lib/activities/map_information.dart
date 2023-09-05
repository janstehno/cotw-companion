// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityMapInformation extends StatelessWidget {
  const ActivityMapInformation({
    Key? key,
  }) : super(key: key);

  Widget _buildFullscreen() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('interface'),
        icon: "assets/graphics/icons/fullscreen.svg",
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr('map_info_0_1'),
          )),
    ]);
  }

  Widget _buildZoom() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('zoom'),
        icon: "assets/graphics/icons/weapon_expansion.svg",
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
    ]);
  }

  Widget _buildShowCircles() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('map_info_3'),
        icon: "assets/graphics/icons/other.svg",
      ),
    ]);
  }

  Widget _buildShowZoneType() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('map_info_2'),
        icon: "assets/graphics/icons/zone_feed.svg",
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr('map_info_2_1'),
          )),
    ]);
  }

  Widget _buildMinMax() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('map_info_4'),
        icon: "assets/graphics/icons/min_max.svg",
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
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('help'),
          context: context,
        ),
        body: Column(children: [
          _buildFullscreen(),
          _buildZoom(),
          _buildShowCircles(),
          _buildShowZoneType(),
          _buildMinMax(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
