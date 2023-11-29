// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/edit/logs.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
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
    _animals.sort((a, b) => a.getNameBasedOnReserve(context.locale, widget.reserveId).compareTo(b.getNameBasedOnReserve(context.locale, widget.reserveId)));
    _animals.sort((a, b) => a.level.compareTo(b.level));
  }

  Widget _buildWidgets() {
    _getAnimals();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          Animal animal = _animals[index];
          return EntryReserveAnimal(
              animalId: animal.id,
              reserveId: widget.reserveId,
              color: Interface.dark,
              background: Utils.background(index),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityDetailAnimal(animalId: animal.id, reserveId: widget.reserveId)));
              },
              onDismiss: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityEditLogs(
                              animalId: animal.id,
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
