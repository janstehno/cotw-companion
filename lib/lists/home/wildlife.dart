// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/home/items.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/entries/animal.dart';
import 'package:cotwcompanion/widgets/filters/picker_auto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWildlife extends ListItems {
  const ListWildlife({
    super.key,
  }) : super(name: "wildlife");

  @override
  ListWildlifeState createState() => ListWildlifeState();
}

class ListWildlifeState extends ListItemsState {
  @override
  void filter() {
    setState(() {
      items.clear();
      items.addAll(HelperFilter.filterAnimals(controller.text, context));
    });
  }

  @override
  bool isFilterChanged() => HelperFilter.animalFiltersChanged();

  @override
  List<Widget> buildFilters() {
    return [
      FilterPickerAuto(
        text: tr("animal_class"),
        icon: "assets/graphics/icons/level.svg",
        filterKey: FilterKey.animalsClass,
      ),
      FilterPickerAuto(
        text: tr("animal_difficulty"),
        icon: "assets/graphics/icons/stats.svg",
        filterKey: FilterKey.animalsDifficulty,
      ),
    ];
  }

  @override
  EntryAnimal buildItemEntry(int index) {
    return EntryAnimal(
      index: index,
      animal: items.elementAt(index),
      callback: focus,
    );
  }
}
