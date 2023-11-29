// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/dlc.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
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
          Dlc dlc = _dlcs.elementAt(index);
          return WidgetTapText(
            text: dlc.en,
            color: dlc.type == -1 ? Interface.disabled : Interface.dark,
            background: Utils.background(index),
            onTap: () {
              if (dlc.type != -1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityDetailDlc(dlc: dlc)),
                );
              }
            },
          );
        });
  }

  Widget _buildWidgets() {
    _getData();
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("content_downloadable_content"),
        context: context,
        maxLines: 2,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
