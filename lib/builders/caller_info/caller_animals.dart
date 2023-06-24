// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/text_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderCallerAnimals extends StatefulWidget {
  final int callerId;

  const BuilderCallerAnimals({
    Key? key,
    required this.callerId,
  }) : super(key: key);

  @override
  BuilderCallerAnimalsState createState() => BuilderCallerAnimalsState();
}

class BuilderCallerAnimalsState extends State<BuilderCallerAnimals> {
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
    _animals.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
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
            text: animal.getName(context.locale),
            dlc: animal.isFromDlc,
          );
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
