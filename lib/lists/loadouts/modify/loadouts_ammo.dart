import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/loadouts/modify/loadouts_items.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/connect/weapon_ammo.dart';
import 'package:cotwcompanion/widgets/section/section_switch_icon.dart';
import 'package:flutter/material.dart';

class ListLoadoutAmmo extends ListLoadoutItems<WeaponAmmo> {
  const ListLoadoutAmmo({
    super.key,
    required super.selected,
    required super.onSelect,
  }) : super("WEAPON_AMMO");

  @override
  State<StatefulWidget> createState() => ListLoadoutAmmoState();
}

class ListLoadoutAmmoState extends ListLoadoutItemsState<WeaponAmmo> {
  @override
  List<WeaponAmmo> get items => HelperFilter.filterLoadoutAmmo(controller.text).sorted(WeaponAmmo.sortByWeaponName);

  @override
  bool contains(WeaponAmmo item) {
    return selectedItems.where((e) => e.ammoId == item.ammoId).isNotEmpty;
  }

  @override
  Widget buildItemSwitch(WeaponAmmo item) {
    return WidgetSectionSwitchIcon(
      HelperJSON.getAmmo(item.ammoId)!.name,
      subtext: HelperJSON.getWeapon(item.weaponId)!.name,
      icon: Assets.graphics.icons.plus,
      buttonColor: Interface.alwaysDark,
      buttonBackground: Interface.green,
      activeIcon: Assets.graphics.icons.minus,
      activeButtonColor: Interface.alwaysDark,
      activeButtonBackground: Interface.red,
      background: Utils.backgroundAt(items.indexOf(item)),
      alignRight: true,
      isActive: contains(item),
      onTap: () {
        setState(() {
          addOrRemove(item);
          widget.set(selectedItems);
        });
      },
    );
  }
}
