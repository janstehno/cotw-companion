import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_animals.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_callers.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_environment.dart';
import 'package:cotwcompanion/lists/reserve_info/reserve_missions.dart';
import 'package:cotwcompanion/model/translatable/reserve.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/scaffold.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:cotwcompanion/widgets/title/title_button_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityDetailReserve extends StatelessWidget {
  final Reserve _reserve;

  const ActivityDetailReserve(
    Reserve reserve, {
    super.key,
  }) : _reserve = reserve;

  Widget _buildMap(BuildContext context) {
    return WidgetTitleButtonIcon(
      tr("MAP"),
      icon: Assets.graphics.icons.map,
      alignRight: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => BuilderMap(reserve: _reserve)),
        );
      },
    );
  }

  Widget _buildMissions(BuildContext context) {
    return WidgetTitleButtonIcon(
      tr("MISSIONS"),
      icon: Assets.graphics.icons.missions,
      alignRight: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => ListReserveMissions(_reserve)),
        );
      },
    );
  }

  List<Widget> _listEnvironment() {
    return [
      WidgetTitle(tr("ENVIRONMENT")),
      ListReserveEnvironment(_reserve),
    ];
  }

  List<Widget> _listAnimals() {
    return [
      WidgetTitle(tr("WILDLIFE")),
      ListReserveAnimals(_reserve),
    ];
  }

  List<Widget> _listCallers() {
    return [
      WidgetTitle(tr("CALLERS")),
      ListReserveCallers(_reserve),
    ];
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        _reserve.name,
        context: context,
      ),
      children: [
        _buildMap(context),
        ..._listEnvironment(),
        _buildMissions(context),
        ..._listAnimals(),
        ..._listCallers(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
