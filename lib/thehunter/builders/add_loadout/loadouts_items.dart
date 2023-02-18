// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_filter.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_types.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_name_with.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold_advanced.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_searchbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderAddLoadoutItems extends StatefulWidget {
  final List<dynamic> selected;
  final Function set;
  final ObjectType type;

  const BuilderAddLoadoutItems({Key? key, required this.selected, required this.set, required this.type}) : super(key: key);

  @override
  BuilderAddLoadoutItemsState createState() => BuilderAddLoadoutItemsState();
}

class BuilderAddLoadoutItemsState extends State<BuilderAddLoadoutItems> {
  final _controller = TextEditingController();

  final List<dynamic> _filtered = [];
  final List<dynamic> _selectedList = [];

  @override
  initState() {
    _selectedList.addAll(widget.selected);
    _controller.addListener(() => _reload());
    super.initState();
  }

  _reload() {
    _filtered.clear();
    setState(() {
      if (widget.type == ObjectType.weapon) {
        _filtered.addAll(HelperFilter.filterWeaponsByName(_controller.text, context));
        _filtered.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
      } else {
        _filtered.addAll(HelperFilter.filterListByName(JSONHelper.callers, _controller.text, context));
        _filtered.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
      }
    });
  }

  bool _contained(dynamic i, ObjectType type) {
    if (type == ObjectType.weapon) {
      for (dynamic d in _selectedList) {
        if (d.getAmmoID == i.getAmmoID) {
          return true;
        }
      }
    } else {
      for (dynamic d in _selectedList) {
        if (d.getID == i.getID) {
          return true;
        }
      }
    }
    return false;
  }

  _remove(dynamic i, ObjectType type) {
    if (type == ObjectType.weapon) {
      for (dynamic d in _selectedList) {
        if (d.getAmmoID == i.getAmmoID) {
          _selectedList.remove(d);
          break;
        }
      }
    } else {
      for (dynamic d in _selectedList) {
        if (d.getID == i.getID) {
          _selectedList.remove(d);
          break;
        }
      }
    }
  }

  _addOrRemove(dynamic item, ObjectType type) {
    if (_contained(item, type)) {
      _remove(item, type);
    } else {
      _selectedList.add(item);
    }
  }

  Widget _buildItems() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _filtered.length,
        itemBuilder: (context, index) {
          return EntryName.withSwitch(
              size: 40,
              text: widget.type == ObjectType.weapon ? _filtered[index].getNameAmmo(context.locale) : _filtered[index].getName(context.locale),
              subText: widget.type == ObjectType.weapon ? _filtered[index].getName(context.locale) : "",
              background: index % 2 == 0 ? Values.colorEven : Values.colorOdd,
              buttonIcon: "assets/graphics/icons/minus.svg",
              buttonInactiveIcon: "assets/graphics/icons/plus.svg",
              buttonActiveColor: Values.colorAlwaysDark,
              buttonInactiveColor: Values.colorAlwaysDark,
              buttonActiveBackground: Values.colorListSelected,
              buttonInactiveBackground: Values.colorListUnselected,
              isActive: _contained(_filtered[index], widget.type),
              oneLine: true,
              noInactiveOpacity: true,
              onTap: () {
                setState(() {
                  _addOrRemove(_filtered[index], widget.type);
                });
              });
        });
  }

  Widget _buildWidgets() {
    return WillPopScope(
        onWillPop: () async {
          widget.set(widget.type, _selectedList);
          return true;
        },
        child: WidgetScaffoldAdvanced(
            body: Column(children: [
          Column(children: [
            WidgetAppBar(
              text: widget.type == ObjectType.weapon ? tr('weapon_ammo') : tr('callers'),
              color: Values.colorAccent,
              background: Values.colorPrimary,
              fontSize: Values.fontSize30,
              function: () {
                widget.set(widget.type, _selectedList);
                Navigator.pop(context);
              },
            ),
            WidgetSearchBar(background: Values.colorSearchBackground, color: Values.colorSearch, controller: _controller)
          ]),
          Expanded(child: SingleChildScrollView(child: Column(children: [_buildItems()])))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    _reload();
    return _buildWidgets();
  }
}
