import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/lists/statistics.dart';
import 'package:cotwcompanion/model/translatable/ammo.dart';

class ListAmmoStatistics extends ListStatistics {
  ListAmmoStatistics(
    Ammo ammo, {
    super.key,
    required bool imperialUnits,
  }) : super(
          labels: [
            Assets.graphics.icons.minMax,
            Assets.graphics.icons.weaponPenetration,
            Assets.graphics.icons.range,
            Assets.graphics.icons.weaponExpansion,
          ],
          values: [
            ammo.classRange,
            ammo.penetration,
            ammo.getRange(imperialUnits),
            ammo.expansion,
          ],
        );
}
