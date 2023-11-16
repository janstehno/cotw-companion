// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/model/log.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/trophy_lodge_record.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListTrophyLodgeLogs extends StatelessWidget {
  final List<Log> trophyLodgeLogs;

  const ListTrophyLodgeLogs({
    required this.trophyLodgeLogs,
    Key? key,
  }) : super(key: key);

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trophyLodgeLogs.length,
        itemBuilder: (context, index) {
          return EntryTrophyLodgeRecord(
            index: index,
            log: trophyLodgeLogs[index],
          );
        });
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("trophy_lodge"),
        context: context,
      ),
      appBarFixed: true,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
