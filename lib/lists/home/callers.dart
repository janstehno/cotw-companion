import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/settings.dart';
import 'package:cotwcompanion/lists/home/translatables.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/parts/caller/caller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCallers extends ListTranslatable {
  const ListCallers({
    super.key,
  }) : super("CALLERS");

  @override
  ListCallersState createState() => ListCallersState();
}

class ListCallersState extends ListTranslatableState<Caller> {
  bool get _imperialUnits => Provider.of<Settings>(context, listen: false).imperialUnits;

  @override
  List<Caller> initialItems() {
    return HelperJSON.callers;
  }

  @override
  List<Caller> filteredItems() {
    return HelperFilter.filterCallers(items, controller.text);
  }

  @override
  bool isFilterChanged() => HelperFilter.callerFiltersChanged();

  @override
  List<Widget> listFilter() {
    return [
      WidgetFilterPickerText(
        FilterKey.callersEffectiveRange,
        text: tr("CALLER_RANGE"),
        icon: Assets.graphics.icons.range,
        labels: _imperialUnits
            ? [
                "164 ${tr("YARDS")}",
                "218 ${tr("YARDS")}",
                "273 ${tr("YARDS")}",
                "546 ${tr("YARDS")}",
              ]
            : [
                "150 ${tr("METERS")}",
                "200 ${tr("METERS")}",
                "250 ${tr("METERS")}",
                "500 ${tr("METERS")}",
              ],
      ),
    ];
  }

  @override
  WidgetCaller buildEntry(index, item) {
    return WidgetCaller(
      item,
      i: index,
      onTap: focus,
    );
  }
}
