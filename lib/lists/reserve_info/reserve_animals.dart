// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/info_animal.dart';
import 'package:cotwcompanion/activities/logs_add_edit.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/widgets/entries/reserve_animal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListReserveAnimals extends StatefulWidget {
  final int reserveId;

  const ListReserveAnimals({
    Key? key,
    required this.reserveId,
  }) : super(key: key);

  @override
  ListReserveAnimalsState createState() => ListReserveAnimalsState();
}

class ListReserveAnimalsState extends State<ListReserveAnimals> {
  late final List<Animal> _animals = [];

  void _getAnimals() {
    for (IdtoId iti in HelperJSON.animalsReserves) {
      if (iti.secondId == widget.reserveId) {
        for (Animal animal in HelperJSON.animals) {
          if (animal.id == iti.firstId) {
            _animals.add(animal);
            break;
          }
        }
      }
    }
    _animals.sort(
        (a, b) => a.getNameBasedOnReserve(context.locale, widget.reserveId).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserveId)));
    _animals.sort((a, b) => a.level.compareTo(b.level));
  }

  Widget _buildWidgets() {
    _getAnimals();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          int animalId = _animals[index].id;
          return EntryReserveAnimal(
              animalId: animalId,
              reserveId: widget.reserveId,
              color: Interface.dark,
              background: index % 2 == 0 ? Interface.even : Interface.odd,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityAnimalInfo(animalId: animalId)));
              },
              onDismiss: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityLogsAddEdit(
                              animalId: animalId,
                              reserveId: widget.reserveId,
                              callback: () {},
                              fromTrophyLodge: false,
                            )));
                return false;
              });
        });
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
