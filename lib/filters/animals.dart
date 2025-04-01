import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class FilterAnimals extends Filter<Animal> {
  @override
  Map<FilterKey, int> get defaultFilters => {
        FilterKey.animalClass: 0x1FF,
        FilterKey.animalDifficulty: 0x7,
      };

  @override
  List<Animal> filter(List<Animal> originalList, String searchText, [BuildContext? context]) {
    assert(context != null);

    List<Animal> animals = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      animals = originalList.where((animal) {
        final matchSearch = searchText.isEmpty ||
            animal.getNameByLocale(context!.locale).toLowerCase().contains(searchText.toLowerCase());
        final matchAnimalClass = isEnabled(FilterKey.animalClass, animal.level - 1);
        final matchAnimalDifficulty = isEnabled(FilterKey.animalDifficulty, [3, 5, 9].indexOf(animal.difficulty));

        return matchSearch && matchAnimalClass && matchAnimalDifficulty;
      }).toList();
    }

    return animals.sorted(Animal.sortByNameByLocale(context!));
  }
}
