import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/home/translatables.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/filter/picker_auto.dart';
import 'package:cotwcompanion/widgets/filter/switch.dart';
import 'package:cotwcompanion/widgets/filter/value.dart';
import 'package:cotwcompanion/widgets/parts/weapon/weapon.dart';
import 'package:cotwcompanion/widgets/title/title_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWeapons extends ListTranslatable {
  const ListWeapons({
    super.key,
  }) : super("WEAPONS");

  @override
  ListWeaponsState createState() => ListWeaponsState();
}

class ListWeaponsState extends ListTranslatableState<Weapon> {
  @override
  List<Weapon> initialItems() {
    return HelperJSON.weapons;
  }

  @override
  List<Weapon> filteredItems() {
    return HelperFilter.filterWeapons(items, controller.text);
  }

  @override
  bool isFilterChanged() => HelperFilter.weaponFiltersChanged();

  @override
  List<Widget> listFilter() {
    return [
      WidgetTitleIcon(
        tr("TYPE"),
        icon: Assets.graphics.icons.weapon,
      ),
      WidgetFilterSwitch(
        FilterKey.weaponsRifles,
        text: tr("WEAPONS_RIFLES"),
        i: 0,
      ),
      WidgetFilterSwitch(
        FilterKey.weaponsShotguns,
        text: tr("WEAPONS_SHOTGUNS"),
        i: 1,
      ),
      WidgetFilterSwitch(
        FilterKey.weaponsHandguns,
        text: tr("WEAPONS_HANDGUNS"),
        i: 2,
      ),
      WidgetFilterSwitch(
        FilterKey.weaponsBows,
        text: tr("WEAPONS_BOWS_CROSSBOWS"),
        i: 3,
      ),
      WidgetFilterPickerAuto(
        FilterKey.weaponsAnimalClass,
        text: tr("ANIMAL_CLASS"),
        icon: Assets.graphics.icons.level,
      ),
      WidgetFilterValue(
        FilterKey.weaponsMagMin,
        FilterKey.weaponsMagMax,
        text: tr("WEAPON_MAGAZINE"),
        icon: Assets.graphics.icons.weaponMag,
      ),
    ];
  }

  @override
  WidgetWeapon buildEntry(item) {
    return WidgetWeapon(
      item,
      i: items.indexOf(item),
      onTap: focus,
    );
  }
}
