// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityHelp extends StatelessWidget {
  const ActivityHelp({
    Key? key,
  }) : super(key: key);

  Widget buildAdd() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/plus.svg",
      text: tr("help_add"),
    );
  }

  Widget buildStats() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/stats.svg",
      text: tr("stats"),
    );
  }

  Widget buildChangeView() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/view_semi_compact.svg",
      text: tr("help_change_view"),
    );
  }

  Widget buildShowDate() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/sort_date.svg",
      text: tr("entry_date"),
    );
  }

  Widget buildChangeValue() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/number.svg",
        text: tr("help_change_value"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: WidgetRichText(
            text: tr("help_add_value"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: WidgetRichText(
            text: tr("help_subtract_value"),
          )),
    ]);
  }

  Widget buildEdit() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/edit.svg",
        text: tr("help_edit"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_edit_swipe_right"),
          )),
    ]);
  }

  Widget buildMove() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/sort.svg",
        text: tr("help_entry_move"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_entry_move_info"),
          )),
    ]);
  }

  Widget buildDeleteDoubleTap() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/remove_bin.svg",
        text: tr("help_remove_all"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_remove_one_double_tap"),
          )),
    ]);
  }

  Widget buildDeleteSwipeLeft() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/remove_bin.svg",
        text: tr("help_remove_all"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_remove_one_swipe_left"),
          )),
    ]);
  }

  Widget buildSearch() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/search.svg",
      text: tr("help_search"),
    );
  }

  Widget buildSeparator() {
    return WidgetTitleInfoIcon(
      icon: "assets/graphics/icons/separator.svg",
      text: tr("help_separator"),
    );
  }

  Widget buildTrophyLodge() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/trophy_lodge.svg",
        text: tr("help_trophy_lodge"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_trophy_lodge_move"),
          )),
    ]);
  }

  Widget buildFullscreen() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/fullscreen.svg",
        text: tr("interface"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_interface"),
          )),
    ]);
  }

  Widget buildZoom() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/repair.svg",
        text: tr("performance_mode"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: WidgetRichText(
            text: tr("help_performance_mode"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(
            text: tr("help_performance_mode_first_zoom"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(
            text: tr("help_performance_mode_second_zoom"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: WidgetRichText(
            text: tr("help_performance_mode_third_zoom"),
          )),
    ]);
  }

  Widget buildShowZoneType() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/zone_feed.svg",
        text: tr("help_need_zone"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_need_zone_info"),
          )),
    ]);
  }

  Widget buildShowCircles() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/other.svg",
        text: tr("help_circles"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: WidgetRichText(
            text: tr("help_circles_info"),
          )),
    ]);
  }

  Widget buildAccuracy() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/min_max.svg",
        text: tr("help_accuracy"),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: WidgetRichText(
            text: tr("help_accuracy_info"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetRichText(
            text: tr("help_accuracy_first_example"),
          )),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: WidgetRichText(
            text: tr("help_accuracy_second_example"),
          )),
    ]);
  }

  Widget buildImportExport() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/export.svg",
        text: tr("file_export"),
      ),
      WidgetTitleInfoIcon(
        icon: "assets/graphics/icons/import.svg",
        text: tr("file_import"),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: WidgetRichText(
          text: tr("help_export"),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: WidgetRichText(
          text: tr("help_import"),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: WidgetRichText(
          text: tr("help_permission"),
        ),
      ),
    ]);
  }

  Widget buildBody() => Container();

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr("help"),
          context: context,
        ),
        body: buildBody());
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
