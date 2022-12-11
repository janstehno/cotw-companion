// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/dlc_info.dart';
import 'package:cotwcompanion/thehunter/model/dlc.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_icon_name_with_tap.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderOtherDlcs extends StatefulWidget {
  const BuilderOtherDlcs({Key? key}) : super(key: key);

  @override
  BuilderOtherDlcsState createState() => BuilderOtherDlcsState();
}

class BuilderOtherDlcsState extends State<BuilderOtherDlcs> {
  late final List<Dlc> _dlcs = [];

  @override
  void initState() {
    _dlcs.addAll(JSONHelper.dlcs);
    _dlcs.sort((a, b) => b.getDate.compareTo(a.getDate));
    super.initState();
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr('content_downloadable_content'),
          maxLines: 1,
          height: 90,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize30,
          fontWeight: FontWeight.w700,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [
          Column(children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dlcs.length,
                itemBuilder: (context, index) {
                  Dlc dlc = _dlcs[index];
                  return EntryIconNameWithTap(
                      text: dlc.getName,
                      color: dlc.getType == -1 ? Values.colorDisabled : Values.colorDark,
                      background: index % 2 == 0 ? Values.colorEven : Values.colorOdd,
                      onTap: () {
                        if (dlc.getType != -1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivityDlcInfo(dlc: dlc)),
                          );
                        }
                      });
                })
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
