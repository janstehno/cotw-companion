// Copyright (c) 2022 Jan Stehno

import 'package:cotwcompanion/helpers/helper_json.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/activities/add_edit_log.dart';
import 'package:cotwcompanion/thehunter/activities/animal_info.dart';
import 'package:cotwcompanion/thehunter/model/animal.dart';
import 'package:cotwcompanion/thehunter/model/idtoid.dart';
import 'package:cotwcompanion/thehunter/widgets/reserve_animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuilderReserveAnimals extends StatefulWidget {
  final int reserveID;

  const BuilderReserveAnimals({Key? key, required this.reserveID}) : super(key: key);

  @override
  BuilderReserveAnimalsState createState() => BuilderReserveAnimalsState();
}

class BuilderReserveAnimalsState extends State<BuilderReserveAnimals> {
  late final List<Animal> _animals = [];

  _getAnimals() {
    for (IDtoID ar in JSONHelper.animalsReserves) {
      if (ar.getSecondID == widget.reserveID) {
        for (Animal a in JSONHelper.animals) {
          if (a.getID == ar.getFirstID) {
            _animals.add(a);
            break;
          }
        }
      }
    }
    _animals.sort((a, b) => a.getNameBasedOnReserve(context.locale, widget.reserveID).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserveID)));
    _animals.sort((a, b) => a.getLevel.compareTo(b.getLevel));
  }

  Widget _buildWidgets() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          int animalID = _animals[index].getID;
          return EntryReserveAnimal(
              background: index % 2 == 0 ? Values.colorEven : Values.colorOdd,
              color: Values.colorDark,
              animalID: animalID,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalID: animalID)));
              },
              onDismiss: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityLogsAddEdit(animalID: animalID, reserveID: widget.reserveID, callback: () {}, fromTrophyLodge: false)));
                return false;
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    _getAnimals();
    return _buildWidgets();
  }
}
