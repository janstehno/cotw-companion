import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/fur.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:flutter/material.dart';

class ListAnimalFursGO extends StatelessWidget {
  final Animal _animal;

  const ListAnimalFursGO(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  List<Fur> get _furs => _animal.furGO.map((e) => HelperJSON.getFur(e)!).sorted(Fur.sortByName);

  Widget _buildAnimalFur(Fur fur) {
    return WidgetText(
      fur.name,
      color: Interface.dark,
      style: Style.normal.s16.w300,
    );
  }

  List<Widget> _listFurs(BuildContext context) {
    return _furs.map((e) => _buildAnimalFur(e)).toList();
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetPadding.a30(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listFurs(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
