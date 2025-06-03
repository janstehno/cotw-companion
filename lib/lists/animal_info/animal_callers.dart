import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:cotwcompanion/widgets/title/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListAnimalCallers extends StatelessWidget {
  final Animal _animal;

  const ListAnimalCallers(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  List<Caller> get _callers => HelperJSON.getAnimalCallers(_animal).sorted(Caller.sortByName);

  Widget _buildCaller(Caller caller) {
    return WidgetTextIndicator(
      caller.name,
      indicatorColor: Interface.primary,
      isShown: caller.isFromDlc,
    );
  }

  List<Widget> _listCallers() {
    return _callers.map((e) => _buildCaller(e)).toList();
  }

  Widget _buildCallers() {
    return Column(children: _listCallers());
  }

  Widget _buildWidgets() {
    return Column(
      children: [
        if (_callers.isNotEmpty) WidgetTitle(tr("RECOMMENDED_CALLERS")),
        if (_callers.isNotEmpty) WidgetPadding.a30(child: _buildCallers()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
