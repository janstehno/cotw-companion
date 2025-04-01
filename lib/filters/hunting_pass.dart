import 'package:collection/collection.dart';
import 'package:cotwcompanion/filters/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/model/exportable/hunting_pass.dart';

class FilterHuntingPass extends Filter<HuntingPass> {
  final List<Dlc> reserveDlcs = HelperJSON.getDlcs(DlcType.reserve).sorted(Dlc.sortById);
  final List<Dlc> weaponDlcs = HelperJSON.getDlcs(DlcType.weapon).sorted(Dlc.sortById);

  @override
  Map<FilterKey, int> get defaultFilters => {
        FilterKey.huntingPassGeneral: 0x7FF,
        FilterKey.huntingPassWeapons: 0xF,
        FilterKey.huntingPassReserveDlcs: (1 << reserveDlcs.length) - 1,
        FilterKey.huntingPassWeaponDlcs: (1 << weaponDlcs.length) - 1,
      };

  @override
  void toggle(FilterKey key, int bit) {
    super.toggle(key, bit);
    if (!allowedWeapons) {
      disable(FilterKey.huntingPassGeneral, HuntingPassOption.randomAmmo.index);
      disable(FilterKey.huntingPassGeneral, HuntingPassOption.randomDistance.index);
      disable(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedScopes.index);
    }
  }

  bool get allowedReserves => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomReserve.index);

  bool get allowedAnimals => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAnimal.index);

  bool get allowedWeapons => WeaponType.values.any((t) => isEnabled(FilterKey.huntingPassWeapons, t.index));

  bool get allowedAmmo => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAmmo.index);

  bool get allowedDistance => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomDistance.index);

  bool get allowedDog => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedDog.index);

  bool get allowedCallers => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedCallers.index);

  bool get allowedScopes => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedScopes.index);

  bool get allowedStructures =>
      isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedStructures.index);

  bool get allowedFastTravel =>
      isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedFastTravel.index);

  bool get allowedAtv => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedAtv.index);

  bool get allowedDayTime => isEnabled(FilterKey.huntingPassGeneral, HuntingPassOption.randomAllowedDayTime.index);
}
