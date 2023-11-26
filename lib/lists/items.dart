// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ListItems extends StatefulWidget {
  final String name;

  const ListItems({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  ListItemsState createState() => ListItemsState();
}

class ListItemsState extends State<ListItems> {
  final TextEditingController controller = TextEditingController();
  final List<dynamic> items = [];

  bool filterChanged = false;

  @override
  void initState() {
    controller.addListener(() => filter());
    super.initState();
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void filter() {}

  buildFilters() {}

  buildItemEntry(int index) {}

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: buildFilters(), filter: filter)));
  }

  Widget _buildList() {
    filter();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return buildItemEntry(index);
        });
  }

  Widget buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr(widget.name),
        context: context,
      ),
      searchController: controller,
      filterChanged: filterChanged,
      filter: _buildFilter,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => buildWidgets();
}
