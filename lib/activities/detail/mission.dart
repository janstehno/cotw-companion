import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/icon/icon.dart';
import 'package:cotwcompanion/widgets/parts/stats/parameter.dart';
import 'package:cotwcompanion/widgets/parts/stats/tag.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailMission extends StatelessWidget {
  final Mission _mission;

  const ActivityDetailMission(
    Mission mission, {
    super.key,
  }) : _mission = mission;

  Widget _buildDifficulty() {
    return WidgetParameterTag(
      text: tr("DIFFICULTY"),
      value: _mission.difficultyAsString,
      background: _mission.difficultyColor,
    );
  }

  Widget _buildType() {
    return WidgetParameter(
      text: tr("TYPE"),
      value: _mission.typeAsString,
    );
  }

  Widget _buildGiver() {
    return WidgetParameter(
      text: tr("MISSION_GIVER"),
      value: _mission.person,
    );
  }

  Widget _buildReserve() {
    return WidgetParameter(
      text: tr("RESERVE"),
      value: HelperJSON.getReserve(_mission.reserveId)!.name,
    );
  }

  Widget _buildStatistics() {
    return WidgetPadding.a30(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          _buildDifficulty(),
          _buildType(),
          _buildGiver(),
          _buildReserve(),
        ],
      ),
    );
  }

  Widget _buildObjectiveIcon(String objective) {
    return WidgetIcon(
      Graphics.getObjectiveIcon(tr(objective)),
      color: _mission.getObjectiveColor(tr(objective)),
    );
  }

  Widget _buildObjectiveText(String objective) {
    return WidgetText(
      tr(objective).replaceAll("[I]", "").replaceAll("[O]", ""),
      color: Interface.dark,
      style: Style.normal.s16.w300,
      autoSize: false,
    );
  }

  Widget _buildObjective(String objective) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildObjectiveIcon(objective),
        const SizedBox(width: 7),
        Expanded(child: _buildObjectiveText(objective)),
      ],
    );
  }

  List<Widget> _listObjectives() {
    return _mission.description.map((e) => _buildObjective(e)).toList();
  }

  Widget _buildObjectives() {
    return Column(
      children: [
        WidgetTitle(tr("MISSION_OBJECTIVES")),
        WidgetPadding.a30(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _listObjectives(),
          ),
        ),
      ],
    );
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _mission.name,
        context: context,
      ),
      children: [
        _buildStatistics(),
        _buildObjectives(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
