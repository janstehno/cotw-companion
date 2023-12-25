// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/proficiency.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetProficiencyDetail extends StatefulWidget {
  final Proficiency proficiency;
  final Function callback;

  const WidgetProficiencyDetail({
    Key? key,
    required this.proficiency,
    required this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WidgetProficiencyDetailState();
}

class WidgetProficiencyDetailState extends State<WidgetProficiencyDetail> {
  final double _levelSize = 20;

  double _screenWidth = 0;
  double _screenHeight = 0;

  void _getWidth() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  Widget _buildName() {
    return WidgetTitleBigButton(
      primaryText: widget.proficiency.getName(context.locale),
      secondaryText: widget.proficiency.isAbility ? tr("proficiency_active") : tr("proficiency_passive"),
      icon: "assets/graphics/icons/menu_close.svg",
      buttonColor: Interface.dark,
      buttonBackground: Colors.transparent,
      onTap: () {
        widget.callback();
      },
    );
  }

  Widget _buildLevels() {
    return Expanded(
      child: WidgetScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.proficiency.getDescription(context.locale).length,
                  itemBuilder: (context, index) {
                    String description = widget.proficiency.getDescription(context.locale)[index];
                    bool isLevelActive = widget.proficiency.isLevelActive(index + 1);
                    return _buildLevelDetail(description, isLevelActive, index + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelDetail(String description, bool isLevelActive, int level) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _levelSize,
            height: _levelSize,
            margin: const EdgeInsets.only(right: 7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isLevelActive ? Interface.primary : Interface.disabled.withOpacity(0.5),
            ),
            child: AutoSizeText(
              level.toString(),
              style: Interface.s12w500n(isLevelActive ? Interface.accent : Interface.disabled),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 1),
              child: AutoSizeText(
                description,
                style: Interface.s14w300n(Interface.dark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgets() {
    _getWidth();
    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Interface.body,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildName(),
          _buildLevels(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
