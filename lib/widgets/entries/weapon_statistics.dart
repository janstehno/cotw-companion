// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/weapon.dart';
import 'package:cotwcompanion/widgets/entries/statistics.dart';
import 'package:easy_localization/easy_localization.dart';

class EntryWeaponStatistics extends EntryStatistics {
  final Weapon weapon;

  EntryWeaponStatistics({
    super.key,
    required this.weapon,
  }) : super(
          labels: [
            "weapon_accuracy",
            "weapon_recoil",
            "weapon_reload",
            "weapon_hipshot",
          ],
          values: [
            weapon.accuracy == -1 ? tr("none") : weapon.accuracy,
            weapon.recoil == -1 ? tr("none") : weapon.recoil,
            weapon.reload == -1 ? tr("none") : weapon.reload,
            weapon.hipshot == -1 ? tr("none") : weapon.hipshot,
          ],
        );
}
