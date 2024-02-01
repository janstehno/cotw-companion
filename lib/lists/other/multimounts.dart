// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/multimount.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/multimount.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListMultimounts extends StatefulWidget {
  const ListMultimounts({
    Key? key,
  }) : super(key: key);

  @override
  ListMultimountsState createState() => ListMultimountsState();
}

class ListMultimountsState extends State<ListMultimounts> {
  late final List<Multimount> _multimounts = [];

  void _getData() {
    _multimounts.addAll(HelperJSON.multimounts);
    _multimounts.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _multimounts.length,
        itemBuilder: (context, index) {
          return EntryMultimount(
            index: index,
            multimount: _multimounts.elementAt(index),
          );
        });
  }

  Widget _buildWidgets() {
    _getData();
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr("content_matmats_multimounts"),
        context: context,
      ),
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
