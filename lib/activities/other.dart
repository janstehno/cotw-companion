// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/other/other_dlcs.dart';
import 'package:cotwcompanion/widgets/text_icon.dart';
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
          color: Interface.accent,
          background: Interface.primary,
          fontSize: Interface.s30,
          context: context,
        ),
        children: [
          WidgetTextIcon.withTap(
              height: 75,
              iconSize: 25,
              text: tr('content_downloadable_content'),
              icon: "assets/graphics/icons/other.svg",
              color: Interface.dark,
              background: Interface.even,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BuilderOtherDlcs()));
              })
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
