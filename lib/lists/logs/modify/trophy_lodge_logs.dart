import 'package:collection/collection.dart';
import 'package:cotwcompanion/model/exportable/log.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/parts/logs/trophy_lodge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListTrophyLodgeLogs extends StatelessWidget {
  final List<Log> _trophyLodgeLogs;

  const ListTrophyLodgeLogs(
    List<Log> trophyLodgeLogs, {
    super.key,
  }) : _trophyLodgeLogs = trophyLodgeLogs;

  Widget _buildLog(BuildContext context, Log log, int i) {
    return WidgetTrophyLodge(
      i,
      log: _trophyLodgeLogs.elementAt(i),
      context: context,
    );
  }

  List<Widget> _listLogs(BuildContext context) {
    return _trophyLodgeLogs.mapIndexed((i, log) => _buildLog(context, log, i)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        tr("TROPHY_LODGE"),
        context: context,
      ),
      children: _listLogs(context),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
