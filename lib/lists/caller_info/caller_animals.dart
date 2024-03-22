import 'package:collection/collection.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/model/translatable/caller.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/text/text_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListCallerAnimals extends StatelessWidget {
  final Caller _caller;

  const ListCallerAnimals(
    Caller caller, {
    super.key,
  }) : _caller = caller;

  List<Animal> get _animals => HelperJSON.getCallerAnimals(_caller.id);

  Widget _buildAnimal(BuildContext context, Animal animal) {
    return WidgetTextIndicator(
      animal.getNameByLocale(context.locale),
      indicatorColor: Interface.primary,
      isShown: animal.isFromDlc,
    );
  }

  Widget _buildWidgets(BuildContext context) {
    List<Animal> animals = _animals.sorted(Animal.sortByNameByLocale(context));

    return WidgetPadding.a30(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: animals.length,
        itemBuilder: (context, i) {
          return _buildAnimal(context, animals.elementAt(i));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
