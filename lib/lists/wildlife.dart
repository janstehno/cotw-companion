// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:cotwcompanion/activities/filter.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/entries/animal.dart';
import 'package:cotwcompanion/widgets/filters/picker_auto.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListWildlife extends StatefulWidget {
  const ListWildlife({
    Key? key,
  }) : super(key: key);

  @override
  ListWildlifeState createState() => ListWildlifeState();
}

class ListWildlifeState extends State<ListWildlife> {
  final TextEditingController _controller = TextEditingController();
  final List<Animal> _animals = [];

  @override
  void initState() {
    _controller.addListener(() => _filter());
    super.initState();
  }

  void _focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _filter() {
    setState(() {
      _animals.clear();
      _animals.addAll(HelperFilter.filterAnimals(_controller.text, context));
    });
  }

  List<Widget> _buildFilters() {
    return [
      FilterPickerAuto(
        text: tr('animal_class'),
        icon: "assets/graphics/icons/level.svg",
        values: const [1, 2, 3, 4, 5, 6, 7, 8, 9],
        filterKey: FilterKey.animalsClass,
      ),
      FilterPickerAuto(
        text: tr('animal_difficulty'),
        icon: "assets/graphics/icons/difficulty.svg",
        values: const [3, 5, 9],
        filterKey: FilterKey.animalsDifficulty,
      ),
    ];
  }

  void _buildFilter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityFilter(filters: _buildFilters(), filter: _filter)));
  }

  Widget _buildList() {
    _filter();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          return EntryAnimal(index: index, animal: _animals[index], callback: _focus);
        });
  }

  Widget _buildWidgets() {
    return WidgetScaffold(
      appBar: WidgetAppBar(
        text: tr('wildlife'),
        context: context,
      ),
      searchController: _controller,
      filter: _buildFilter,
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
