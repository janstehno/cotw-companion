import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/home/translatables.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/filter/value.dart';
import 'package:cotwcompanion/widgets/parts/reserve/reserve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserves extends ListTranslatable {
  const ListReserves({
    super.key,
  }) : super("RESERVES");

  @override
  ListReservesState createState() => ListReservesState();
}

class ListReservesState extends ListTranslatableState<Reserve> {
  @override
  List<Reserve> initialItems() {
    return HelperJSON.reserves;
  }

  @override
  List<Reserve> filteredItems() {
    return HelperFilter.filterReserves(items, controller.text);
  }

  @override
  bool isFilterChanged() => HelperFilter.reserveFiltersChanged();

  @override
  List<Widget> listFilter() {
    return [
      WidgetFilterValue(
        FilterKey.reservesCountMin,
        FilterKey.reservesCountMax,
        text: tr("WILDLIFE"),
        icon: Assets.graphics.icons.target,
      )
    ];
  }

  @override
  WidgetReserve buildEntry(index, item) {
    return WidgetReserve(
      item,
      i: index,
      onTap: focus,
    );
  }
}
