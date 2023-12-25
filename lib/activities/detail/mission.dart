// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/mission.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityDetailMission extends StatefulWidget {
  final Mission mission;

  const ActivityDetailMission({
    Key? key,
    required this.mission,
  }) : super(key: key);

  @override
  ActivityDetailMissionState createState() => ActivityDetailMissionState();
}

class ActivityDetailMissionState extends State<ActivityDetailMission> {
  Widget _buildStatistics() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildType(),
              _buildDifficulty(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildType() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: AutoSizeText(
                tr("type"),
                style: Interface.s16w300n(Interface.dark),
              ),
            ),
          ),
          AutoSizeText(
            widget.mission.getTypeAsString(),
            style: Interface.s16w500n(Interface.dark),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficulty() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: AutoSizeText(
              tr("difficulty"),
              style: Interface.s16w300n(Interface.dark),
            ),
          ),
        ),
        WidgetTag.small(
          color: Interface.alwaysDark,
          background: widget.mission.getDifficultyColor(),
          value: widget.mission.getDifficultyAsString(),
        ),
      ],
    );
  }

  Widget _buildReserve() {
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr("reserve"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 30),
          child: AutoSizeText(
            HelperJSON.getReserve(widget.mission.reserveId).getName(context.locale),
            style: Interface.s16w300n(Interface.dark),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _buildGiver() {
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr("mission_giver"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 30),
          child: AutoSizeText(
            HelperJSON.getMissionGiver(widget.mission.giverId).getName(context.locale),
            style: Interface.s16w300n(Interface.dark),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _buildObjective(String text, String icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(3),
            margin: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              "assets/graphics/icons/$icon.svg",
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              text.replaceAll("[I]", "").replaceAll("[O]", ""),
              style: Interface.s16w300n(Interface.dark),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildObjectives() {
    List<dynamic> description = widget.mission.getDescription(context.locale);
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr("mission_objectives"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 30),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: description.length,
              itemBuilder: (context, index) {
                String text = description.elementAt(index) as String;
                return text.startsWith("[I]")
                    ? _buildObjective(text, "about", Interface.oceanBlue)
                    : text.startsWith("[O]")
                        ? _buildObjective(text, "optional", Interface.disabled)
                        : _buildObjective(text, "todo", Interface.green);
              }),
        ),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: widget.mission.getName(context.locale),
          maxLines: widget.mission.getName(context.locale).split(" ").length > 2 ? 2 : 1,
          context: context,
        ),
        body: Column(children: [
          _buildStatistics(),
          _buildReserve(),
          _buildGiver(),
          _buildObjectives(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
