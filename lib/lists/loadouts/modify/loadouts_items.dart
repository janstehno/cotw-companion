import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ListLoadoutItems<I> extends StatefulWidget {
  final String _title;
  final Set<I> _selected;
  final Function _onSelect;

  const ListLoadoutItems(
    String title, {
    super.key,
    required Set<I> selected,
    required Function onSelect,
  })  : _title = title,
        _selected = selected,
        _onSelect = onSelect;

  String get title => _title;

  Set<I> get selected => _selected;

  Function get set => _onSelect;
}

abstract class ListLoadoutItemsState<I> extends State<ListLoadoutItems<I>> {
  final controller = TextEditingController();
  final List<I> selectedItems = [];

  List<I> _filteredItems = [];

  List<I> get items;

  @override
  void initState() {
    controller.addListener(() => _filter());
    selectedItems.addAll(widget.selected);
    super.initState();
  }

  void _filter() {
    setState(() => _filteredItems = items);
  }

  bool contains(I item);

  void addOrRemove(I item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  Widget buildItemSwitch(I item);

  List<Widget> _listItems() {
    if (_filteredItems.isEmpty) _filter();
    return _filteredItems.map((e) => buildItemSwitch(e)).toList();
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(widget._title),
        context: context,
      ),
      searchController: controller,
      children: _listItems(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
