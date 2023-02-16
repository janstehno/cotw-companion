// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/builders/dlc_info/dlc_lists.dart';
import 'package:cotwcompanion/thehunter/model/dlc.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_appbar.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_container.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_scaffold.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class ActivityDlcInfo extends StatefulWidget {
  final Dlc dlc;

  const ActivityDlcInfo({Key? key, required this.dlc}) : super(key: key);

  @override
  ActivityDlcInfoState createState() => ActivityDlcInfoState();
}

class ActivityDlcInfoState extends State<ActivityDlcInfo> {
  Widget _buildName() {
    return Column(children: [WidgetTitle.sub(text: widget.dlc.getDate, alignment: Alignment.center)]);
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
                                    style: TextStyle(color: Color(Values.colorPrimary), fontSize: Values.fontSize20, fontWeight: FontWeight.w800));
                              })
                        ],
                        defaultStyle: TextStyle(color: Color(Values.colorDark), fontSize: Values.fontSize20, fontWeight: FontWeight.w400)));
              }))
    ]);
  }

  Widget _buildRAWC() {
    List<Widget> reserves = [Container()];
    if (widget.dlc.getReserves.isNotEmpty) {
      reserves = [
        WidgetTitle.sub(text: tr('reserves')),
        WidgetContainer(child: Column(children: [WidgetDlcLists(list: widget.dlc.getReserves, type: 0)]))
      ];
    }
    List<Widget> animals = [Container()];
    if (widget.dlc.getAnimals.isNotEmpty) {
      animals = [
        WidgetTitle.sub(text: tr('wildlife')),
        WidgetContainer(child: Column(children: [WidgetDlcLists(list: widget.dlc.getAnimals, type: 1, reserves: widget.dlc.getReserves)]))
      ];
    }
    List<Widget> weapons = [Container()];
    if (widget.dlc.getWeapons.isNotEmpty) {
      weapons = [
        WidgetTitle.sub(text: tr('weapons')),
        WidgetContainer(child: Column(children: [WidgetDlcLists(list: widget.dlc.getWeapons, type: 2)]))
      ];
    }
    List<Widget> callers = [Container()];
    if (widget.dlc.getCallers.isNotEmpty) {
      callers = [
        WidgetTitle.sub(text: tr('callers')),
        WidgetContainer(child: Column(children: [WidgetDlcLists(list: widget.dlc.getCallers, type: 3)]))
      ];
    }
    switch (widget.dlc.getType) {
      case 1:
        return Column(children: [Column(children: reserves), Column(children: animals), Column(children: weapons), Column(children: callers)]);
      case 2:
        return Column(children: [Column(children: weapons)]);
      case 3:
        return Column(children: [Column(children: animals), Column(children: callers)]);
      default:
        return Container();
    }
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          height: 150,
          text: widget.dlc.getName,
          color: Values.colorAccent,
          background: Values.colorPrimary,
          fontSize: Values.fontSize40,
          fontWeight: FontWeight.w800,
          alignment: Alignment.centerRight,
          function: () {
            Navigator.pop(context);
          },
        ),
        children: [_buildName(), _buildDescription(), _buildRAWC()]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
