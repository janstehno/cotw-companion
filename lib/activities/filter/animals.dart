import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/animals.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/button/switch_operation.dart';
import 'package:cotwcompanion/widgets/filter/picker_auto.dart';
import 'package:cotwcompanion/widgets/filter/picker_text.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:cotwcompanion/widgets/title/title_icon_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilterAnimals extends ActivityFilter<Animal> {
  const ActivityFilterAnimals({
    super.key,
    required FilterAnimals super.filter,
    required super.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => ActivityFilterAnimalsState();
}

class ActivityFilterAnimalsState extends ActivityFilterState<Animal> {
  List<Widget> _listAnimalClass() {
    return [
      WidgetTitleIcon(
        tr("ANIMAL_CLASS"),
        icon: Assets.graphics.icons.level,
      ),
      WidgetFilterPickerAuto(
        filter: widget.filter,
        filterKey: FilterKey.animalClass,
        bitKeys: List.generate(9, (i) => i + 1),
      ),
    ];
  }

  List<Widget> _listAnimalDifficulty() {
    return [
      WidgetTitleIcon(
        tr("ANIMAL_DIFFICULTY"),
        icon: Assets.graphics.icons.stats,
      ),
      WidgetFilterPickerAuto(
        filter: widget.filter,
        filterKey: FilterKey.animalDifficulty,
        bitKeys: [3, 5, 9],
      ),
    ];
  }

  List<Widget> _listAnimalTaxonomy() {
    return [
      WidgetTitleIconSwitch(
        tr("ANIMAL_TAXONOMY"),
        icon: Assets.graphics.icons.taxonomy,
        switchButton: WidgetSwitchFilterOperation(
          onTap: () => super.switchOperation(FilterKey.animalTaxonomy),
          operation: widget.filter.operationOf(FilterKey.animalTaxonomy),
        ),
      ),
      WidgetFilterPickerText(
        filter: widget.filter,
        filterKey: FilterKey.animalTaxonomy,
        bitKeys: AnimalTaxonomy.values.sorted((a, b) => tr(a.key).compareTo(tr(b.key))),
        labels: AnimalTaxonomy.values.sorted((a, b) => tr(a.key).compareTo(tr(b.key))).map((e) => tr(e.key)).toList(),
      ),
    ];
  }

  List<Widget> _listAnimalGreatOne() {
    return [
      WidgetTitleIcon(
        tr("OTHER"),
        icon: Assets.graphics.icons.other,
      ),
      WidgetFilterPickerText(
        filter: widget.filter,
        filterKey: FilterKey.animalGreatOne,
        bitKeys: AnimalOther.values,
        labels: [
          tr("FUR:GREAT_ONE"),
        ],
      ),
    ];
  }

  @override
  List<Widget> get filters => [
        ..._listAnimalClass(),
        ..._listAnimalDifficulty(),
        ..._listAnimalTaxonomy(),
        ..._listAnimalGreatOne(),
      ];
}
