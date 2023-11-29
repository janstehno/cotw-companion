// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListCallerAnimals extends StatefulWidget {
  final int callerId;

  const ListCallerAnimals({
    Key? key,
    required this.callerId,
  }) : super(key: key);

  @override
  ListCallerAnimalsState createState() => ListCallerAnimalsState();
}

class ListCallerAnimalsState extends State<ListCallerAnimals> {
  late final List<Animal> _animals = [];

  void _getAnimals() {
    _animals.clear();
    for (IdtoId iti in HelperJSON.animalsCallers) {
      if (iti.secondId == widget.callerId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == iti.firstId) {
            _animals.add(animal);
            break;
          }
        }
      }
    }
    _animals.sort((a, b) => a.getNameByLocale(context.locale).compareTo(b.getNameByLocale(context.locale)));
  }

  Widget _buildWidgets() {
    _getAnimals();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          Animal animal = _animals[index];
          return WidgetTextDlc(
            text: animal.getNameByLocale(context.locale),
            dlc: animal.isFromDlc,
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
