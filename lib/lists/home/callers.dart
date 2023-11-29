// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/widgets/entries/caller.dart';
import 'package:cotwcompanion/widgets/filters/picker_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCallers extends ListItems {
  const ListCallers({
    super.key,
  }) : super(name: "callers");

  @override
  ListCallersState createState() => ListCallersState();
}

class ListCallersState extends ListItemsState {
  late final bool _imperials;

  @override
  void initState() {
    _imperials = Provider.of<Settings>(context, listen: false).imperialUnits;
    controller.addListener(() => filter());
    super.initState();
  }

  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterCallers(controller.text, context));
    });
  }

  @override
  bool isFilterChanged() => HelperFilter.callerFiltersChanged();

  @override
  List<Widget> buildFilters() {
    return [
      FilterPickerText(
        text: tr("caller_range"),
        icon: "assets/graphics/icons/range.svg",
        labels: _imperials
            ? [
                "164 ${tr("yards")}",
                "218 ${tr("yards")}",
                "273 ${tr("yards")}",
                "546 ${tr("yards")}",
              ]
            : [
                "150 ${tr("meters")}",
                "200 ${tr("meters")}",
                "250 ${tr("meters")}",
                "500 ${tr("meters")}",
              ],
        filterKey: FilterKey.callersEffectiveRange,
      ),
    ];
  }

  @override
  EntryCaller buildItemEntry(int index) {
    return EntryCaller(
      index: index,
      caller: items.elementAt(index),
      callback: focus,
    );
  }
}
