// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/caller_info/caller_animals.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/parameter.dart';
import 'package:cotwcompanion/widgets/price.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityDetailCaller extends StatefulWidget {
  final Caller caller;
  final bool units = false;

  const ActivityDetailCaller({
    Key? key,
    required this.caller,
  }) : super(key: key);

  @override
  ActivityDetailCallerState createState() => ActivityDetailCallerState();
}

class ActivityDetailCallerState extends State<ActivityDetailCaller> {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  late final bool _imperialUnits;

  @override
  void initState() {
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    super.initState();
  }

  Widget _buildStatistics() {
    return Column(
      children: [
        Container(
          padding: _padding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildRange(),
              _buildDuration(),
              _buildStrength(),
              EntryParameterPrice(price: widget.caller.price),
              _buildRequirements(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRange() {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: EntryParameter(
        text: tr("caller_range"),
        value: widget.caller.getRange(_imperialUnits),
      ),
    );
  }

  Widget _buildDuration() {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: EntryParameter(
        text: tr("caller_duration"),
        value: "${widget.caller.duration} ${tr("seconds")}",
      ),
    );
  }

  Widget _buildStrength() {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: EntryParameter(
        text: tr("caller_strength"),
        value: widget.caller.strength,
      ),
    );
  }

  Widget _buildRequirements() {
    return widget.caller.hasRequirements
        ? Container(
            padding: const EdgeInsets.only(top: 7),
            child: EntryParameter(
              text: tr("requirement_level"),
              value: widget.caller.level,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("recommended_animals"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            ListCallerAnimals(callerId: widget.caller.id),
          ]))
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.caller.getName(context.locale),
          maxLines: widget.caller.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
          _buildAnimals(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
