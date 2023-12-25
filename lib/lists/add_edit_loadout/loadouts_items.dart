// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/loadouts/loadout_switch.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListLoadoutItems extends StatefulWidget {
  final List<int> selected;
  final Function set;
  final Item type;

  const ListLoadoutItems({
    Key? key,
    required this.selected,
    required this.set,
    required this.type,
  }) : super(key: key);

  @override
  ListLoadoutItemsState createState() => ListLoadoutItemsState();
}

class ListLoadoutItemsState extends State<ListLoadoutItems> {
  final _controller = TextEditingController();
  final List<int> _items = [];
  final List<int> _selectedItems = [];

  @override
  void initState() {
    _controller.addListener(() => _filter());
    _selectedItems.addAll(widget.selected);
    super.initState();
  }

  void _filter() {
    setState(() {
      _items.clear();
      if (widget.type == Item.ammo) {
        _items.addAll(HelperFilter.filterLoadoutAmmo(_controller.text, context));
      } else {
        _items.addAll(HelperFilter.filterLoadoutCallers(_controller.text, context));
      }
    });
  }

  bool _contains(int itemId) {
    for (int index = 0; index < _selectedItems.length; index++) {
      if (_selectedItems[index] == itemId) {
        return true;
      }
    }
    return false;
  }

  void _addOrRemove(int itemId) {
    bool add = true;
    for (int index = 0; index < _selectedItems.length; index++) {
      if (_selectedItems[index] == itemId) {
        _selectedItems.removeAt(index);
        add = false;
        continue;
      }
    }
    if (add) _selectedItems.add(itemId);
  }

  Widget _buildItems() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          int itemId = _items[index];
          String text = widget.type == Item.ammo
              ? HelperJSON.getAmmo(HelperJSON.getWeaponsAmmo(itemId).secondId).getName(context.locale)
              : HelperJSON.getCaller(itemId).getName(context.locale);
          String subText = widget.type == Item.ammo ? HelperJSON.getWeapon(HelperJSON.getWeaponsAmmo(itemId).firstId).getName(context.locale) : "";
          return WidgetLoadoutSwitch(
            index: index,
            primaryText: text,
            secondaryText: subText,
            icon: "assets/graphics/icons/plus.svg",
            color: Interface.alwaysDark,
            background: Interface.green,
            activeIcon: "assets/graphics/icons/minus.svg",
            activeColor: Interface.alwaysDark,
            activeBackground: Interface.red,
            isActive: widget.type == Item.ammo ? _contains(HelperJSON.getWeaponsAmmo(itemId).secondId) : _contains(itemId),
            onTap: () {
              setState(() {
                _addOrRemove(widget.type == Item.ammo ? HelperJSON.getWeaponsAmmo(itemId).secondId : itemId);
                widget.set(widget.type, _selectedItems);
              });
            },
          );
        });
  }

  Widget _buildWidgets() {
    _filter();
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: widget.type == Item.ammo ? tr("weapons") : tr("callers"),
        context: context,
      ),
      searchController: _controller,
      body: _buildItems(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
