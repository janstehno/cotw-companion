import 'package:cotwcompanion/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/proficiency.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/parts/planner/proficiency.dart';
import 'package:flutter/material.dart';

abstract class ListProficiency<I extends Proficiency> extends StatefulWidget {
  final ProficiencyType _type;
  final HelperPlanner _helperPlanner;
  final int _availablePoints;
  final Function _rebuild, _showDetail;

  const ListProficiency(
    ProficiencyType type, {
    super.key,
    required HelperPlanner helperPlanner,
    required int availablePoints,
    required Function rebuild,
    required Function showDetail,
  })  : _type = type,
        _helperPlanner = helperPlanner,
        _availablePoints = availablePoints,
        _rebuild = rebuild,
        _showDetail = showDetail;

  ProficiencyType get type => _type;

  HelperPlanner get helperPlanner => _helperPlanner;

  int get availablePoints => _availablePoints;

  Function get rebuild => _rebuild;

  get showDetail => _showDetail;
}

abstract class ListProficiencyState<I extends Proficiency> extends State<ListProficiency> {
  Map<int, List<I>> get items;

  double _squareSize = 0;

  void _initializeSize() {
    int maxNumberOfColumns = 5;
    _squareSize =
        (MediaQuery.of(context).size.shortestSide - (2 * 5 * maxNumberOfColumns) - (2 * 30)) / maxNumberOfColumns;
  }

  bool _hasFourthColumn() => items[3]?.isNotEmpty ?? false;

  bool _hasFifthColumn() => items[4]?.isNotEmpty ?? false;

  Widget _buildProficiency(int tier, int i) {
    return WidgetProficiency<I>(
      helperPlanner: widget.helperPlanner,
      size: _squareSize,
      availablePoints: widget.availablePoints,
      proficiency: items[tier]!.elementAt(i),
      rebuild: widget.rebuild,
      showDetail: widget.showDetail,
    );
  }

  Widget _buildRow(int tier, int i) {
    bool render = false;
    int realIndex = i;
    int length = items[tier]!.length;
    if (length == 1 && i == 1) {
      render = true;
      realIndex = 0;
    } else if (length == 2 && (i == 0 || i == 2)) {
      render = true;
      realIndex = i == 2 ? 1 : 0;
    } else if (length == 3) {
      render = true;
    }
    if (render) {
      return _buildProficiency(tier, realIndex);
    }
    return Container(
      margin: const EdgeInsets.all(5),
      width: _squareSize,
      height: _squareSize,
    );
  }

  Widget _buildColumn(int tier) {
    return Column(
      children: [
        _buildRow(tier, 0),
        _buildRow(tier, 1),
        _buildRow(tier, 2),
      ],
    );
  }

  Widget _buildWidgets() {
    if (_squareSize <= 0) _initializeSize();
    return WidgetPadding.a30(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildColumn(0),
          _buildColumn(1),
          _buildColumn(2),
          if (_hasFourthColumn()) _buildColumn(3),
          if (_hasFifthColumn()) _buildColumn(4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
