import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/let.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class FilterAnimals extends Filter<Animal> {
  @override
  Map<FilterKey, int> get defaultFilters => {
        FilterKey.animalClass: 0x1FF,
        FilterKey.animalDifficulty: 0x7,
        FilterKey.animalTaxonomy: 0x0,
        FilterKey.animalGreatOne: 0x0,
      };

  @override
  Map<FilterKey, FilterOperation> get defaultOperations => {
        FilterKey.animalTaxonomy: FilterOperation.or,
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
        final matchAnimalTaxonomy = List.generate(AnimalTaxonomy.values.length, (l) => l)
            .where((l) => isEnabled(FilterKey.animalTaxonomy, l))
            .let(
              (activeFilters) =>
                  activeFilters.isEmpty ||
                  isEligible(
                    FilterKey.animalTaxonomy,
                    activeFilters.map((l) => animal.taxonomy.contains(l)).toList(),
                  ),
            );
        final matchAnimalGreatOne = !isEnabled(FilterKey.animalGreatOne, AnimalOther.greatOne.index) ||
            (isEnabled(FilterKey.animalGreatOne, AnimalOther.greatOne.index) && animal.hasGO);

        return matchSearch && matchAnimalClass && matchAnimalDifficulty && matchAnimalTaxonomy && matchAnimalGreatOne;
      }).toList();
    }

    return animals.sorted(Animal.sortByNameByLocale(context!));
  }
}
