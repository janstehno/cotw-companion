// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_settings.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/caller_info/caller_animals.dart';
import 'package:cotwcompanion/thehunter/model/caller.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityCallerInfo extends StatefulWidget {
  final int callerID;
  final bool units = false;

  const ActivityCallerInfo({Key? key, required this.callerID}) : super(key: key);

  @override
  ActivityCallerInfoState createState() => ActivityCallerInfoState();
}

class ActivityCallerInfoState extends State<ActivityCallerInfo> {
  late final Caller _caller;
  late final Settings _settings;

  @override
  void initState() {
    _caller = JSONHelper.getCaller(widget.callerID);
    _settings = Provider.of<Settings>(context, listen: false);
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(children: [
      WidgetContainer(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(tr('caller_range'),
                      maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
          Text(_caller.getRange(_settings.getImperialUnits), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
        ]),
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(tr('caller_duration'),
                          maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
              Text(_caller.getDuration, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
            ])),
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(tr('caller_strength'),
                      maxLines: 1, style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)))),
          Text(_caller.getStrength.toString(), style: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize24, fontWeight: FontWeight.w600))
        ])
      ]))
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitle.sub(text: tr('recommended_animals')),
      WidgetContainer(child: Column(children: [BuilderCallerAnimals(callerID: widget.callerID)]))
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          height: 150,
          text: _caller.getName(context.locale),
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize40,
          fontWeight: FontWeight.w800,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildStatistics(), _buildAnimals()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
