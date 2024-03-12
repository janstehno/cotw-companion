// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/lists/planner/proficiency.dart';
import 'package:cotwcompanion/miscellaneous/helpers/planner.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/proficiency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class EntryProficiency extends StatefulWidget {
  final HelperPlanner helperPlanner;
  final double size;
  final int availablePoints;
  final Proficiency proficiency;
  final Function refresh, showDetail;

  const EntryProficiency({
    Key? key,
    required this.helperPlanner,
    required this.size,
    required this.availablePoints,
    required this.proficiency,
    required this.refresh,
    required this.showDetail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EntryProficiencyState();
}

class EntryProficiencyState extends State<EntryProficiency> {
  final double _levelSize = 5;

  bool isUnlocked() {
    return false;
  }

  bool isUsable() {
    return false;
  }

  String getIcon() {
    return "";
  }

  Widget _buildIcon() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(widget.size / 10),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              getIcon(),
              colorFilter: ColorFilter.mode(
                isUnlocked() ? Interface.dark : Interface.disabled.withOpacity(0.35),
                BlendMode.srcIn,
              ),
            ),
            isUnlocked()
                ? const SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    child: SimpleShadow(
                      sigma: 5,
                      color: Interface.shadow,
                      offset: const Offset(0, 0),
                      child: SvgPicture.asset(
                        "assets/graphics/icons/lock.svg",
                        width: widget.size / 5,
                        height: widget.size / 5,
                        colorFilter: const ColorFilter.mode(
                          Interface.red,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevels() {
    return Container(
      width: widget.size,
      height: _levelSize * 2,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: _levelSize),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.proficiency.level,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _levelSize,
            height: _levelSize,
            margin: const EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_levelSize),
              color: widget.proficiency.isLevelActive(index + 1) ? Interface.primary : Interface.disabled.withOpacity(0.35),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWidgets() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isUnlocked() && isUsable()) {
            widget.proficiency.addLevel();
            widget.refresh();
          }
        });
      },
      onLongPress: () {
        widget.showDetail(widget.proficiency);
      },
      child: Container(
        margin: const EdgeInsets.all(ListProficiencyState.innerMargin),
        width: widget.size,
        height: widget.size,
        alignment: Alignment.center,
        child: Column(
          children: [
            _buildIcon(),
            _buildLevels(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
