// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/types.dart';
import 'package:cotwcompanion/miscellaneous/multi_sort.dart';
import 'package:cotwcompanion/widgets/entries/animal.dart';
import 'package:cotwcompanion/widgets/entries/caller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/entries/reserve.dart';
import 'package:cotwcompanion/widgets/entries/weapon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderRAWC extends StatefulWidget {
  final String text;
  final ObjectType type;

  const BuilderRAWC({
    Key? key,
    required this.text,
    required this.type,
  }) : super(key: key);

  @override
  BuilderRAWCState createState() => BuilderRAWCState();
}

class BuilderRAWCState extends State<BuilderRAWC> {
  final TextEditingController _controller = TextEditingController();
  final List<dynamic> _items = [];
  final List<dynamic> _filtered = [];

  @override
  void initState() {
    _controller.addListener(() => _reload());
    super.initState();
  }

  void _getData() {
    _items.clear();
    _filtered.clear();
    switch (widget.type) {
      case ObjectType.reserve:
        _items.addAll(HelperJSON.reserves);
        break;
      case ObjectType.animal:
        _items.addAll(HelperJSON.animals);
        _items.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
        break;
      case ObjectType.weapon:
        _items.addAll(HelperJSON.weapons);
        for (dynamic item in _items) {
          //FOR SORTING
          item.setName(context.locale);
        }
        _items.multiSort([true, true], ["TYPE", "NAME"]);
        break;
      case ObjectType.caller:
        _items.addAll(HelperJSON.callers);
        _items.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
        break;
      default:
        _items.addAll([]);
        break;
    }
    _reload();
  }

  void _reload() {
    setState(() {
      _filtered.clear();
      if (widget.type == ObjectType.weapon) {
        _filtered.addAll(HelperFilter.filterWeapons(_items.cast(), _controller.text, context));
      } else {
        _filtered.addAll(HelperFilter.filterListByName(_items, _controller.text, context));
      }
    });
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
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
              return EntryReserve(index: index, reserve: item, callback: _focus);
            case ObjectType.animal:
              return EntryAnimal(index: index, animal: item, callback: _focus);
            case ObjectType.weapon:
              return EntryWeapon(index: index, weapon: item, callback: _focus);
            case ObjectType.caller:
              return EntryCaller(index: index, caller: item, callback: _focus);
            default:
              return Container();
          }
        });
  }

  Widget _buildWidgets() {
    _getData();
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr(widget.text),
        context: context,
      ),
      withSearchBar: true,
      appBarScroll: false,
      searchBarController: _controller,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
