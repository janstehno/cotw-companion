import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/lists/home/translatables.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/filter/picker_auto.dart';
import 'package:cotwcompanion/widgets/parts/animal/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWildlife extends ListTranslatable {
  const ListWildlife({
    super.key,
  }) : super("WILDLIFE");

  @override
  ListWildlifeState createState() => ListWildlifeState();
}

class ListWildlifeState extends ListTranslatableState<Animal> {
  @override
  List<Animal> get items => HelperFilter.filterAnimals(controller.text, context);

  @override
  bool isFilterChanged() => HelperFilter.animalFiltersChanged();

  @override
  List<Widget> listFilter() {
    return [
      WidgetFilterPickerAuto(
        FilterKey.animalsClass,
        text: tr("ANIMAL_CLASS"),
        icon: Assets.graphics.icons.level,
      ),
      WidgetFilterPickerAuto(
        FilterKey.animalsDifficulty,
        text: tr("ANIMAL_DIFFICULTY"),
        icon: Assets.graphics.icons.stats,
      ),
    ];
  }

  @override
  WidgetAnimal buildEntry(item) {
    return WidgetAnimal(
      item,
      i: items.indexOf(item),
      onTap: focus,
    );
  }
}
