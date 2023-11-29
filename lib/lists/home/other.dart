// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/other/dlcs.dart';
import 'package:cotwcompanion/lists/other/multimounts.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/menu.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListOther extends StatefulWidget {
  const ListOther({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListOtherState();
}

class ListOtherState extends State<ListOther> {
  final List<List<dynamic>> _items = [
    ["content_matmats_multimounts", "hammer", const ListMultimounts()],
    ["content_downloadable_content", "dlc", const ListDlcs()],
  ];

  Widget _buildItem(int index, String text, String icon, Widget activity) {
    return EntryMenu(
      text: tr(text),
      icon: "assets/graphics/icons/$icon.svg",
      background: Utils.background(index),
      onMenuTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => activity));
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          List<dynamic> item = _items.elementAt(index);
          return _buildItem(
            index,
            item[0],
            item[1],
            item[2],
          );
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("other"),
        context: context,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
