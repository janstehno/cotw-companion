// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/planner/perks.dart';
import 'package:cotwcompanion/lists/planner/skills.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/proficiency.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/proficiency_detail.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/text_field.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityPlanner extends StatefulWidget {
  final HelperPlanner helperPlanner;

  const ActivityPlanner({
    Key? key,
    required this.helperPlanner,
  }) : super(key: key);

  @override
  ActivityPlannerState createState() => ActivityPlannerState();
}

class ActivityPlannerState extends State<ActivityPlanner> {
  final TextEditingController _controller = TextEditingController(text: "60");

  final int _criticalLevel = 37;

  late Proficiency _proficiency;

  int _level = 60;
  int _availableSkillPoints = 0;
  int _availablePerkPoints = 0;
  bool _showDetail = false;

  @override
  void initState() {
    _controller.addListener(() => _initializePoints());
    _initializePoints();
    super.initState();
  }

  void _showDetailedInformation(Proficiency proficiency) {
    setState(() {
      _showDetail = true;
      _proficiency = proficiency;
    });
  }

  void _hideDetailedInformation() {
    setState(() {
      _showDetail = false;
    });
  }

  void _resetSkillPoints(ProficiencyType type) {
    setState(() {
      widget.helperPlanner.resetSkillsFor(type);
    });
  }

  void _resetPerkPoints(ProficiencyType type) {
    setState(() {
      widget.helperPlanner.resetPerksFor(type);
    });
  }

  void _initializePoints() {
    _level = int.parse(_controller.text.isEmpty ? "0" : _controller.text);
    setState(() {
      if (_level == Values.maxLevel) {
        _availableSkillPoints = Values.skillPoints;
        _availablePerkPoints = Values.perkPoints;
      } else if (_level <= _criticalLevel && _level >= 0) {
        _availableSkillPoints = _level ~/ 2;
        _availablePerkPoints = (_level - 1) ~/ 2;
      } else if (_level > _criticalLevel) {
        _availableSkillPoints = 18 + (_level - _criticalLevel) ~/ 6;
        _availablePerkPoints = 18 + (_level - _criticalLevel + 3) ~/ 6;
      } else {
        _availableSkillPoints = 0;
        _availablePerkPoints = 0;
      }
    });
  }

  Widget _buildDetailedInformation() {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _showDetail ? 1 : 0,
        child: _showDetail
            ? WidgetProficiencyDetail(
                proficiency: _proficiency,
                callback: _hideDetailedInformation,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildSkillTree(String name, ProficiencyType type) {
    return Column(
      children: [
        WidgetTitleBigButton(
          primaryText: tr(name),
          secondaryText: "${widget.helperPlanner.getSkillPointsFor(type, true)}/${widget.helperPlanner.getSkillPointsFor(type, false)}",
          icon: "assets/graphics/icons/reload.svg",
          buttonColor: Interface.dark,
          buttonBackground: Colors.transparent,
          onTap: () {
            _resetSkillPoints(type);
          },
        ),
        ListSkills(
          type: type,
          helperPlanner: widget.helperPlanner,
          availablePoints: _availableSkillPoints,
          refresh: () {
            setState(() {});
          },
          showDetail: _showDetailedInformation,
        ),
      ],
    );
  }

  Widget _buildPerkTree(String name, ProficiencyType type) {
    return Column(
      children: [
        WidgetTitleBigButton(
          primaryText: tr(name),
          secondaryText: "${widget.helperPlanner.getPerkPointsFor(type, true)}/${widget.helperPlanner.getPerkPointsFor(type, false)}",
          icon: "assets/graphics/icons/reload.svg",
          buttonColor: Interface.dark,
          buttonBackground: Colors.transparent,
          onTap: () {
            _resetPerkPoints(type);
          },
        ),
        ListPerks(
          type: type,
          helperPlanner: widget.helperPlanner,
          availablePoints: _availablePerkPoints,
          refresh: () {
            setState(() {});
          },
          showDetail: _showDetailedInformation,
        ),
      ],
    );
  }

  Widget _buildPlanner() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSkillTree("skills_stalker", ProficiencyType.stalker),
        _buildSkillTree("skills_ambusher", ProficiencyType.ambusher),
        _buildPerkTree("weapons_rifles", ProficiencyType.rifle),
        _buildPerkTree("weapons_shotguns", ProficiencyType.shotgun),
        _buildPerkTree("weapons_handguns", ProficiencyType.handgun),
        _buildPerkTree("weapons_bows_crossbows", ProficiencyType.archery),
      ],
    );
  }

  Widget _buildLevel() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("player_level"),
        secondaryText: "${tr("points_skills")}: $_availableSkillPoints/${Values.perkPoints} ${tr("points_perks")}: $_availablePerkPoints/${Values.perkPoints}",
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: WidgetTextField(
            controller: _controller,
            numberOnly: true,
          )),
    ]);
  }

  Widget _buildBody() {
    return Stack(
      children: [
        WidgetScrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                WidgetAppBar(
                  text: tr("planner"),
                  context: context,
                ),
                _buildLevel(),
                _buildPlanner(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: _buildDetailedInformation(),
        ),
      ],
    );
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      customBody: true,
      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
