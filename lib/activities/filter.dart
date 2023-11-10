// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFilter extends StatefulWidget {
  final List<Widget> filters;
  final Function filter;

  const ActivityFilter({
    Key? key,
    required this.filters,
    required this.filter,
  }) : super(key: key);

  @override
  ActivityFilterState createState() => ActivityFilterState();
}

class ActivityFilterState extends State<ActivityFilter> {
  final double _topBarHeight = 90;
  final double _buttonSize = 50;

  Widget _buildFilters() {
    return Column(children: [
      Container(
          height: _topBarHeight,
          color: Interface.primary,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: Row(children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: AutoSizeText(
                      tr('filter').toUpperCase(),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: Interface.s24w600c(Interface.accent),
                    ))),
            WidgetButtonIcon(
              buttonSize: _buttonSize,
              icon: "assets/graphics/icons/accept.svg",
              onTap: () {
                widget.filter();
                Navigator.pop(context);
              },
            )
          ])),
      Expanded(
          child: WidgetScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: widget.filters,
          ),
        ),
      )),
    ]);
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      customBody: true,
      body: _buildFilters(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
