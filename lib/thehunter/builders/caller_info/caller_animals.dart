// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/widgets/entries/entry_with_dlc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderCallerAnimals extends StatefulWidget {
  final int callerID;

  const BuilderCallerAnimals({Key? key, required this.callerID}) : super(key: key);

  @override
  BuilderCallerAnimalsState createState() => BuilderCallerAnimalsState();
}

class BuilderCallerAnimalsState extends State<BuilderCallerAnimals> {
  late final List<Animal> _animals = [];

  _getAnimals() {
    _animals.clear();
    for (IDtoID iti in JSONHelper.animalsCallers) {
      if (iti.getSecondID == widget.callerID) {
        for (Animal a in JSONHelper.animals) {
          if (a.getID == iti.getFirstID) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    _animals.sort((a, b) => a.getName(context.locale).compareTo(b.getName(context.locale)));
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          Animal animal = _animals[index];
          return EntryWithDlc(text: animal.getName(context.locale), dlc: animal.getDlc);
        });
  }

  @override
  Widget build(BuildContext context) {
    _getAnimals();
    return _buildWidgets();
  }
}
