import 'package:collection/collection.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/section/section_tap_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ListItems extends StatefulWidget {
  final String _title;

  const ListItems(
    String title, {
    super.key,
  }) : _title = title;

  String get title => _title;
}

abstract class ListItemsState extends State<ListItems> {
  List<List<dynamic>> get items;

  Widget _buildEntry(int i, List<dynamic> item) {
    return WidgetSectionTapIcon(
      item.elementAt(0),
      icon: item.elementAt(1),
      background: Utils.backgroundAt(i),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (e) => item.elementAt(2))),
    );
  }

  List<Widget> _listEntries() {
    return items.mapIndexed((i, item) => _buildEntry(i, item)).toList();
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr(widget.title),
        context: context,
      ),
      children: _listEntries(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
