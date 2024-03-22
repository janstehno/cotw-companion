import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/lists/statistics.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:easy_localization/easy_localization.dart';

class ListWeaponStatistics extends ListStatistics {
  ListWeaponStatistics(
    Weapon weapon, {
    super.key,
  }) : super(
          labels: [
            Assets.graphics.icons.weaponAccuracy,
            Assets.graphics.icons.weaponRecoil,
            Assets.graphics.icons.weaponReload,
            Assets.graphics.icons.weaponHipshot,
          ],
          values: [
            weapon.accuracy == -1 ? tr("NONE") : weapon.accuracy,
            weapon.recoil == -1 ? tr("NONE") : weapon.recoil,
            weapon.reload == -1 ? tr("NONE") : weapon.reload,
            weapon.hipshot == -1 ? tr("NONE") : weapon.hipshot,
          ],
        );
}
