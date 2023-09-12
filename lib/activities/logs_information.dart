// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityLogsInformation extends StatelessWidget {
  const ActivityLogsInformation({
    Key? key,
  }) : super(key: key);

  Widget _buildInterfaceFunctions() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_1'),
        icon: "assets/graphics/icons/plus.svg",
      ),
      WidgetTitleInfoIcon(
        text: tr('logbook_info_4'),
        icon: "assets/graphics/icons/view_semi_compact.svg",
      ),
      WidgetTitleInfoIcon(
        text: tr('date_of_record'),
        icon: "assets/graphics/icons/sort_date.svg",
      ),
    ]);
  }

  Widget _buildTrophyLodge() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_6'),
        icon: "assets/graphics/icons/trophy_lodge.svg",
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr('logbook_info_6_1'),
          )),
    ]);
  }

  Widget _buildEdit() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_7'),
        icon: "assets/graphics/icons/edit.svg",
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr('logbook_info_7_1'),
          )),
    ]);
  }

  Widget _buildDelete() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_5'),
        icon: "assets/graphics/icons/remove_bin.svg",
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr('logbook_info_5_1'),
          )),
    ]);
  }

  Widget _buildSearch() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_2'),
        icon: "assets/graphics/icons/search.svg",
      ),
      WidgetTitleInfoIcon(
        text: tr('logbook_info_0'),
        icon: "assets/graphics/icons/separator.svg",
      ),
    ]);
  }

  Widget _buildImportExport() {
    return Column(children: [
      WidgetTitleInfoIcon(
        text: tr('logbook_info_8'),
        icon: "assets/graphics/icons/export.svg",
      ),
      WidgetTitleInfoIcon(
        text: tr('logbook_info_8_1'),
        icon: "assets/graphics/icons/import.svg",
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
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('help'),
          context: context,
        ),
        body: Column(children: [
          _buildSearch(),
          _buildInterfaceFunctions(),
          _buildTrophyLodge(),
          _buildEdit(),
          _buildDelete(),
          _buildImportExport(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
