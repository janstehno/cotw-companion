// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/other/other_dlcs.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_icon_name_with_tap.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityOther extends StatefulWidget {
  const ActivityOther({Key? key}) : super(key: key);

  @override
  ActivityOtherState createState() => ActivityOtherState();
}

class ActivityOtherState extends State<ActivityOther> {
  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('other'),
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [
          EntryIconNameWithTap(
              text: tr('content_downloadable_content'),
              icon: "assets/graphics/icons/other.svg",
              background: Values.colorEven,
              color: Values.colorDark,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderOtherDlcs()));
              })
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
