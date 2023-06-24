// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/activities/info_dlc.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/widgets/text.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderOtherDlcs extends StatefulWidget {
  const BuilderOtherDlcs({
    Key? key,
  }) : super(key: key);

  @override
  BuilderOtherDlcsState createState() => BuilderOtherDlcsState();
}

class BuilderOtherDlcsState extends State<BuilderOtherDlcs> {
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

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
            text: tr('content_downloadable_content'), maxLines: 1, color: Interface.accent, background: Interface.primary, fontSize: Interface.s30, context: context),
        children: [
          Column(children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dlcs.length,
                itemBuilder: (context, index) {
                  Dlc dlc = _dlcs[index];
                  return WidgetText(
                      height: 75,
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
                      });
                })
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
