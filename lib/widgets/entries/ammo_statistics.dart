// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/widgets/entries/statistics.dart';

class EntryAmmoStatistics extends EntryStatistics {
  final Ammo ammo;
  final bool imperialUnits;

  EntryAmmoStatistics({
    super.key,
    required this.ammo,
    required this.imperialUnits,
  }) : super(
          labels: [
            "min_max",
            "weapon_penetration",
            "range",
            "weapon_expansion",
          ],
          values: [
            ammo.classRange,
            ammo.penetration,
            ammo.getRange(imperialUnits),
            ammo.expansion,
          ],
        );
}
