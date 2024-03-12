// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/model/proficiency.dart';
import 'package:cotwcompanion/widgets/entries/planner/proficiency.dart';
import 'package:flutter/material.dart';

abstract class ListProficiency extends StatefulWidget {
  final ProficiencyType type;
  final HelperPlanner helperPlanner;
  final int availablePoints;
  final Function refresh, showDetail;

  const ListProficiency({
    Key? key,
    required this.type,
    required this.helperPlanner,
    required this.availablePoints,
    required this.refresh,
    required this.showDetail,
  }) : super(key: key);
}

abstract class ListProficiencyState extends State<ListProficiency> {
  static const double innerMargin = 5;
  final double _outerMargin = 30;
  final int _maxNumberOfColumns = 5;

  late Map<int, List<Proficiency>> items = {};

  double squareSize = 0;

  void _getSquareSize(Orientation orientation) {
    squareSize = (MediaQuery.of(context).size.shortestSide - (2 * innerMargin * _maxNumberOfColumns) - (2 * _outerMargin)) / _maxNumberOfColumns;
  }

  void getList() {}

  bool _hasFourthColumn() => items[3]?.isNotEmpty ?? false;

  bool _hasFifthColumn() => items[4]?.isNotEmpty ?? false;

  Widget buildProficiency(int tier, int index) {
    return EntryProficiency(
      helperPlanner: widget.helperPlanner,
      size: squareSize,
      availablePoints: widget.availablePoints,
      proficiency: items[tier]!.elementAt(index),
      refresh: widget.refresh,
      showDetail: widget.showDetail,
    );
  }

  Widget _buildRow(int tier, int index) {
    bool render = false;
    int realIndex = index;
    int length = items[tier]!.length;
    if (length == 1 && index == 1) {
      render = true;
      realIndex = 0;
    } else if (length == 2 && (index == 0 || index == 2)) {
      render = true;
      realIndex = index == 2 ? 1 : 0;
    } else if (length == 3) {
      render = true;
    }
    return render
        ? buildProficiency(tier, realIndex)
        : Container(
            margin: const EdgeInsets.all(innerMargin),
            width: squareSize,
            height: squareSize,
          );
  }

  Widget _buildColumn(int tier) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildRow(tier, 0),
        _buildRow(tier, 1),
        _buildRow(tier, 2),
      ],
    );
  }

  Widget _buildWidgets() {
    return OrientationBuilder(builder: (context, orientation) {
      _getSquareSize(orientation);
      getList();
      return Container(
          margin: EdgeInsets.all(_outerMargin),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildColumn(0),
              _buildColumn(1),
              _buildColumn(2),
              if (_hasFourthColumn()) _buildColumn(3),
              if (_hasFifthColumn()) _buildColumn(4),
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
