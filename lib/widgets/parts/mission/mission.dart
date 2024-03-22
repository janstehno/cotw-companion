import 'package:cotwcompanion/activities/detail/mission.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/describable/mission.dart';
import 'package:cotwcompanion/widgets/parts/items/item.dart';
import 'package:cotwcompanion/widgets/tag/tag.dart';
import 'package:flutter/material.dart';

class WidgetMission extends StatelessWidget {
  final int _index;
  final Mission _mission;
  final Function _onTap;

  const WidgetMission(
    Mission mission, {
    super.key,
    required int i,
    required Function onTap,
  })  : _mission = mission,
        _index = i,
        _onTap = onTap;

  List<WidgetTag> _listTags() {
    return [
      WidgetTag.small(
        value: _mission.typeAsString,
        color: Interface.dark,
        background: Interface.tag,
      ),
      WidgetTag.small(
        value: _mission.difficultyAsString,
        color: Interface.alwaysDark,
        background: _mission.difficultyColor,
      ),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetItem(
      _index,
      text: _mission.name,
      tags: _listTags(),
      onTap: () {
        _onTap();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => ActivityDetailMission(_mission)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
