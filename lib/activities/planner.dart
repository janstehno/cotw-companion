import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/lists/planner/perks.dart';
import 'package:cotwcompanion/lists/planner/skills.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/fullscreen/proficiency_detail.dart';
import 'package:cotwcompanion/widgets/text/text_field.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityPlanner extends StatefulWidget {
  final HelperPlanner _helperPlanner;

  const ActivityPlanner(
    HelperPlanner helperPlanner, {
    super.key,
  }) : _helperPlanner = helperPlanner;

  HelperPlanner get helperPlanner => _helperPlanner;

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
    setState(() => _showDetail = false);
  }

  void _resetSkillPoints(ProficiencyType type) {
    setState(() => widget.helperPlanner.resetSkillsFor(type));
  }

  void _resetPerkPoints(ProficiencyType type) {
    setState(() => widget.helperPlanner.resetPerksFor(type));
  }

  void _initializePoints() {
    _level = int.parse(_controller.text.isEmpty ? "0" : _controller.text);
    setState(() {
      if (_level >= Values.maxLevel) {
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
    return WidgetProficiencyDetail(
      proficiency: _proficiency,
      context: context,
      onClose: _hideDetailedInformation,
    );
  }

  String _pointsForSkill(ProficiencyType type) {
    return "${widget.helperPlanner.getSkillPointsFor(type, true)}/${widget.helperPlanner.getSkillPointsFor(type, false)}";
  }

  Widget _buildSkillTree(String name, ProficiencyType type) {
    return Column(
      children: [
        WidgetTitleButtonIcon(
          name,
          subtext: _pointsForSkill(type),
          icon: Assets.graphics.icons.reload,
          alignRight: true,
          onTap: () => _resetSkillPoints(type),
        ),
        ListSkills(
          type,
          helperPlanner: widget.helperPlanner,
          availablePoints: _availableSkillPoints,
          showDetail: _showDetailedInformation,
          rebuild: () => setState(() {}),
        ),
      ],
    );
  }

  String _pointsForPerk(ProficiencyType type) {
    return "${widget.helperPlanner.getPerkPointsFor(type, true)}/${widget.helperPlanner.getPerkPointsFor(type, false)}";
  }

  Widget _buildPerkTree(String name, ProficiencyType type) {
    return Column(
      children: [
        WidgetTitleButtonIcon(
          name,
          subtext: _pointsForPerk(type),
          icon: Assets.graphics.icons.reload,
          alignRight: true,
          onTap: () => _resetPerkPoints(type),
        ),
        ListPerks(
          type,
          helperPlanner: widget.helperPlanner,
          availablePoints: _availablePerkPoints,
          showDetail: _showDetailedInformation,
          rebuild: () => setState(() {}),
        ),
      ],
    );
  }

  List<Widget> _listPlanner() {
    return [
      _buildSkillTree(tr("SKILLS_STALKER"), ProficiencyType.stalker),
      _buildSkillTree(tr("SKILLS_AMBUSHER"), ProficiencyType.ambusher),
      _buildPerkTree(tr("WEAPONS_RIFLES"), ProficiencyType.rifle),
      _buildPerkTree(tr("WEAPONS_SHOTGUNS"), ProficiencyType.shotgun),
      _buildPerkTree(tr("WEAPONS_HANDGUNS"), ProficiencyType.handgun),
      _buildPerkTree(tr("WEAPONS_BOWS_CROSSBOWS"), ProficiencyType.archery),
    ];
  }

  String _pointsForPerksSkills() {
    return "${tr("POINTS_SKILLS")}: $_availableSkillPoints/${Values.perkPoints} ${tr("POINTS_PERKS")}: $_availablePerkPoints/${Values.perkPoints}";
  }

  List<Widget> _listLevel() {
    return [
      WidgetTitle(
        tr("PLAYER_LEVEL"),
        subtext: _pointsForPerksSkills(),
      ),
      SizedBox(
        height: Values.textField,
        child: WidgetPadding.h30(
          child: WidgetTextField(
            textController: _controller,
            numberOnly: true,
          ),
        ),
      ),
    ];
  }

  Widget _buildBody() {
    return WidgetScrollBar(
      child: SingleChildScrollView(
        child: Container(
          color: Interface.body,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              WidgetAppBar(
                tr("PLANNER"),
                context: context,
              ),
              ..._listLevel(),
              ..._listPlanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStack() {
    return Stack(
      children: [
        _buildBody(),
        if (_showDetail) _buildDetailedInformation(),
      ],
    );
  }

  Widget _buildWidgets() {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildStack(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
