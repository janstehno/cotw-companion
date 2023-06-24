// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetDlcLists extends StatefulWidget {
  final List<dynamic> list;
  final List<dynamic> reserves;
  final int type;

  const WidgetDlcLists({
    Key? key,
    required this.list,
    this.reserves = const [],
    required this.type,
  }) : super(key: key);

  @override
  WidgetDlcListsState createState() => WidgetDlcListsState();
}

class WidgetDlcListsState extends State<WidgetDlcLists> {
  late final List<dynamic> _items = [];

  void _getItems() {
    List<dynamic> list = [];
    switch (widget.type) {
      case 1:
        list.addAll(HelperJSON.animals);
        break;
      case 2:
        list.addAll(HelperJSON.weapons);
        break;
      case 3:
        list.addAll(HelperJSON.callers);
        break;
      default:
        list.addAll(HelperJSON.reserves);
        break;
    }
    List<dynamic> result = [];
    for (int index in widget.list) {
      result.add(list[index - 1]);
    }
    _items.addAll(result);
    widget.type == 1 && widget.reserves.isNotEmpty
        ? _items.sort((a, b) => a.getNameBasedOnReserve(context.locale, widget.reserves[0]).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserves[0])))
        : _items.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  Widget _buildWidgets() {
    _getItems();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return WidgetText(
            height: 20,
            text: widget.type == 1 && widget.reserves.isNotEmpty
                ? _items[index].getNameBasedOnReserve(context.locale, widget.reserves[0])
                : _items[index].getName(context.locale),
            color: Interface.dark,
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
