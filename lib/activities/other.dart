// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/other/other_dlcs.dart';
import 'package:cotwcompanion/widgets/tap_text.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityOther extends StatefulWidget {
  const ActivityOther({
    Key? key,
  }) : super(key: key);

  @override
  ActivityOtherState createState() => ActivityOtherState();
}

class ActivityOtherState extends State<ActivityOther> {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderOtherDlcs()));
          },
        ));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
