// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_filter.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_types.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/helpers/multi_sort.dart';
import 'package:cotwcompanion/thehunter/widgets/animal.dart';
import 'package:cotwcompanion/thehunter/widgets/caller.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/reserve.dart';
import 'package:cotwcompanion/thehunter/widgets/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderRAWC extends StatefulWidget {
  final String text;
  final ObjectType type;

  const BuilderRAWC({Key? key, required this.text, required this.type}) : super(key: key);

  @override
  BuilderRAWCState createState() => BuilderRAWCState();
}

class BuilderRAWCState extends State<BuilderRAWC> {
  final List<dynamic> _items = [];
  final List<dynamic> _filtered = [];

  final _controller = TextEditingController();

  bool _sorted = false;

  @override
  initState() {
    _items.addAll(widget.type == ObjectType.reserve
        ? JSONHelper.reserves
        : widget.type == ObjectType.animal
            ? JSONHelper.animals
            : widget.type == ObjectType.weapon
                ? JSONHelper.weapons
                : JSONHelper.callers);
    _controller.addListener(()=>_filter());
    super.initState();
  }

  _filter() {
    setState(() {
      _filtered.clear();
      _filtered.addAll(HelperFilter.filterListByName(_items, _controller.text, context));
    });
  }

  _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _sortList() {
    _sorted = true;
    switch (widget.type) {
      case ObjectType.reserve:
        break;
      case ObjectType.animal:
        _items.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
        break;
      case ObjectType.weapon:
        for (dynamic d in _items) {
          //FOR SORTING
          d.setName(context.locale);
        }
        _items.multiSort([true, true], ["TYPE", "NAME"]);
        break;
      case ObjectType.caller:
        _items.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
        break;
    }
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _filtered.length,
        itemBuilder: (context, index) {
          dynamic item = _filtered[index];
          switch (widget.type) {
            case ObjectType.reserve:
              return EntryReserve(reserve: item, index: index, callback: _focus);
            case ObjectType.animal:
              return EntryAnimal(animal: item, index: index, callback: _focus);
            case ObjectType.weapon:
              return EntryWeapon(weapon: item, index: index, callback: _focus);
            case ObjectType.caller:
              return EntryCaller(caller: item, index: index, callback: _focus);
          }
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.text.tr(),
          height: 90,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          fontWeight: FontWeight.w700,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        showSearchBar: true,
        searchBarController: _controller,
        children: [
          Column(children: [_buildList()])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    if (!_sorted) _sortList();
    _filter();
    return _buildWidgets();
  }
}
