import 'dart:math';

import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/button_link.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetRepositoryItem extends StatelessWidget {
  final int _index;
  final String _name;
  final String _url;
  final String _description;

  const WidgetRepositoryItem(
    int i, {
    super.key,
    required String name,
    required String url,
    required String description,
  })  : _index = i,
        _name = name,
        _url = url,
        _description = description;

  Widget _buildName() {
    return Container(
      alignment: Alignment.centerLeft,
      child: WidgetText(
        _name,
        color: Interface.dark,
        style: Style.normal.s16.w300,
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: WidgetButtonLink(
        tr("DETAILS"),
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () => Utils.redirectTo(Uri.parse(_url)),
      ),
    );
  }

  Widget _buildNameButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildName()),
        const SizedBox(width: 30),
        _buildButton(),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      child: WidgetText(
        "${_description.substring(0, min(_description.length, 150))}${_description.length < 150 ? "" : "..."}",
        color: Interface.grey,
        style: Style.normal.s12.w300,
        textAlign: TextAlign.start,
        maxLines: 4,
      ),
    );
  }

  Widget _buildWidgets() {
    return WidgetPadding.h30v20(
      background: Utils.backgroundAt(_index),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNameButton(),
          const SizedBox(height: 10),
          _buildDescription(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
