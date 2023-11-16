// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/info_dlc.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/tap_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListDlcs extends StatefulWidget {
  const ListDlcs({
    Key? key,
  }) : super(key: key);

  @override
  ListDlcsState createState() => ListDlcsState();
}

class ListDlcsState extends State<ListDlcs> {
  late final List<Dlc> _dlcs = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() {
    _dlcs.addAll(HelperJSON.dlcs);
    _dlcs.sort((a, b) => b.date.compareTo(a.date));
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _dlcs.length,
        itemBuilder: (context, index) {
          Dlc dlc = _dlcs[index];
          return WidgetTapText(
            text: dlc.name,
            color: dlc.type == -1 ? Interface.disabled : Interface.dark,
            background: index % 2 == 0 ? Interface.even : Interface.odd,
            onTap: () {
              if (dlc.type != -1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityDlcInfo(dlc: dlc)),
                );
              }
            },
          );
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("content_downloadable_content"),
        context: context,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
