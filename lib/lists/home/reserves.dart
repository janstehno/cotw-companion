// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/entries/reserve.dart';
import 'package:cotwcompanion/widgets/filters/range_auto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserves extends ListItems {
  const ListReserves({
    super.key,
  }) : super(name: "reserves");

  @override
  ListReservesState createState() => ListReservesState();
}

class ListReservesState extends ListItemsState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterReserves(controller.text, context));
    });
  }

  @override
  bool isFilterChanged() => HelperFilter.reserveFiltersChanged();

  @override
  List<Widget> buildFilters() {
    return [
      FilterRangeAuto(
        text: tr("wildlife"),
        icon: "assets/graphics/icons/target.svg",
        filterKeyLower: FilterKey.reservesCountMin,
        filterKeyUpper: FilterKey.reservesCountMax,
      )
    ];
  }

  @override
  EntryReserve buildItemEntry(int index) {
    return EntryReserve(
      index: index,
      reserve: items.elementAt(index),
      callback: focus,
    );
  }
}
