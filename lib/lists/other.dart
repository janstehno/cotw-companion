// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/lists/other/dlcs.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/tap_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListOther extends StatefulWidget {
  const ListOther({
    Key? key,
  }) : super(key: key);

  @override
  ListOtherState createState() => ListOtherState();
}

class ListOtherState extends State<ListOther> {
  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('other'),
          context: context,
        ),
        body: WidgetTapText(
          text: tr('content_downloadable_content'),
          background: Interface.even,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ListDlcs()));
          },
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
