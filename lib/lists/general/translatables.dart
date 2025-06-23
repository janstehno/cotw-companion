import 'package:collection/collection.dart';
import 'package:cotwcompanion/activities/filter/filter.dart';
import 'package:cotwcompanion/filters/filter.dart';
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

  late final Filter<I> filter;

  List<I> _initialItems = [];

  List<I> _filteredItems = [];

  List<I> get items => _initialItems;

  ActivityFilter<I>? get activityFilter => null;

  @override
  void initState() {
    controller.addListener(() => filterItems());
    super.initState();
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  List<I> initialItems();

  void _initialize() {
    _initialItems = initialItems();
  }

  void filterItems() {
    setState(() {
      _filteredItems = filter.filter(items, controller.text, context);
    });
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (e) => activityFilter!));
  }

  Widget buildEntry(int index, I item);

  List<Widget> listEntries() {
    if (_initialItems.isEmpty) _initialize();
    if (_filteredItems.isEmpty) filterItems();
    return _filteredItems.mapIndexed((i, e) => buildEntry(i, e)).toList();
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(widget.title),
        context: context,
      ),
      searchController: controller,
      filterChanged: filter.isActive(),
      onFilterTap: activityFilter != null ? _buildFilter : null,
      children: listEntries(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
