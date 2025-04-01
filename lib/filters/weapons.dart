import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:flutter/material.dart';

class FilterWeapons extends Filter<Weapon> {
  @override
  Map<FilterKey, int> get defaultFilters => {
        FilterKey.weaponType: 0xF,
        FilterKey.weaponAnimalClass: 0x1FF,
        FilterKey.weaponMagMin: 1,
        FilterKey.weaponMagMax: 15,
      };

  @override
  Map<FilterKey, FilterOperation> get defaultOperations => {
        FilterKey.weaponAnimalClass: FilterOperation.or,
      };

  @override
  List<Weapon> filter(List<Weapon> originalList, String searchText, [BuildContext? context]) {
    List<Weapon> weapons = List.from(originalList);

    if (searchText.isNotEmpty || isActive()) {
      weapons = originalList.where((weapon) {
        final matchSearch = searchText.isEmpty || weapon.name.toLowerCase().contains(searchText.toLowerCase());
        final matchWeaponType = isEnabled(FilterKey.weaponType, WeaponType.values.indexOf(weapon.type));
        final matchWeaponAnimalClass = isEligible(
          FilterKey.weaponAnimalClass,
          List.generate(9, (l) => l)
              .where((l) => isEnabled(FilterKey.weaponAnimalClass, l))
              .map((l) => isEnabled(FilterKey.weaponAnimalClass, l) && weapon.levels.contains(l + 1))
              .toList(),
        );
        final matchWeaponMagMin = weapon.mag >= valueOf(FilterKey.weaponMagMin);
        final matchWeaponMagMax = weapon.mag <= valueOf(FilterKey.weaponMagMax);

        return matchSearch && matchWeaponType && matchWeaponAnimalClass && matchWeaponMagMin && matchWeaponMagMax;
      }).toList();
    }

    return weapons.sorted(Weapon.sortByTypeName);
  }
}
