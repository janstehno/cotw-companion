// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/caller_info/caller_animals.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityCallerInfo extends StatefulWidget {
  final int callerId;
  final bool units = false;

  const ActivityCallerInfo({
    Key? key,
    required this.callerId,
  }) : super(key: key);

  @override
  ActivityCallerInfoState createState() => ActivityCallerInfoState();
}

class ActivityCallerInfoState extends State<ActivityCallerInfo> {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  late final Caller _caller;
  late final bool _imperialUnits;

  @override
  void initState() {
    _caller = HelperJSON.getCaller(widget.callerId);
    _imperialUnits = Provider.of<Settings>(context, listen: false).getImperialUnits;
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(children: [
      Container(
          padding: _padding,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(tr('caller_range'),
                          maxLines: 1,
                          style: TextStyle(
                            color: Interface.dark,
                            fontSize: Interface.s20,
                            fontWeight: FontWeight.w400,
                          )))),
              Text(_caller.getRange(_imperialUnits),
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s24,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(tr('caller_duration'),
                              maxLines: 1,
                              style: TextStyle(
                                color: Interface.dark,
                                fontSize: Interface.s20,
                                fontWeight: FontWeight.w400,
                              )))),
                  Text("${_caller.duration} ${tr('seconds')}",
                      style: TextStyle(
                        color: Interface.dark,
                        fontSize: Interface.s24,
                        fontWeight: FontWeight.w600,
                      ))
                ])),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(tr('caller_strength'),
                          maxLines: 1,
                          style: TextStyle(
                            color: Interface.dark,
                            fontSize: Interface.s20,
                            fontWeight: FontWeight.w400,
                          )))),
              Text(_caller.strength.toString(),
                  style: TextStyle(
                    color: Interface.dark,
                    fontSize: Interface.s24,
                    fontWeight: FontWeight.w600,
                  ))
            ])
          ]))
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitle(
        text: tr('recommended_animals'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            BuilderCallerAnimals(callerId: widget.callerId),
          ]))
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
            height: 150,
            text: _caller.getName(context.locale),
            maxLines: _caller.getName(context.locale).split(" ").length == 1 ? 1 : 2,
            color: Interface.accent,
            background: Interface.primary,
            fontSize: Interface.s40,
            context: context),
        children: [
          _buildStatistics(),
          _buildAnimals(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
