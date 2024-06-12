import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/model/translatable/translatable.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ListTranslatable extends StatefulWidget {
  final String _title;

  const ListTranslatable(
    String title, {
    super.key,
  }) : _title = title;

  String get title => _title;
}

abstract class ListTranslatableState<I extends Translatable> extends State<ListTranslatable> {
  final TextEditingController controller = TextEditingController();

  List<I> items = [];

  List<I> _filteredItems = [];

  List<I> get getItems;

  @override
  void initState() {
    controller.addListener(() => _filter());
    super.initState();
  }

  void _getItems() {
    items = getItems;
  }

  void _filter() {
    setState(() {
      _filteredItems = items;
    });
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  bool isFilterChanged();

  List<Widget> listFilter();

  void _buildFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => ActivityFilter(filters: listFilter(), filter: _filter)),
    );
  }

  Widget buildEntry(I item);

  List<Widget> _listEntries() {
    if (items.isEmpty) _getItems();
    if (_filteredItems.isEmpty) _filter();
    return _filteredItems.map((e) => buildEntry(e)).toList();
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(widget.title),
        context: context,
      ),
      searchController: controller,
      filterChanged: isFilterChanged(),
      onFilterTap: _buildFilter,
      children: _listEntries(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
