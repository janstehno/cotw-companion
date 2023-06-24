// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/text_icon.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityLogsInformation extends StatelessWidget {
  const ActivityLogsInformation({
    Key? key,
  }) : super(key: key);

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(appBar: WidgetAppBar(text: tr('help'), fontSize: Interface.s30, context: context), children: [
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_1'),
          icon: "assets/graphics/icons/plus.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_4'),
          icon: "assets/graphics/icons/view_semi_compact.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('date_of_record'),
          icon: "assets/graphics/icons/sort_date.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_6'),
          icon: "assets/graphics/icons/trophy_lodge.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: WidgetRichText(
              text: tr('logbook_info_6_1'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_7'),
          icon: "assets/graphics/icons/edit.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: WidgetRichText(
              text: tr('logbook_info_7_1'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_5'),
          icon: "assets/graphics/icons/remove_bin.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: WidgetRichText(
              text: tr('logbook_info_5_1'),
            )),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_2'),
          icon: "assets/graphics/icons/search.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_0'),
          icon: "assets/graphics/icons/separator.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_1')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_2')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_3')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_4')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_5')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_2_6')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: WidgetRichText(text: tr('logbook_info_2_7')),
        ),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_3'),
          icon: "assets/graphics/icons/sort_date.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_3_1'),
          icon: "assets/graphics/icons/trophy_gold.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_3_2'),
          icon: "assets/graphics/icons/sort_az.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(text: tr('logbook_info_3_3')),
        ),
      ]),
      Column(children: [
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_8'),
          icon: "assets/graphics/icons/export.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        WidgetTextIcon(
          height: 65,
          iconSize: 20,
          text: tr('logbook_info_8_1'),
          icon: "assets/graphics/icons/import.svg",
          color: Interface.title,
          background: Interface.subTitleBackground,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_8_2')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(text: tr('logbook_info_8_3')),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: WidgetRichText(text: tr('logbook_info_8_4')),
        ),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
