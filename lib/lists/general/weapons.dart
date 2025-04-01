import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/activities/filter/weapons.dart';
import 'package:cotwcompanion/filters/weapons.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/lists/general/translatables.dart';
import 'package:cotwcompanion/model/translatable/weapon.dart';
import 'package:cotwcompanion/widgets/parts/weapon/weapon.dart';

class ListWeapons extends ListTranslatable {
  const ListWeapons({
    super.key,
  }) : super("WEAPONS");

  @override
  ListWeaponsState createState() => ListWeaponsState();
}

class ListWeaponsState extends ListTranslatableState<Weapon> {
  @override
  void initState() {
    filter = HelperFilter.filterWeapons;
    super.initState();
  }

  @override
  ActivityFilter<Weapon> get activityFilter => ActivityFilterWeapons(
        filter: filter as FilterWeapons,
        onConfirm: filterItems,
      );

  @override
  List<Weapon> initialItems() {
    return HelperJSON.weapons;
  }

  @override
  WidgetWeapon buildEntry(index, item) {
    return WidgetWeapon(
      item,
      i: index,
      onTap: focus,
    );
  }
}
