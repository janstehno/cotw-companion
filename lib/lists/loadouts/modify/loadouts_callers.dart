import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/filter.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/loadouts/modify/loadouts_items.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/section/section_switch_icon.dart';
import 'package:flutter/material.dart';

class ListLoadoutCallers extends ListLoadoutItems<Caller> {
  const ListLoadoutCallers({
    super.key,
    required super.selected,
    required super.onSelect,
  }) : super("CALLERS");

  @override
  State<StatefulWidget> createState() => ListLoadoutCallersState();
}

class ListLoadoutCallersState extends ListLoadoutItemsState<Caller> {
  @override
  List<Caller> get items => HelperFilter.filterLoadoutCallers(controller.text).sorted(Caller.sortByName);

  @override
  bool contains(Caller item) {
    return selectedItems.contains(item);
  }

  @override
  Widget buildItemSwitch(Caller item) {
    return WidgetSectionSwitchIcon(
      item.name,
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
