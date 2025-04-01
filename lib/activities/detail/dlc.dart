import 'package:cotwcompanion/lists/dlc_info/dlc_content.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/describable/dlc.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/text/text_pattern.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailDlc extends StatelessWidget {
  final Dlc _dlc;

  const ActivityDetailDlc(
    Dlc dlc, {
    super.key,
  }) : _dlc = dlc;

  List<Widget> _listDescriptionParts() {
    return _dlc.description.map((e) => WidgetTextPattern(tr(e))).toList();
  }

  Widget _buildDescription() {
    return Column(
      children: [
        WidgetTitle(_dlc.date),
        WidgetPadding.a30(
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: _listDescriptionParts(),
          ),
        ),
      ],
    );
  }

  List<Widget> _listReserves() {
    return [
      WidgetTitle(tr("RESERVE")),
      WidgetPadding.a30(
        child: ListDlcContent(
          list: List.filled(1, _dlc.reserve!),
          type: Item.reserve,
        ),
      ),
    ];
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("WILDLIFE")),
      WidgetPadding.a30(
        child: ListDlcContent(
          list: _dlc.animals,
          type: Item.animal,
        ),
      ),
    ];
  }

  List<Widget> _listWeapons() {
    return [
      WidgetTitle(tr("WEAPONS")),
      WidgetPadding.a30(
        child: ListDlcContent(
          list: _dlc.weapons,
          type: Item.weapon,
        ),
      ),
    ];
  }

  List<Widget> _listCallers() {
    return [
      WidgetTitle(tr("CALLERS")),
      WidgetPadding.a30(
        child: ListDlcContent(
          list: _dlc.callers,
          type: Item.caller,
        ),
      ),
    ];
  }

  List<Widget> _listContent() {
    return [
      if (_dlc.reserve != null) ..._listReserves(),
      if (_dlc.animals.isNotEmpty) ..._listAnimals(),
      if (_dlc.weapons.isNotEmpty) ..._listWeapons(),
      if (_dlc.callers.isNotEmpty) ..._listCallers(),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _dlc.name,
        maxLines: _dlc.name.split(" ").length > 2 ? 2 : 1,
        context: context,
      ),
      children: [
        _buildDescription(),
        ..._listContent(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
