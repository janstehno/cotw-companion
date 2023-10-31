// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/lists/caller_info/caller_animals.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
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
                      child: AutoSizeText(
                        tr('caller_range'),
                        maxLines: 1,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              Text(
                _caller.getRange(_imperialUnits),
                style: Interface.s18w500n(Interface.dark),
              )
            ]),
            Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(
                            tr('caller_duration'),
                            maxLines: 1,
                            style: Interface.s16w300n(Interface.dark),
                          ))),
                  Text(
                    "${_caller.duration} ${tr('seconds')}",
                    style: Interface.s18w500n(Interface.dark),
                  )
                ])),
            Container(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(
                            tr('caller_strength'),
                            maxLines: 1,
                            style: Interface.s16w300n(Interface.dark),
                          ))),
                  Text(
                    _caller.strength.toString(),
                    style: Interface.s18w500n(Interface.dark),
                  )
                ])),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: AutoSizeText(
                        tr('price'),
                        maxLines: 1,
                        style: Interface.s16w300n(Interface.dark),
                      ))),
              Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                _caller.price == 0 || _caller.price == -1
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.only(right: 2.5),
                        padding: const EdgeInsets.only(top: 1.15),
                        child: SvgPicture.asset(
                          "assets/graphics/icons/money.svg",
                          width: 13,
                          height: 13,
                          colorFilter: ColorFilter.mode(
                            Interface.dark,
                            BlendMode.srcIn,
                          ),
                        )),
                AutoSizeText(
                  _caller.price == 0
                      ? tr('free')
                      : _caller.price == -1
                          ? tr('none')
                          : "${_caller.price}",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Interface.s18w500n(Interface.dark),
                )
              ])
            ]),
          ]))
    ]);
  }

  Widget _buildAnimals() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr('recommended_animals'),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            ListCallerAnimals(callerId: widget.callerId),
          ]))
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: _caller.getName(context.locale),
          maxLines: _caller.getName(context.locale).split(" ").length > 2 ? 2 : 1,
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
