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
        icon: "assets/graphics/icons/plus.svg",
        text: tr('logbook_info_1'),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/stats.svg",
        text: tr('stats'),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/view_semi_compact.svg",
        text: tr('logbook_info_4'),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/sort_date.svg",
        text: tr('date_of_record'),
      ),
    ]);
  }

  Widget _buildTrophyLodge() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/trophy_lodge.svg",
        text: tr('logbook_info_6'),
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
        icon: "assets/graphics/icons/edit.svg",
        text: tr('logbook_info_7'),
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
        icon: "assets/graphics/icons/remove_bin.svg",
        text: tr('logbook_info_5'),
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
        icon: "assets/graphics/icons/search.svg",
        text: tr('logbook_info_2'),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/separator.svg",
        text: tr('logbook_info_0'),
      ),
    ]);
  }

  Widget _buildImportExport() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/export.svg",
        text: tr('logbook_info_8'),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/import.svg",
        text: tr('logbook_info_8_1'),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: WidgetRichText(
          text: tr('logbook_info_8_2'),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: WidgetRichText(
          text: tr('logbook_info_8_3'),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: WidgetRichText(
          text: tr('logbook_info_8_4'),
        ),
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
