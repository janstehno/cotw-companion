// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/builders/dlc_info/dlc_lists.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class ActivityDlcInfo extends StatefulWidget {
  final Dlc dlc;

  const ActivityDlcInfo({
    Key? key,
    required this.dlc,
  }) : super(key: key);

  @override
  ActivityDlcInfoState createState() => ActivityDlcInfoState();
}

class ActivityDlcInfoState extends State<ActivityDlcInfo> {
  Widget _buildName() {
    return Column(children: [
      WidgetTitle.sub(
        text: widget.dlc.date,
        alignment: Alignment.center,
      ),
    ]);
  }

  Widget _buildDescription() {
    return Column(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.dlc.getDescription(context.locale).length,
              itemBuilder: (context, index) {
                return Container(
                    padding: index == widget.dlc.getDescription(context.locale).length - 1 ? const EdgeInsets.only(bottom: 30) : const EdgeInsets.only(bottom: 15),
                    child: EasyRichText(widget.dlc.getDescription(context.locale)[index],
                        patternList: [
                          EasyRichTextPattern(
                              targetString: '(\\*)(.*?)(\\*)',
                              matchBuilder: (BuildContext context, RegExpMatch? match) {
                                return TextSpan(
                                    text: match![0]?.replaceAll('*', ''),
                                    style: TextStyle(
                                      color: Interface.primary,
                                      fontSize: Interface.s20,
                                      fontWeight: FontWeight.w700,
                                    ));
                              })
                        ],
                        defaultStyle: TextStyle(
                          color: Interface.dark,
                          fontSize: Interface.s20,
                          fontWeight: FontWeight.w400,
                        )));
              }))
    ]);
  }

  Widget _buildRAWC() {
    List<Widget> reserves = [Container()];
    if (widget.dlc.reserve.isNotEmpty) {
      reserves = [
        WidgetTitle(
          text: tr('reserves'),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              WidgetDlcLists(
                list: widget.dlc.reserve,
                type: 0,
              ),
            ]))
      ];
    }
    List<Widget> animals = [Container()];
    if (widget.dlc.animals.isNotEmpty) {
      animals = [
        WidgetTitle(
          text: tr('wildlife'),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              WidgetDlcLists(
                list: widget.dlc.animals,
                type: 1,
                reserves: widget.dlc.reserve,
              ),
            ]))
      ];
    }
    List<Widget> weapons = [Container()];
    if (widget.dlc.weapons.isNotEmpty) {
      weapons = [
        WidgetTitle(
          text: tr('weapons'),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              WidgetDlcLists(
                list: widget.dlc.weapons,
                type: 2,
              ),
            ]))
      ];
    }
    List<Widget> callers = [Container()];
    if (widget.dlc.callers.isNotEmpty) {
      callers = [
        WidgetTitle(
          text: tr('callers'),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              WidgetDlcLists(
                list: widget.dlc.callers,
                type: 3,
              ),
            ]))
      ];
    }
    switch (widget.dlc.type) {
      case 1:
        return Column(children: [
          Column(children: reserves),
          Column(children: animals),
          Column(children: weapons),
          Column(children: callers),
        ]);
      case 2:
        return Column(children: [
          Column(children: weapons),
        ]);
      case 3:
        return Column(children: [
          Column(children: animals),
          Column(children: callers),
        ]);
      default:
        return Container();
    }
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
            height: 150,
            text: widget.dlc.name,
            maxLines: widget.dlc.name.split(" ").length == 1 ? 1 : 2,
            color: Interface.accent,
            background: Interface.primary,
            fontSize: Interface.s40,
            context: context),
        children: [
          _buildName(),
          _buildDescription(),
          _buildRAWC(),
        ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
