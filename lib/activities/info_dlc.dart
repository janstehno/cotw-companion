// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/lists/dlc_info/dlc_content.dart';
import 'package:cotwcompanion/model/dlc.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/rich_text.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
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
      WidgetTitleBig(
        primaryText: widget.dlc.date,
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
                    child: WidgetRichText(
                      text: widget.dlc.getDescription(context.locale)[index],
                    ));
              }))
    ]);
  }

  Widget _buildRAWC() {
    List<Widget> reserves = [const SizedBox.shrink()];
    if (widget.dlc.reserve.isNotEmpty) {
      reserves = [
        WidgetTitleBig(
          primaryText: tr("reserves"),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              ListDlcContent(
                list: widget.dlc.reserve,
                type: 0,
              ),
            ]))
      ];
    }
    List<Widget> animals = [const SizedBox.shrink()];
    if (widget.dlc.animals.isNotEmpty) {
      animals = [
        WidgetTitleBig(
          primaryText: tr("wildlife"),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              ListDlcContent(
                list: widget.dlc.animals,
                type: 1,
                reserves: widget.dlc.reserve,
              ),
            ]))
      ];
    }
    List<Widget> weapons = [const SizedBox.shrink()];
    if (widget.dlc.weapons.isNotEmpty) {
      weapons = [
        WidgetTitleBig(
          primaryText: tr("weapons"),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              ListDlcContent(
                list: widget.dlc.weapons,
                type: 2,
              ),
            ]))
      ];
    }
    List<Widget> callers = [const SizedBox.shrink()];
    if (widget.dlc.callers.isNotEmpty) {
      callers = [
        WidgetTitleBig(
          primaryText: tr("callers"),
        ),
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              ListDlcContent(
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
        return const SizedBox.shrink();
    }
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.dlc.name,
          maxLines: widget.dlc.name.split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildName(),
          _buildDescription(),
          _buildRAWC(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
