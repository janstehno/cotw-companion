import 'package:collection/collection.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/repository/item.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  final String _name;
  final List<dynamic> _items;

  const ListItems(
    String name, {
    super.key,
    required List<dynamic> items,
  })  : _name = name,
        _items = items;

  Widget _buildEmpty() {
    return WidgetPadding.h30v20(
      child: WidgetText(
        tr("REPO:EMPTY"),
        color: Interface.dark,
        style: Style.normal.s12.w300,
        autoSize: false,
      ),
    );
  }

  Widget _buildItems(int i, Map<String, dynamic> data) {
    final String name = data['title'];
    final String url = data['html_url'];
    final String description = data['body'].replaceAll("\n", " ");
    return WidgetRepositoryItem(i, name: name, url: url, description: description);
  }

  List<Widget> _listItems() {
    return _items
        .where((e) => (e['state'] != 'locked' && e['state'] != 'closed'))
        .mapIndexed((i, e) => _buildItems(i, e))
        .toList();
  }

  Widget _buildDisclaimer() {
    return WidgetPadding.h30v20(
      background: Interface.search,
      child: WidgetText(
        tr("${_name}_DISCLAIMER"),
        color: Interface.dark,
        style: Style.normal.s12.w300,
        autoSize: false,
      ),
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(_name),
        context: context,
      ),
      children: [
        if (_items.isNotEmpty) _buildDisclaimer(),
        if (_items.isNotEmpty) Container(height: 1, color: Interface.grey),
        if (_items.isNotEmpty) ..._listItems() else _buildEmpty(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
